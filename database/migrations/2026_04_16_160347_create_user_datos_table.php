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
        Schema::create('user_datos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("user_id");
            $table->string("email", 255);
            $table->string("ci", 155);
            $table->string("ci_exp", 155);
            $table->string("complemento", 155);
            $table->string("dpto_residencia", 255);
            $table->string("foto_ci_anverso", 255)->nullable();
            $table->string("foto_ci_reverso", 255)->nullable();
            $table->string("banco", 255);
            $table->string("nro_cuenta", 255);
            $table->timestamps();

            $table->foreign("user_id")->on("users")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user_datos');
    }
};
