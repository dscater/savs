<?php

namespace App\Services;

use App\Models\Notificacion;
use App\Services\HistorialAccionService;
use App\Models\Producto;
use App\Models\Subasta;
use App\Models\User;
use App\Models\VentaDetalle;
use Carbon\Carbon;
use Illuminate\Http\UploadedFile;
use Exception;
use Illuminate\Container\Attributes\Auth;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;

class ProductoService
{
    private $modulo = "PRODUCTOS";

    public function __construct(private ProductoImagenService $productoImagenService, private HistorialAccionService $historialAccionService, private NotificacionUserService $notificacion_user_service) {}

    public function listado(): Collection
    {
        $productos = Producto::select("productos.*")
            ->with(["categoria:id,nombre", "producto_imagens"])->get();
        return $productos;
    }
    /**
     * Lista de productos paginado con filtros
     *
     * @param integer $length
     * @param integer $page
     * @param string $search
     * @param array $columnsSerachLike
     * @param array $columnsFilter
     * @return LengthAwarePaginator
     */
    public function listadoPaginado(int $length, int $page, string $search, array $columnsSerachLike = [], array $columnsFilter = [], array $columnsBetweenFilter = [], array $orderBy = []): LengthAwarePaginator
    {
        $productos = Producto::select("productos.*")
            ->with(["categoria"]);

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $productos->where("productos.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $productos->whereBetween("productos.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $productos->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $productos->orderBy($value[0], $value[1]);
            }
        }


        $productos = $productos->paginate($length, ['*'], 'page', $page);
        return $productos;
    }

    /**
     * Crear producto
     *
     * @param array $datos
     * @return Producto
     */
    public function crear(array $datos): Producto
    {
        $producto = Producto::create([
            "codigo" => mb_strtoupper($datos["codigo"]),
            "nombre" => mb_strtoupper($datos["nombre"]),
            "descripcion" => $datos["descripcion"],
            "precio" => $datos["precio"],
            "categoria_id" => $datos["categoria_id"],
            "fecha_registro" => Carbon::now("America/La_Paz")->format("Y-m-d")
        ]);

        // cargar imagenes
        $this->productoImagenService->cargarImagenes($producto, $datos["producto_imagens"]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN PRODUCTO", $producto, null, ["producto_imagens"]);

        return $producto;
    }

    /**
     * Actualizar producto
     *
     * @param array $datos
     * @param Producto $producto
     * @return Producto
     */
    public function actualizar(array $datos, Producto $producto): Producto
    {
        $old_producto = clone $producto;

        $producto->update([
            "codigo" => mb_strtoupper($datos["codigo"]),
            "nombre" => mb_strtoupper($datos["nombre"]),
            "descripcion" => $datos["descripcion"],
            "precio" => $datos["precio"],
            "categoria_id" => $datos["categoria_id"],
        ]);

        // cargar imagenes
        $this->productoImagenService->cargarImagenes($producto, $datos["producto_imagens"], $datos["eliminados_imagens"] ?? []);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UN PRODUCTO", $old_producto, $producto, ["producto_imagens"]);

        return $producto;
    }

    /**
     * Eliminar producto
     *
     * @param Producto $producto
     * @return boolean
     */
    public function eliminar(Producto $producto): bool|Exception
    {
        $old_producto = clone $producto;

        $usos = VentaDetalle::where("producto_id", $producto->id)->count();
        if ($usos > 0) {
            throw new Exception("No se puede eliminar este registro porque esta siendo utilizado");
        }

        $usos = Subasta::where("producto_id", $producto->id)->count();
        if ($usos > 0) {
            throw new Exception("No se puede eliminar este registro porque esta siendo utilizado");
        }

        $producto->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UN PRODUCTO", $old_producto, $producto);

        return true;
    }


    public function incrementarStock(int $producto_id, int $cantidad = 1)
    {
        $producto = Producto::findOrFail($producto_id);
        $producto->stock = (float)$producto->stock + $cantidad;
        $producto->save();
        return $producto;
    }
    public function decrementarStock(int $producto_id, int $cantidad = 1)
    {
        $producto = Producto::findOrFail($producto_id);
        // validar stock
        if (!$this->verificaStock($producto_id, $cantidad)) {
            throw new Exception("Stock insuficiente del producto " . $producto->nombre . ", disponible " . $producto->stock);
        }

        $producto->stock = (float)$producto->stock - $cantidad;
        $producto->save();

        $this->verificaNotificacion($producto);

        return $producto;
    }

    public function verificaStock($producto_id, $cantidad): bool
    {
        $producto = Producto::findOrFail($producto_id);
        $disponible = false;
        if ($producto->stock >= $cantidad) {
            $disponible = true;
        }

        return $disponible;
    }

    public function verificaNotificacion($producto)
    {
        if ($producto->stock_actual < 1) {
            $notificacion = Notificacion::create([
                "descripcion" => $producto->nombre . " SE QUEDO SIN STOCK",
                "fecha" => date("Y-m-d"),
                "hora" => date("H:i"),
                "modulo" => "Producto",
                "registro_id" => $producto->id,
                "tipo" => "STOCK",
            ]);

            $this->notificacion_user_service->crearNotificacionUsers($notificacion->id, ["ADMINISTRADOR", "AUXILIAR"]);
        }
    }

    public function verificaStockCantidad($producto_id, $cantidad): array
    {
        $producto = Producto::findOrFail($producto_id);
        $disponible = false;
        if ($producto->stock >= $cantidad) {
            $disponible = true;
        }

        return [$disponible, $producto->stock];
    }

    public function validaStockCantidad($producto_id, $cantidad)
    {
        $producto = Producto::findOrFail($producto_id);
        $disponible = false;
        if ($producto->stock >= $cantidad) {
            $disponible = true;
        }
        if (!$disponible) {
            throw new Exception("Stock insuficiente del producto $producto->nombre, stock actual " . $producto->stock, 422);
            return false;
        }
        return true;
    }
}
