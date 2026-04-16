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
        Schema::create('participantes', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("subasta_id");
            $table->unsignedBigInteger("user_id");
            $table->integer("estado");
            $table->integer("garantia");
            $table->string("comprobante", 255)->nullable();
            $table->integer("estado_comprobante")->default(0); // 0: sin verificar, 1: verificado
            $table->date("fecha_comprobante")->nullable();
            $table->time("hora_comprobante")->nullable();
            $table->integer("devolucion")->default(0); // 0: sin devolver, 1: devuelto
            $table->text("descripcion_devolucion")->nullable();
            $table->date("fecha_devolucion")->nullable();
            $table->time("hora_devolucion")->nullable();
            $table->date("fecha");
            $table->time("hora");
            $table->decimal("monto_puja", 24, 2);
            $table->timestamps();

            $table->foreign("subasta_id")->on("subastas")->references("id");
            $table->foreign("user_id")->on("users")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('participantes');
    }
};
