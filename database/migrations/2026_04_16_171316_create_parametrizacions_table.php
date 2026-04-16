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
        Schema::create('parametrizacions', function (Blueprint $table) {
            $table->id();
            $table->json("servidor_correo");
            $table->json("datos_banco");
            $table->integer("tiempo_pub");
            $table->text("terminos_condiciones");
            $table->text("verificar_comprobante");
            $table->text("comp_rechazado");
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('parametrizacions');
    }
};
