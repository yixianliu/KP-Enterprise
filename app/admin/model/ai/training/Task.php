<?php

namespace app\admin\model\ai\training;

use think\Model;

/**
 * Task
 */
class Task extends Model
{
    // 表名
    protected $name = 'ai_training_task';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;


    public function getLossAttr($value): ?float
    {
        return is_null($value) ? null : (float)$value;
    }

    public function getAccuracyAttr($value): ?float
    {
        return is_null($value) ? null : (float)$value;
    }

    public function model(): \think\model\relation\BelongsTo
    {
        return $this->belongsTo(\app\admin\model\ai\Manager::class, 'model_id', 'id');
    }
}