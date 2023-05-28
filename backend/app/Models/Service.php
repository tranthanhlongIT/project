<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Service extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'services';
    protected $primaryKey = 'id';
    protected $guarded = [];

    public function rooms()
    {
        return $this->belongsToMany(Room::class, 'room_service', 'service_id', 'room_id');
    }
}
