<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Reservation extends Model
{
    use HasFactory;

    protected $table = 'reservations';
    protected $primaryKey = 'id';
    protected $guarded = [];

    public function rooms()
    {
        return $this->belongsToMany(Room::class, 'reservation_id', 'reservation_id', 'room_id')->withPivot('occupied_date')->withTimestamps();;
    }

    public function guest()
    {
        return $this->belongsTo(Guest::class);
    }
}
