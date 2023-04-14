<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Service extends Model
{
    use HasFactory;

    protected $table = 'services';
    protected $primaryKey = 'id';
    protected $guarded = [];

    public function rooms()
    {
        return $this->belongsToMany(Room::class, 'room_service', 'service_id', 'room_id');
    }
}
