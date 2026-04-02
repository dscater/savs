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
        Schema::create('productos', function (Blueprint $table) {
            $table->id();
            $table->string("nombre")->unique();
            $table->text("descripcion")->nullable();
            $table->decimal("precio", 24, 2);
            $table->double("stock", 8, 2)->default(0);
            $table->unsignedBigInteger("categoria_id");
            $table->date("fecha_registro");
            $table->timestamps();

            $table->foreign("categoria_id")->on("categorias")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('productos');
    }
};
