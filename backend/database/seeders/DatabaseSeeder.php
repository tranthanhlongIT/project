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
            'name' => 'bathroom',
            'icon' => 'mdi-shower'
        ]);
        Service::create([
            'name' => 'dinner',
            'icon' => 'mdi-silverware-fork-knife'
        ]);
        Service::create([
            'name' => 'breakfast',
            'icon' => 'mdi-food'
        ]);
        Service::create([
            'name' => 'toilet',
            'icon' => 'mdi-toilet'
        ]);
        Size::create([
            'name' => 'Single',
            'icon' => 'mdi-human-male'
        ]);
        Size::create([
            'name' => 'Double',
            'icon' => 'mdi-human-male-male'
        ]);
        Size::create([
            'name' => 'Triple',
            'icon' => 'mdi-human-queue'
        ]);
        Size::create([
            'name' => 'Four persons',
            'icon' => 'mdi-account-group',
        ]);
        Size::create([
            'name' => 'Family',
            'icon' => 'mdi-home'
        ]);
        Size::create([
            'name' => 'King room',
            'icon' => 'mdi-crown'
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
