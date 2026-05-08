<?php

namespace app\admin\model\ai\invoke;

use think\Model;

/**
 * Log
 */
class Log extends Model
{
    // 表名
    protected $name = 'ai_invoke_log';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;


    public function getCostAttr($value): ?float
    {
        return is_null($value) ? null : (float)$value;
    }

    public function model(): \think\model\relation\BelongsTo
    {
        return $this->belongsTo(\app\admin\model\ai\Manager::class, 'model_id', 'id');
    }

    public function refUser(): \think\model\relation\BelongsTo
    {
        return $this->belongsTo(\app\admin\model\User::class, 'ref_user_id', 'id');
    }
}