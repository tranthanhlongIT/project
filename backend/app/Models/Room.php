<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Room extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'rooms';
    protected $primaryKey = 'id';
    protected $guarded = [];

    public function images()
    {
        return $this->hasMany(Image::class);
    }

    public function type()
    {
        return $this->belongsTo(Type::class);
    }

    public function size()
    {
        return $this->belongsTo(Size::class);
    }

    public function floor()
    {
        return $this->belongsTo(Floor::class);
    }

    public function services()
    {
        return $this->belongsToMany(Service::class, 'room_service', 'room_id', 'service_id')->withTimestamps();;
    }

    public function reservations()
    {
        return $this->belongsToMany(Reservation::class, 'reservation_room', 'room_id', 'reservation_id')->withPivot('occupied_date')->withTimestamps();;
    }
}
