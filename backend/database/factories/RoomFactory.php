<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Room>
 */
class RoomFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'type_id' => rand(1, 10),
            'floor_id' => rand(1, 3),
            'size_id' => rand(1, 4),
            'number' => fake()->numerify(),
            'name' => fake()->words(3, true),
            'description' => fake()->paragraph(10),
            'price' => fake()->numberBetween(1500, 6000)
        ];
    }
}
