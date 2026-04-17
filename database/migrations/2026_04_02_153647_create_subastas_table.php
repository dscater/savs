<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('subastas', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("producto_id");
            $table->string("estado_producto"); //NUEVO, SEMINUEVO, USADO
            $table->decimal("monto_inicial", 24, 2);
            $table->decimal("garantia", 24, 2)->default(0);
            $table->date("fecha_fin");
            $table->time("hora_fin");
            $table->integer("publico"); // 0: SIN PUBLICAR, 1: PÚBLICO
            $table->integer("estado_subasta")->default(1);  // 1: VIGENTE, 2: FINALIZADO
            $table->date("fecha_registro");
            $table->text("descripcion");
            $table->timestamps();

            $table->foreign("producto_id")->on("productos")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('subastas');
    }
};
