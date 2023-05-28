<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Floor extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'floors';
    protected $primaryKey = 'id';
    protected $guarded = [];

    protected $hidden = ['created_at', 'updated_at'];

    public function children()
    {
        return $this->hasMany(Room::class);
    }

    public function rooms()
    {
        return $this->hasMany(Room::class);
    }
}
