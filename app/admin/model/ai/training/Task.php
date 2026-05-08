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

    public static function onBeforeInsert(Model $model): void
    {
        $model->task_uuid = empty($model->task_uuid) ? Str::random(12) : $model->task_uuid;
    }

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