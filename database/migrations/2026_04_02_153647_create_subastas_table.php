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
            $table->date("fecha_fin");
            $table->time("hora_fin");
            $table->integer("publico");
            $table->integer("estado_subasta");
            $table->date("fecha_registro");
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
