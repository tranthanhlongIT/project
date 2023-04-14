<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Models\Guest;
use App\Models\Room;
use App\Models\Service;
use App\Models\Type;
use App\Models\User;
use App\Models\Floor;
use App\Models\Role;
use App\Models\Size;
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
        Service::create([
           'name' => 'bathroom'
        ]);
        Service::create([
            'name' => 'dinner'
        ]);
        Service::create([
            'name' => 'breakfast'
        ]);
        Service::create([
            'name' => 'toilet'
        ]);
        Size::create([
            'name' => 'Single',
            'icon' => 'mdi-human-male'
        ]);
        Size::create([
            'name' => 'Double'
        ]);
        Size::create([
            'name' => 'Three persons'
        ]);
        Size::create([
            'name' => 'Four persons'
        ]);
        Size::create([
            'name' => 'Family'
        ]);
        Size::create([
            'name' => 'King room'
        ]);

        Floor::create([
            'name' => 'Floor 1'
        ]);
        Floor::create([
            'name' => 'Floor 2'
        ]);
        Floor::create([
            'name' => 'Floor 3'
        ]);

        Role::factory(10)->create();
        User::factory(10)->create();
        Type::factory(10)->create();
        Guest::factory(10)->create();
        Room::factory(10)->create();
    }
}
