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
            $table->string("estado");
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
