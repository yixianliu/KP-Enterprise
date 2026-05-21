<?php

namespace app\admin\controller\post;

use app\common\controller\Backend;

/**
 * 文章标签管理
 */
class Tags extends Backend
{
    /**
     * Tags模型对象
     * @var object
     * @phpstan-var \app\admin\model\post\Tags
     */
    protected object $model;

    protected string|array $defaultSortField = 'weigh,desc';

    protected array|string $preExcludeFields = ['id', 'update_time', 'create_time'];

    protected string|array $quickSearchField = ['id'];

    public function initialize(): void
    {
        parent::initialize();
        $this->model = new \app\admin\model\post\Tags();
    }


    /**
     * 若需重写查看、编辑、删除等方法，请复制 @see \app\admin\library\traits\Backend 中对应的方法至此进行重写
     */
}