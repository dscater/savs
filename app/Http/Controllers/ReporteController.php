<?php

namespace App\Http\Controllers;

use App\Models\Catalogo;
use App\Models\Configuracion;
use App\Models\HistorialAccion;
use App\Models\Inscripcion;
use App\Models\User;
use App\Models\Visitante;
use App\Services\ReporteService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;
use PDF;
use Carbon\Carbon;
use FPDF;
use Illuminate\Support\Facades\DB;
use PhpOffice\PhpSpreadsheet\IOFactory;
use PhpOffice\PhpSpreadsheet\Spreadsheet;

class ReporteController extends Controller
{
    public $titulo = [
        'font' => [
            'bold' => true,
            'size' => 12,
            'family' => 'Times New Roman'
        ],
        'borders' => [
            'allBorders' => [
                'borderStyle' => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_NONE,
            ],
        ],
    ];

    public $textoBold = [
        'font' => [
            'bold' => true,
            'size' => 10,
        ],
    ];

    public $headerTabla = [
        'font' => [
            'bold' => true,
            'size' => 10,
            'color' => ['argb' => 'ffffff'],
        ],
        'alignment' => [
            'vertical' => \PhpOffice\PhpSpreadsheet\Style\Alignment::VERTICAL_CENTER,
        ],
        'borders' => [
            'allBorders' => [
                'borderStyle' => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN,
            ],
        ],
        'fill' => [
            'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
            'color' => ['rgb' => '203764']
        ],
    ];

    public $headerTabla2 = [
        'font' => [
            'bold' => true,
            'size' => 10,
            'color' => ['argb' => '000000'],
        ],
        'alignment' => [
            'vertical' => \PhpOffice\PhpSpreadsheet\Style\Alignment::VERTICAL_CENTER,
        ],
        'borders' => [
            'allBorders' => [
                'borderStyle' => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN,
            ],
        ],
    ];

    public $bodyTabla = [
        'font' => [
            'size' => 10,
        ],
        'alignment' => [
            'vertical' => \PhpOffice\PhpSpreadsheet\Style\Alignment::VERTICAL_CENTER,
            // 'horizontal' => \PhpOffice\PhpSpreadsheet\Style\Alignment::HORIZONTAL_CENTER,
        ],
        'borders' => [
            'allBorders' => [
                'borderStyle' => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN,
            ],
        ],
    ];

    public $textLeft = [
        'alignment' => [
            'horizontal' => \PhpOffice\PhpSpreadsheet\Style\Alignment::HORIZONTAL_LEFT,
        ],
    ];

    public $textRight = [
        'alignment' => [
            'horizontal' => \PhpOffice\PhpSpreadsheet\Style\Alignment::HORIZONTAL_RIGHT,
        ],
    ];

    public $textCenter = [
        'alignment' => [
            'horizontal' => \PhpOffice\PhpSpreadsheet\Style\Alignment::HORIZONTAL_CENTER,
        ],
    ];

    public $bg0 = [
        'fill' => [
            'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
            'color' => ['rgb' => 'cff3f3']
        ],
    ];

    public $bg1 = [
        'fill' => [
            'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
            'color' => ['rgb' => 'ffe9ff']
        ],
    ];

    public $bg2 = [
        'fill' => [
            'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
            'color' => ['rgb' => 'f7ffe0']
        ],
    ];

    public $bg3 = [
        'fill' => [
            'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
            'color' => ['rgb' => 'ecfcdd']
        ],
    ];

    public $bg4 = [
        'fill' => [
            'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
            'color' => ['rgb' => 'faeee4']
        ],
    ];

    protected array $bgStyles = [];
    private $configuracion = null;
    public function __construct()
    {
        $this->configuracion = Configuracion::first();
        if (!$this->configuracion) {
            $this->configuracion = new Configuracion([
                "nombre_sistema" => "SISTEMA CDA",
                "alias" => "SP",
                "logo" => "logo.png",
                "fono" => "2222222",
                "dir" => "LOS OLIVOS",
            ]);
        }
    }

    public function usuarios()
    {
        return Inertia::render("Admin/Reportes/Usuarios");
    }

    public function r_usuarios(Request $request)
    {
        ini_set('memory_limit', '1024M');
        set_time_limit(-1);
        $tipo =  $request->tipo;
        $formato =  $request->formato;
        $usuarios = User::select("users.*")
            ->where('id', '!=', 1);

        if ($tipo != 'todos') {
            $request->validate([
                'tipo' => 'required',
            ]);
            $usuarios->where('tipo', $tipo);
        }

        $usuarios = $usuarios->orderBy("paterno", "ASC")->get();

        if ($formato == 'pdf') {

            $pdf = PDF::loadView('reportes.usuarios', compact('usuarios'))->setPaper('legal', 'landscape');

            // ENUMERAR LAS PÁGINAS USANDO CANVAS
            $pdf->output();
            $dom_pdf = $pdf->getDomPDF();
            $canvas = $dom_pdf->get_canvas();
            $alto = $canvas->get_height();
            $ancho = $canvas->get_width();
            $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

            return $pdf->stream('usuarios.pdf');
        } else {
            $spreadsheet = new Spreadsheet();
            $spreadsheet->getProperties()
                ->setCreator("ADMIN")
                ->setLastModifiedBy('Administración')
                ->setTitle('Registros')
                ->setSubject('Registros')
                ->setDescription('Registros')
                ->setKeywords('PHPSpreadsheet')
                ->setCategory('Listado');

            $sheet = $spreadsheet->getActiveSheet();

            $spreadsheet->getDefaultStyle()->getFont()->setName('Arial');

            $fila = 1;
            if (file_exists(public_path() . '/imgs/' . $this->configuracion->logo)) {
                $drawing = new \PhpOffice\PhpSpreadsheet\Worksheet\Drawing();
                $drawing->setName('logo');
                $drawing->setDescription('logo');
                $drawing->setPath(public_path() . '/imgs/' . $this->configuracion->logo); // put your path and image here
                $drawing->setCoordinates('A' . $fila);
                $drawing->setOffsetX(5);
                $drawing->setOffsetY(0);
                $drawing->setHeight(60);
                $drawing->setWorksheet($sheet);
            }

            $fila = 2;
            $sheet->setCellValue('A' . $fila, $this->configuracion->nombre_sistema);
            $sheet->mergeCells("A" . $fila . ":I" . $fila);  //COMBINAR CELDAS
            $sheet->getStyle('A' . $fila . ':I' . $fila)->getAlignment()->setHorizontal('center');
            $sheet->getStyle('A' . $fila . ':I' . $fila)->applyFromArray($this->titulo);
            $fila++;
            $sheet->setCellValue('A' . $fila, "LISTA DE USUARIOS");
            $sheet->mergeCells("A" . $fila . ":I" . $fila);  //COMBINAR CELDAS
            $sheet->getStyle('A' . $fila . ':I' . $fila)->getAlignment()->setHorizontal('center');
            $sheet->getStyle('A' . $fila . ':I' . $fila)->applyFromArray($this->titulo);
            $fila++;
            $fila++;
            $sheet->setCellValue('A' . $fila, 'N°');
            $sheet->setCellValue('B' . $fila, 'PATERNO');
            $sheet->setCellValue('C' . $fila, 'MATERNO');
            $sheet->setCellValue('D' . $fila, 'NOMBRE(S)');
            $sheet->setCellValue('E' . $fila, 'CORREO');
            $sheet->setCellValue('F' . $fila, 'TELÉFONO/CELULAR');
            $sheet->setCellValue('G' . $fila, 'TIPO');
            $sheet->setCellValue('H' . $fila, 'ACCESO');
            $sheet->setCellValue('I' . $fila, 'FECHA DE REGISTRO');
            $sheet->getStyle('A' . $fila . ':I' . $fila)->applyFromArray($this->headerTabla);
            $fila++;

            foreach ($usuarios as $key => $item) {
                $sheet->setCellValue('A' . $fila, $key + 1);
                $sheet->setCellValue('B' . $fila, $item->paterno);
                $sheet->setCellValue('C' . $fila, $item->materno);
                $sheet->setCellValue('D' . $fila, $item->nombre);
                $sheet->setCellValue('E' . $fila, $item->correo);
                $sheet->setCellValue('F' . $fila, $item->fono);
                $sheet->setCellValue('G' . $fila, $item->tipo);
                $sheet->setCellValue('H' . $fila, $item->acceso == 1 ? 'HABILITADO' : 'DENEGADO');
                $sheet->setCellValue('I' . $fila, $item->fecha_registro_t);
                $sheet->getStyle('A' . $fila . ':I' . $fila)->applyFromArray($this->bodyTabla);
                $fila++;
            }

            $sheet->getColumnDimension('A')->setWidth(6);
            $sheet->getColumnDimension('B')->setWidth(15);
            $sheet->getColumnDimension('C')->setWidth(15);
            $sheet->getColumnDimension('D')->setWidth(10);
            $sheet->getColumnDimension('E')->setWidth(20);
            $sheet->getColumnDimension('F')->setWidth(12);
            $sheet->getColumnDimension('G')->setWidth(15);
            $sheet->getColumnDimension('H')->setWidth(15);
            $sheet->getColumnDimension('I')->setWidth(13);
            $sheet->getColumnDimension('I')->setWidth(13);
            $sheet->getColumnDimension('J')->setWidth(12);
            $sheet->getColumnDimension('K')->setWidth(12);
            $sheet->getColumnDimension('L')->setWidth(12);
            $sheet->getColumnDimension('M')->setWidth(12);

            foreach (range('A', 'M') as $columnID) {
                $sheet->getStyle($columnID)->getAlignment()->setWrapText(true);
            }

            $sheet->getPageSetup()->setOrientation(\PhpOffice\PhpSpreadsheet\Worksheet\PageSetup::ORIENTATION_LANDSCAPE);
            $sheet->getPageMargins()->setTop(0.5);
            $sheet->getPageMargins()->setRight(0.1);
            $sheet->getPageMargins()->setLeft(0.1);
            $sheet->getPageMargins()->setBottom(0.1);
            $sheet->getPageSetup()->setPrintArea('A:I');
            $sheet->getPageSetup()->setFitToWidth(1);
            $sheet->getPageSetup()->setFitToHeight(0);

            return response()->streamDownload(
                function () use ($spreadsheet) {
                    $writer = IOFactory::createWriter($spreadsheet, 'Xlsx');
                    $writer->save('php://output');
                },
                'usuarios_' . time() . '.xlsx',
                [
                    'Content-Type' => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                ]
            );
        }
    }

    public function catalogos()
    {
        return Inertia::render("Admin/Reportes/Catalogos");
    }

    public function r_catalogos(Request $request)
    {
        ini_set('memory_limit', '1024M');
        set_time_limit(-1);
        $catalogo_id =  $request->catalogo_id;
        $formato =  $request->formato;
        $catalogos = Catalogo::select("catalogos.*");

        if ($catalogo_id != 'todos') {
            $request->validate([
                'catalogo_id' => 'required',
            ]);
            $catalogos->where('id', $catalogo_id);
        }

        $catalogos = $catalogos->get();

        if ($formato == 'pdf') {
            $pdf = PDF::loadView('reportes.catalogos', compact('catalogos'))->setPaper('letter', 'portrait');

            // ENUMERAR LAS PÁGINAS USANDO CANVAS
            $pdf->output();
            $dom_pdf = $pdf->getDomPDF();
            $canvas = $dom_pdf->get_canvas();
            $alto = $canvas->get_height();
            $ancho = $canvas->get_width();
            $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

            return $pdf->stream('catalogos.pdf');
        } else {
            $spreadsheet = new Spreadsheet();
            $spreadsheet->getProperties()
                ->setCreator("ADMIN")
                ->setLastModifiedBy('Administración')
                ->setTitle('Registros')
                ->setSubject('Registros')
                ->setDescription('Registros')
                ->setKeywords('PHPSpreadsheet')
                ->setCategory('Listado');

            $sheet = $spreadsheet->getActiveSheet();

            $spreadsheet->getDefaultStyle()->getFont()->setName('Arial');

            $fila = 1;
            if (file_exists(public_path() . '/imgs/' . $this->configuracion->logo)) {
                $drawing = new \PhpOffice\PhpSpreadsheet\Worksheet\Drawing();
                $drawing->setName('logo');
                $drawing->setDescription('logo');
                $drawing->setPath(public_path() . '/imgs/' . $this->configuracion->logo); // put your path and image here
                $drawing->setCoordinates('A' . $fila);
                $drawing->setOffsetX(5);
                $drawing->setOffsetY(0);
                $drawing->setHeight(60);
                $drawing->setWorksheet($sheet);
            }

            $fila = 2;
            $sheet->setCellValue('A' . $fila, $this->configuracion->nombre_sistema);
            $sheet->mergeCells("A" . $fila . ":D" . $fila);  //COMBINAR CELDAS
            $sheet->getStyle('A' . $fila . ':D' . $fila)->getAlignment()->setHorizontal('center');
            $sheet->getStyle('A' . $fila . ':D' . $fila)->applyFromArray($this->titulo);
            $fila++;
            $sheet->setCellValue('A' . $fila, "LISTA DE CATÁLOGO");
            $sheet->mergeCells("A" . $fila . ":D" . $fila);  //COMBINAR CELDAS
            $sheet->getStyle('A' . $fila . ':D' . $fila)->getAlignment()->setHorizontal('center');
            $sheet->getStyle('A' . $fila . ':D' . $fila)->applyFromArray($this->titulo);
            $fila++;
            $fila++;
            $sheet->setCellValue('A' . $fila, 'N°');
            $sheet->setCellValue('B' . $fila, 'CATÁLOGO');
            $sheet->setCellValue('C' . $fila, 'PRODUCTO');
            $sheet->setCellValue('D' . $fila, 'IMAGEN');
            $sheet->getStyle('A' . $fila . ':D' . $fila)->applyFromArray($this->headerTabla);
            $fila++;

            $cont = 1;
            foreach ($catalogos as $key => $item) {
                foreach ($item->productos as $producto) {
                    $sheet->setCellValue('A' . $fila, $cont++);
                    $sheet->setCellValue('B' . $fila, $item->nombre);
                    $sheet->setCellValue('C' . $fila, $producto->nombre);
                    // Ruta física de la imagen
                    $rutaImagen = public_path('imgs/productos/' . $producto->imagen);

                    if (file_exists($rutaImagen)) {
                        $drawing = new \PhpOffice\PhpSpreadsheet\Worksheet\Drawing();
                        $drawing->setName($producto->nombre);
                        $drawing->setDescription($producto->nombre);
                        $drawing->setPath($rutaImagen);

                        $drawing->setCoordinates('D' . $fila);
                        $drawing->setHeight(55); // ajusta tamaño
                        $drawing->setOffsetX(5);
                        $drawing->setOffsetY(5);

                        $drawing->setWorksheet($sheet);

                        // IMPORTANTE: ajustar altura de fila
                        $sheet->getRowDimension($fila)->setRowHeight(50);
                    }
                    $sheet->getStyle('A' . $fila . ':D' . $fila)->applyFromArray($this->bodyTabla);

                    $fila++;
                }
            }

            $sheet->getColumnDimension('A')->setWidth(6);
            $sheet->getColumnDimension('B')->setWidth(25);
            $sheet->getColumnDimension('C')->setWidth(25);
            $sheet->getColumnDimension('D')->setWidth(25);

            foreach (range('A', 'D') as $columnID) {
                $sheet->getStyle($columnID)->getAlignment()->setWrapText(true);
            }

            $sheet->getPageSetup()->setOrientation(\PhpOffice\PhpSpreadsheet\Worksheet\PageSetup::ORIENTATION_LANDSCAPE);
            $sheet->getPageMargins()->setTop(0.5);
            $sheet->getPageMargins()->setRight(0.1);
            $sheet->getPageMargins()->setLeft(0.1);
            $sheet->getPageMargins()->setBottom(0.1);
            $sheet->getPageSetup()->setPrintArea('A:D');
            $sheet->getPageSetup()->setFitToWidth(1);
            $sheet->getPageSetup()->setFitToHeight(0);

            return response()->streamDownload(
                function () use ($spreadsheet) {
                    $writer = IOFactory::createWriter($spreadsheet, 'Xlsx');
                    $writer->save('php://output');
                },
                'catalogos_' . time() . '.xlsx',
                [
                    'Content-Type' => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                ]
            );
        }
    }

    public function visitantes()
    {
        return Inertia::render("Admin/Reportes/Visitantes");
    }

    public function r_visitantes(Request $request)
    {
        ini_set('memory_limit', '1024M');
        set_time_limit(-1);
        $social =  $request->social;
        $formato =  $request->formato;

        $query = Visitante::query();

        // 🔹 filtros primero
        if ($request->fecha_ini && $request->fecha_fin) {
            $query->whereBetween('created_at', [$request->fecha_ini, $request->fecha_fin]);
        }

        if ($request->social && $request->social !== 'todos') {
            $query->where('referer', 'like', '%' . $request->social . '%');
        }

        // 🔹 ahora el select con agrupación
        $visitantes = $query->select(
            'ip',

            // dispositivos
            DB::raw("SUM(CASE WHEN device = 'Mobile' THEN 1 ELSE 0 END) as movil"),
            DB::raw("SUM(CASE WHEN device = 'Desktop' THEN 1 ELSE 0 END) as pc"),

            // navegadores
            DB::raw("SUM(CASE WHEN browser LIKE '%Chrome%' THEN 1 ELSE 0 END) as chrome"),
            DB::raw("SUM(CASE WHEN browser LIKE '%Firefox%' THEN 1 ELSE 0 END) as firefox"),

            // redes sociales
            DB::raw("SUM(CASE WHEN referer LIKE '%facebook%' THEN 1 ELSE 0 END) as facebook"),
            DB::raw("SUM(CASE WHEN referer LIKE '%instagram%' THEN 1 ELSE 0 END) as instagram"),
            DB::raw("SUM(CASE WHEN referer LIKE '%x%' OR referer LIKE '%x.com%' THEN 1 ELSE 0 END) as x"),
            DB::raw("SUM(CASE WHEN referer LIKE '%youtube%' THEN 1 ELSE 0 END) as youtube"),
            DB::raw("SUM(CASE WHEN referer LIKE '%google%' THEN 1 ELSE 0 END) as google"),

            // total
            DB::raw("COUNT(*) as total_visitas")
        )
            ->groupBy('ip')
            ->get();

        $totales = [
            'total_movil' => $visitantes->sum('movil'),
            'total_pc' => $visitantes->sum('pc'),
            'total_chrome' => $visitantes->sum('chrome'),
            'total_firefox' => $visitantes->sum('firefox'),
            'total_facebook' => $visitantes->sum('facebook'),
            'total_instagram' => $visitantes->sum('instagram'),
            'total_x' => $visitantes->sum('x'),
            'total_youtube' => $visitantes->sum('youtube'),
            'total_google' => $visitantes->sum('google'),
        ];

        if ($formato == 'pdf') {
            $pdf = PDF::loadView('reportes.visitantes', compact('visitantes', 'totales'))->setPaper('letter', 'landscape');
            // ENUMERAR LAS PÁGINAS USANDO CANVAS
            $pdf->output();
            $dom_pdf = $pdf->getDomPDF();
            $canvas = $dom_pdf->get_canvas();
            $alto = $canvas->get_height();
            $ancho = $canvas->get_width();
            $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

            return $pdf->stream('visitantes.pdf');
        } else {
            $spreadsheet = new Spreadsheet();
            $spreadsheet->getProperties()
                ->setCreator("ADMIN")
                ->setLastModifiedBy('Administración')
                ->setTitle('Registros')
                ->setSubject('Registros')
                ->setDescription('Registros')
                ->setKeywords('PHPSpreadsheet')
                ->setCategory('Listado');

            $sheet = $spreadsheet->getActiveSheet();

            $spreadsheet->getDefaultStyle()->getFont()->setName('Arial');

            $fila = 1;
            if (file_exists(public_path() . '/imgs/' . $this->configuracion->logo)) {
                $drawing = new \PhpOffice\PhpSpreadsheet\Worksheet\Drawing();
                $drawing->setName('logo');
                $drawing->setDescription('logo');
                $drawing->setPath(public_path() . '/imgs/' . $this->configuracion->logo); // put your path and image here
                $drawing->setCoordinates('A' . $fila);
                $drawing->setOffsetX(5);
                $drawing->setOffsetY(0);
                $drawing->setHeight(60);
                $drawing->setWorksheet($sheet);
            }

            $fila = 2;
            $sheet->setCellValue('A' . $fila, $this->configuracion->nombre_sistema);
            $sheet->mergeCells("A" . $fila . ":K" . $fila);  //COMBINAR CELDAS
            $sheet->getStyle('A' . $fila . ':K' . $fila)->getAlignment()->setHorizontal('center');
            $sheet->getStyle('A' . $fila . ':K' . $fila)->applyFromArray($this->titulo);
            $fila++;
            $sheet->setCellValue('A' . $fila, "VISITANTES DEL CATÁLOGO");
            $sheet->mergeCells("A" . $fila . ":K" . $fila);  //COMBINAR CELDAS
            $sheet->getStyle('A' . $fila . ':K' . $fila)->getAlignment()->setHorizontal('center');
            $sheet->getStyle('A' . $fila . ':K' . $fila)->applyFromArray($this->titulo);
            $fila++;
            $fila++;
            $sheet->setCellValue('A' . $fila, 'N°');
            $sheet->setCellValue('B' . $fila, 'IP');
            $sheet->setCellValue('C' . $fila, 'MÓVIL');
            $sheet->setCellValue('D' . $fila, 'PC');
            $sheet->setCellValue('E' . $fila, 'CHROME');
            $sheet->setCellValue('F' . $fila, 'FIREFOX');
            $sheet->setCellValue('G' . $fila, 'FACEBOOK');
            $sheet->setCellValue('H' . $fila, 'INSTAGRAM');
            $sheet->setCellValue('I' . $fila, 'X');
            $sheet->setCellValue('J' . $fila, 'YOUTUBE');
            $sheet->setCellValue('K' . $fila, 'GOOGLE');
            $sheet->getStyle('A' . $fila . ':K' . $fila)->applyFromArray($this->headerTabla);
            $fila++;

            foreach ($visitantes as $key => $item) {
                $sheet->setCellValue('A' . $fila, $key + 1);
                $sheet->setCellValue('B' . $fila, $item->ip);
                $sheet->setCellValue('C' . $fila, $item->movil);
                $sheet->setCellValue('D' . $fila, $item->pc);
                $sheet->setCellValue('E' . $fila, $item->chrome);
                $sheet->setCellValue('F' . $fila, $item->firefox);
                $sheet->setCellValue('G' . $fila, $item->facebook);
                $sheet->setCellValue('H' . $fila, $item->instagram);
                $sheet->setCellValue('I' . $fila, $item->x);
                $sheet->setCellValue('J' . $fila, $item->youtube);
                $sheet->setCellValue('K' . $fila, $item->google);
                $sheet->getStyle('A' . $fila . ':K' . $fila)->applyFromArray($this->bodyTabla);
                $fila++;
            }

            $sheet->setCellValue('A' . $fila, 'TOTALES');
            $sheet->mergeCells("A" . $fila . ":B" . $fila);  //COMBINAR CELDAS
            $sheet->setCellValue('C' . $fila, $totales['total_movil']);
            $sheet->setCellValue('D' . $fila, $totales['total_pc']);
            $sheet->setCellValue('E' . $fila, $totales['total_chrome']);
            $sheet->setCellValue('F' . $fila, $totales['total_firefox']);
            $sheet->setCellValue('G' . $fila, $totales['total_facebook']);
            $sheet->setCellValue('H' . $fila, $totales['total_instagram']);
            $sheet->setCellValue('I' . $fila, $totales['total_x']);
            $sheet->setCellValue('J' . $fila, $totales['total_youtube']);
            $sheet->setCellValue('K' . $fila, $totales['total_google']);
            $sheet->getStyle('A' . $fila . ':K' . $fila)->applyFromArray($this->bodyTabla);
            $sheet->getColumnDimension('A')->setWidth(6);
            $sheet->getColumnDimension('B')->setWidth(15);
            $sheet->getColumnDimension('C')->setWidth(12);
            $sheet->getColumnDimension('D')->setWidth(12);
            $sheet->getColumnDimension('E')->setWidth(12);
            $sheet->getColumnDimension('F')->setWidth(12);
            $sheet->getColumnDimension('G')->setWidth(12);
            $sheet->getColumnDimension('H')->setWidth(12);
            $sheet->getColumnDimension('I')->setWidth(12);
            $sheet->getColumnDimension('I')->setWidth(12);
            $sheet->getColumnDimension('J')->setWidth(12);
            $sheet->getColumnDimension('K')->setWidth(12);

            foreach (range('A', 'K') as $columnID) {
                $sheet->getStyle($columnID)->getAlignment()->setWrapText(true);
            }

            $sheet->getPageSetup()->setOrientation(\PhpOffice\PhpSpreadsheet\Worksheet\PageSetup::ORIENTATION_LANDSCAPE);
            $sheet->getPageMargins()->setTop(0.5);
            $sheet->getPageMargins()->setRight(0.1);
            $sheet->getPageMargins()->setLeft(0.1);
            $sheet->getPageMargins()->setBottom(0.1);
            $sheet->getPageSetup()->setPrintArea('A:K');
            $sheet->getPageSetup()->setFitToWidth(1);
            $sheet->getPageSetup()->setFitToHeight(0);

            return response()->streamDownload(
                function () use ($spreadsheet) {
                    $writer = IOFactory::createWriter($spreadsheet, 'Xlsx');
                    $writer->save('php://output');
                },
                'visitantes_' . time() . '.xlsx',
                [
                    'Content-Type' => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                ]
            );
        }
    }
}
