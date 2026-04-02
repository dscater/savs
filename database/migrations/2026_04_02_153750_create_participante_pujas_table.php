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
        Schema::create('participante_pujas', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("participante_id");
            $table->decimal("monto", 24, 2);
            $table->date("fecha");
            $table->time("hora");
            $table->timestamps();

            $table->foreign("participante_id")->on("participantes")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('participante_pujas');
    }
};
