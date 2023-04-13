<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Models\Guest;
use App\Models\Room;
use App\Models\Type;
use App\Models\User;
use App\Models\Floor;
use App\Models\Role;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // \App\Models\User::factory()->create([
        //     'name' => 'Test User',
        //     'email' => 'test@example.com',
        // ]);

        Role::factory(10)->create();
        User::factory(10)->create();
        Type::factory(10)->create();
        Floor::factory(3)->create();
        Guest::factory(10)->create();
        Room::factory(10)->create();
    }
}
