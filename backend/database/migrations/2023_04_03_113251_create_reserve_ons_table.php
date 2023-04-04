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
        Schema::create('reserve_ons', function (Blueprint $table) {
            $table->id();
            $table->foreignId('reservation_id')->constrained();
            $table->foreignId('room_id')->constrained();
            $table->date('occupied_date');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('reserve_ons');
    }
};
