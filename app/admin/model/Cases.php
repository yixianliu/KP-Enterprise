<?php

namespace app\admin\model;

use think\Model;

/**
 * Cases
 */
class Cases extends Model
{
    // 表名
    protected $name = 'cases';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;


    public function getContentAttr($value): string
    {
        return !$value ? '' : htmlspecialchars_decode($value);
    }

    public function getImagesAttr($value): array
    {
        if ($value === '' || $value === null) return [];
        if (!is_array($value)) {
            return explode(',', $value);
        }
        return $value;
    }

    public function setImagesAttr($value): string
    {
        return is_array($value) ? implode(',', $value) : $value;
    }

    public function refUser(): \think\model\relation\BelongsTo
    {
        return $this->belongsTo(\app\admin\model\User::class, 'ref_user_id', 'id');
    }

    public function enterprise(): \think\model\relation\BelongsTo
    {
        return $this->belongsTo(\app\admin\model\Enterprise::class, 'enterprise_id', 'id');
    }
}