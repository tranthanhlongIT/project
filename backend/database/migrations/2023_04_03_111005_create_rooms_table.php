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
        Schema::create('rooms', function (Blueprint $table) {
            $table->id();
            $table->foreignId('type_id')->constrained();
            $table->foreignId('floor_id')->constrained();
            $table->string('number')->unique();
            $table->string('name');
            $table->text('description')->nullable();
            $table->string('size')->nullable();
            $table->float('price')->unsigned();
            $table->timestamps();
            $table->softDeletes();

            $table->index(['name']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('rooms');
    }
};
