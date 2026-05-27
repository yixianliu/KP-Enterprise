<?php

namespace app\admin\model\post;

use think\Model;

/**
 * Comments
 */
class Comments extends Model
{
    // 表名
    protected $name = 'post_comments';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = true;


    public function getContentAttr($value): string
    {
        return !$value ? '' : htmlspecialchars_decode($value);
    }

    public function post(): \think\model\relation\BelongsTo
    {
        return $this->belongsTo(\app\admin\model\post\Posts::class, 'post_id', 'id');
    }

    public function user(): \think\model\relation\BelongsTo
    {
        return $this->belongsTo(\app\admin\model\User::class, 'user_id', 'id');
    }
}