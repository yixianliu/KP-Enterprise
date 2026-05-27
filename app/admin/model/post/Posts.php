<?php

namespace app\admin\model\post;

use think\Model;

/**
 * Posts
 */
class Posts extends Model
{
    // 表名
    protected $name = 'posts';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;


    public function getContentAttr($value): string
    {
        return !$value ? '' : htmlspecialchars_decode($value);
    }

    public function refUser(): \think\model\relation\BelongsTo
    {
        return $this->belongsTo(\app\admin\model\Admin::class, 'ref_user_id', 'id');
    }

    public function category(): \think\model\relation\BelongsTo
    {
        return $this->belongsTo(\app\admin\model\post\Categories::class, 'category_id', 'id');
    }
}