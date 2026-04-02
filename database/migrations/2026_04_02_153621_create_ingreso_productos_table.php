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
        Schema::create('ingreso_productos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("producto_id");
            $table->double("cantidad", 8, 2);
            $table->text("descripcion")->nullable();
            $table->date("fecha_registro")->nullable();
            $table->timestamps();

            $table->foreign("producto_id")->on("productos")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ingreso_productos');
    }
};
