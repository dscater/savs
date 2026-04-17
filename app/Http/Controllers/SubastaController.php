<?php

namespace App\Http\Controllers;

use App\Http\Requests\SubastaStoreRequest;
use App\Http\Requests\SubastaUpdateRequest;
use App\Models\Configuracion;
use App\Models\Notificacion;
use App\Models\Participante;
use App\Models\Subasta;
use App\Services\NotificacionUserService;
use App\Services\SubastaService;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Response;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;
use Inertia\Response as ResponseInertia;

class SubastaController extends Controller
{
    public function __construct(private SubastaService $subastaService, private NotificacionUserService $notificacion_user_service) {}

    /**
     * Página index
     *
     * @return Response
     */
    public function index(): ResponseInertia
    {
        return Inertia::render("Admin/Subastas/Index");
    }

    /**
     * Listado de subastas sin ids: 1 y 2
     *
     * @return JsonResponse
     */
    public function listado(): JsonResponse
    {
        return response()->JSON([
            "subastas" => $this->subastaService->listado()
        ]);
    }

    public function portal(Request $request)
    {
        $this->subastaService->actualizaPublicacionesEstado();
        $subastas = Subasta::with(["producto.producto_imagens", "participantes_puja", "participante_pujas"])
            ->select("subastas.*")
            ->whereIn("estado_subasta", [0, 1, 2])
            ->orderBy("created_at", "desc")
            ->paginate(8);

        return response()->JSON([
            "subastas" => $subastas,
        ]);
    }

    public function paginado(Request $request)
    {
        $perPage = $request->perPage;
        $page = (int)($request->input("page", 1));
        $search = (string)$request->input("search", "");
        $orderBy = $request->orderBy;
        $orderAsc = $request->orderAsc;

        $columnsSerachLike = [
            "codigo",
            "modelo",
            "marca",
            "talla",
            "nombre"
        ];
        $columnsFilter = [];
        $columnsBetweenFilter = [];
        $arrayOrderBy = [];
        if ($orderBy && $orderAsc) {
            $arrayOrderBy = [
                [$orderBy, $orderAsc]
            ];
        }

        $subastas = $this->subastaService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $subastas->items(),
            "total" => $subastas->total(),
            "lastPage" => $subastas->lastPage()
        ]);
    }

    public function create()
    {
        return Inertia::render("Admin/Subastas/Create");
    }

    /**
     * Registrar un nuevo subasta
     *
     * @param SubastaStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(SubastaStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            // crear el Subasta
            $this->subastaService->crear($request->validated());
            DB::commit();
            return redirect()->route("subastas.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Mostrar un subasta
     *
     * @param Subasta $subasta
     * @return JsonResponse
     */
    public function show(Subasta $subasta): JsonResponse
    {
        return response()->JSON($subasta);
    }

    public function edit(Subasta $subasta)
    {
        $subasta = $subasta->load(["producto.producto_imagens", "producto.categoria"]);
        return Inertia::render("Admin/Subastas/Edit", compact("subasta"));
    }

    public function update(Subasta $subasta, SubastaUpdateRequest $request)
    {
        DB::beginTransaction();
        try {
            // actualizar subasta
            $this->subastaService->actualizar($request->validated(), $subasta);
            DB::commit();
            return redirect()->route("subastas.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Eliminar subasta
     *
     * @param Subasta $subasta
     * @return JsonResponse|Response
     */
    public function destroy(Subasta $subasta): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->subastaService->eliminar($subasta);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'message' => 'El registro se eliminó correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    // PORTAL-SUBASTAS
    public function verificaGanador(Subasta $subasta)
    {
        if ($subasta && count($subasta->participantes) > 0) {
            $ganador = Participante::where("subasta_id", $subasta->id)
                ->where("estado", 2)->get()->first();
            if (!$ganador) {
                $participante = null;
                $participantes = $subasta->participantes_puja;
                $subasta->estado_subasta = 2;
                $participante = $participantes[0];
                $participante->estado_puja = 2;
                $participante->save();
                if (count($participantes) <= 0) {
                    // sin ganador
                    $subasta->estado_subasta = 0;
                }

                // enviar mensaje ganador
                // enviar correo
                $parametrizacion = Parametrizacion::first();
                if ($parametrizacion) {
                    $servidor_correo = $parametrizacion->servidor_correo;
                    Config::set(
                        [
                            'mail.default' => $servidor_correo["driver"],
                            'mail.mailers.smtp.host' => $servidor_correo["host"],
                            'mail.mailers.smtp.port' => $servidor_correo["puerto"],
                            'mail.mailers.smtp.encryption' => $servidor_correo["encriptado"],
                            'mail.mailers.smtp.username' => $servidor_correo["correo"],
                            'mail.mailers.smtp.password' => $servidor_correo["password"],
                            'mail.from.address' => $servidor_correo["correo"],
                            'mail.from.name' => $servidor_correo["nombre"],
                        ]
                    );

                    $url =  route('subastas.subastaPortal', $subasta->id);
                    $configuracion = Configuracion::first();
                    $mensaje = 'La Subasta fue concluida. ' . $configuracion->razon_social . ' se contactará con usted para comunicarle detalles del resultado de la subasta. Puedes ver la publicación  <a href="' . $url . '">aquí</a>';
                    $datos = [
                        "mensaje" =>  $mensaje,
                    ];

                    Mail::to($participante->cliente->email)
                        ->send(new MensajeGanadorMail($datos));
                }

                $subasta->save();
            } else {
                $participante = $ganador;
            }

            return response()->JSON([
                "participante" => $participante->load(["participante_pujas"]),
                "subasta" => $subasta->load(["producto.producto_imagens", "participantes_puja"])
            ]);
        } else {
            // sin ganador
            $subasta->estado_subasta = 0;
            $subasta->save();
        }

        return response()->JSON([
            "participante" => null,
            "subasta" => $subasta->load(["producto.producto_imagens", "participantes_puja"])
        ]);
    }


    public function registrarPuja(Request $request)
    {
        $request->validate([
            "monto_puja" => "required|int"
        ], [
            "monto_puja.required" => "Debes ingresar un monto de puja",
            "monto_puja.int" => "Debes ingresar un valor entero",
        ]);

        $participante_id = $request->participante_id;
        $monto_puja = $request->monto_puja;
        $participante = Participante::find($participante_id);
        $subasta = $participante->subasta;

        // validar limite fecha subasta
        $fecha_hora_fin = date("Y-m-d H:i", strtotime($subasta->fecha_fin . ' ' . $subasta->hora_fin));
        $fecha_hora_actual = date("Y-m-d H:i");

        DB::beginTransaction();
        try {
            if ($this->subastaService->verificaFechaLimitePublicacion($subasta)) {
                // actualizar ganador
                DB::update("UPDATE participantes SET estado = 0 WHERE subasta_id = $subasta->id");
                // $subasta->participantes()->update(["estado_puja" => 0]);

                // verificar monto
                $monto_puja_actual = SubastaController::getMontoPujaActual($subasta);
                $monto_validacion = $monto_puja_actual;
                if ($monto_puja_actual > -1) {
                    if (count($subasta->participantes_puja) > 0) {
                        $monto_validacion++;
                    }
                    $mensaje = "El monto debe ser mayor o igual a " . number_format($monto_validacion, 2, ".", ",") . " " . $subasta->moneda;
                    if (!$monto_puja || $monto_puja < $monto_validacion) {
                        return response()->JSON([
                            "message" => "Debes ingresar un monto valido. " . $mensaje
                        ], 422);
                    }
                } else {
                    return response()->JSON([
                        "message" => "Ocurrió un error al registrar la puja, intente de nuevo por favor"
                    ], 422);
                }

                $participante->update([
                    "monto_puja" => $monto_puja,
                    // "fecha_oferta" => date("Y-m-d"),
                    // "hora_oferta" => date("H:i"),
                ]);


                $maxima_puja = Participante::where("subasta_id", $subasta->id)->orderBy("monto_puja", "desc")->get()->first();
                $maxima_puja->estado = 1;
                $maxima_puja->save();

                // AGREAR AL HISTORIAL
                $participante->participante_pujas()->create([
                    "subasta_id" => $participante->subasta_id,
                    "user_id" => $participante->user_id,
                    "monto" => $monto_puja,
                    "fecha" => date("Y-m-d"),
                    "hora" => date("H:i:s"),
                ]);
                DB::commit();
                return response()->JSON([
                    "subasta" => $subasta->load(["producto.producto_imagens", "participantes_puja"]),
                    "participante" => $participante->load(["participante_pujas"])
                ]);
            }
        } catch (\Exception $e) {
            Log::debug("ERROR:\n");
            Log::debug($e->getMessage());
            DB::rollBack();
            return response()->JSON([
                "message" => $e->getMessage()
            ], $e->getCode());
        }
    }

    public function registrarComprobante(Request $request)
    {
        $request->validate([
            "comprobante" => "required|file|mimes:pdf,jpg,jpeg,webp,png|max:5120"
        ], [
            "comprobante.required" => "Debes cargar tú comprobante de pago",
            "comprobante.file" => "Debes cargar un archivo",
            "comprobante.mimes" => "Archivos soportados: pdf, jpg, jpeg, webp, png",
            "comprobante.max" => "El archivo no puede pesar mas de 5MB",
        ]);

        DB::beginTransaction();
        try {
            $subasta_id = $request->publicacion_id;
            $subasta = Subasta::find($subasta_id);
            $user = Auth::user();
            if ($user->tipo == 'PARTICIPANTE' && $this->subastaService->verificaFechaLimitePublicacion($subasta)) {
                $comprobante = $request->comprobante;
                $participante_id = null;
                $participante = null;
                $eliminar_archivo = null;
                if (isset($request->participante_id)) {
                    $participante_id = $request->participante_id;
                    $participante = Participante::findOrFail($participante_id);
                    $eliminar_archivo = $participante->comprobante;
                }

                $extension = "." . $comprobante->getClientOriginalExtension();
                $nom_file = $user->id . time() . $extension;

                if (!$participante) {
                    $participante = $subasta->participantes()->create([
                        "user_id" => $user->id,
                        "garantia" => 1,
                        "monto_puja" => 0,
                        "comprobante" => $nom_file,
                        "estado_comprobante" => 0,
                        "estado" => 0,
                        "fecha_comprobante" => date("Y-m-d"),
                        "hora_comprobante" => date("H:i:s"),
                        "fecha" => date("Y-m-d"),
                        "hora" => date("H:i:s")
                    ]);
                } else {
                    $participante->update([
                        "garantia" => 1,
                        "comprobante" => $nom_file,
                        "estado_comprobante" => 0,
                        "estado" => 0,
                        "fecha_comprobante" => date("Y-m-d"),
                        "hora_comprobante" => date("H:i:s")
                    ]);
                }

                $comprobante->move(public_path("files/comprobantes"), $nom_file);

                if ($eliminar_archivo) {
                    \File::delete(public_path("imgs/publicacions/" . $eliminar_archivo));
                }

                // REGISTRAR NOTIFICACION
                $notificacion = Notificacion::create([
                    "descripcion" => $user->full_name . " REGISTRO SU COMPROBANTE",
                    "fecha" => date("Y-m-d"),
                    "hora" => date("H:i"),
                    "modulo" => "Participante",
                    "registro_id" => $participante->id,
                    "tipo" => "COMPROBANTE",
                ]);


                // notificacion_user
                $this->notificacion_user_service->crearNotificacionUsers($notificacion->id, ["ADMINISTRADOR", "AUXILIAR"]);

                DB::commit();

                return response()->JSON([
                    "participante" => $participante->load(["user", "subasta"]),
                    "message" => "Comprobante registrado, podra hacer una puja cuando su comprobante sea verificado"
                ], 200);
            } else {
                throw new Exception("El role de usuario que tiene no puede realizar ofertas/pujas sobre las publicaciones", 400);
            }
        } catch (\Exception $e) {
            Log::debug($e->getMessage());
            DB::rollBack();
            return response()->JSON([
                "message" => $e->getMessage()
            ], $e->getCode());
        }
    }

    public function infoSubastaPorPublicacion(Request $request)
    {
        $monto_puja_actual = "-";
        $subasta_id = $request->publicacion_id;
        $subasta = null;
        $subasta = Subasta::find($subasta_id);
        if ($subasta) {
            $monto_puja_actual = SubastaController::getMontoPujaActual($subasta);
        }
        return response()->JSON([
            "monto_puja_actual" => $monto_puja_actual,
            "subasta" => $subasta->load(["participantes_puja"]),
        ]);
    }

    public static function getMontoPujaActual($subasta)
    {
        $monto_puja_actual = -1;
        if ($subasta) {
            $monto_puja_actual = $subasta->monto_inicial;
            // verificar pujas
            $max_participantes = Participante::where("subasta_id", $subasta->id)
                ->where("monto_puja", ">", 0)
                ->where("estado_comprobante", 1)
                ->orderBy("monto_puja", "desc")
                ->get()->first();
            if ($max_participantes) {
                $monto_puja_actual = $max_participantes->monto_puja;
            }
        }
        return $monto_puja_actual;
    }

    public function ofertas(Subasta $subasta)
    {
        $participantes = Participante::where("subasta_id", $subasta->id)
            ->where("estado_comprobante", 1)
            ->where("monto_puja", ">", 0)
            ->orderBy("monto_puja", "desc")
            ->get()->take(10);

        $participante_pujas = HistorialOferta::where("subasta_id", $subasta->id)
            ->orderBy("monto_puja", "desc")
            ->get()->take(10);

        $estado_puja = null;
        if (Auth::check() && Auth::user()->role_id == 2) {
            $participante = Participante::where("subasta_id", $subasta->id)
                // ->where("estado_comprobante", 1)
                ->where("cliente_id", Auth::user()->cliente->id)
                ->get()->first();
            // Log::debug($participante);
            if ($participante) {
                $estado_puja = $participante->estado_puja;
            }
        }

        return response()->JSON([
            "participante_pujas" => $participante_pujas,
            "participantes" => $participantes,
            "estado_puja" => $estado_puja
        ]);
    }

    public function participantes(Subasta $subasta)
    {
        $subasta->load(["producto.producto_imagens"]);
        return Inertia::render("Admin/Subastas/Participantes", compact("subasta"));
    }

    public function getParticipantesApi(Request $request, Subasta $subasta)
    {
        // $length = $request->input('length', 10); // Valor de `length` enviado por DataTable
        // $start = $request->input('start', 0); // Índice de inicio enviado por DataTable
        // $page = ($start / $length) + 1; // Cálculo de la página actual
        $search = $request->input('search');
        $lastId = $request->input('lastId');
        $maxima_puja = $request->input("maxima_puja");
        $consulta_publicacions = Participante::with(["subasta", "user.user_dato"])->select("participantes.*");
        // if ($search && trim($search) != '') {
        //     $consulta_publicacions->where("nombre", "LIKE", "%$search%");
        // }

        $consulta_publicacions->where("subasta_id", $subasta->id);
        // datos para validar si se obtendra los registros
        $subastas_id  = $consulta_publicacions->orderBy("participantes.id", "desc")
            ->get();
        $subastas_puja  = $consulta_publicacions->max("monto_puja");
        $total = count($subastas_id);
        $maxima_puja = $total > 0 ? (float)$subastas_puja : $maxima_puja;
        $lastIdPub = $total > 0 ? $subastas_id[0]->id : $lastId;

        // obtener los registros a mostrar
        if ($lastId != 0 && $maxima_puja == 0) {
            $consulta_publicacions->where("id", ">", $lastId);
        }

        $subastas = $consulta_publicacions->orderBy("participantes.estado", "desc")
            ->orderBy("participantes.monto_puja", "desc")
            ->get();

        $lastId = $lastIdPub;

        return response()->JSON(
            [
                "lastId" => $lastId,
                "maxima_puja" => $maxima_puja,
                "subastas" => $subastas
            ]
        );

        // return response()->JSON([
        //     'data' => $subastas->items(),
        //     'recordsTotal' => $subastas->total(),
        //     'recordsFiltered' => $subastas->total(),
        //     'draw' => intval($request->input('draw')),
        // ]);
    }
}
