<?php

namespace app\admin\model\product;

use think\Model;

/**
 * Products
 */
class Products extends Model
{
    // 表名
    protected $name = 'products';

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

    public function getPriceAttr($value): ?float
    {
        return is_null($value) ? null : (float)$value;
    }

    public function getOriginalPriceAttr($value): ?float
    {
        return is_null($value) ? null : (float)$value;
    }

    public function getRatingAttr($value): ?float
    {
        return is_null($value) ? null : (float)$value;
    }

    public function category(): \think\model\relation\BelongsTo
    {
        return $this->belongsTo(\app\admin\model\product\Categories::class, 'category_id', 'id');
    }
}