<?php

namespace app\admin\controller;

use app\common\controller\Backend;
use Throwable;

/**
 * 菜单管理
 */
class Menu extends Backend
{
    /**
     * Menu模型对象
     * @var object
     * @phpstan-var \app\admin\model\Menu
     */
    protected object $model;

    protected string|array $defaultSortField = 'weigh,desc';

    protected array|string $preExcludeFields = ['id', 'update_time', 'create_time'];

    protected string|array $quickSearchField = ['id'];

    public function initialize(): void
    {
        parent::initialize();
        $this->model = new \app\admin\model\Menu();
    }


    /**
     * 若需重写查看、编辑、删除等方法，请复制 @see \app\admin\library\traits\Backend 中对应的方法至此进行重写
     */

    /**
     * 查看
     * @throws Throwable
     */
    public function index(): void
    {
        if ($this->request->param('select')) {
            $this->select();
        }

        list($where, $alias, $limit, $order) = $this->queryBuilder();

        $res = $this->model
            ->field($this->indexField)
            ->withJoin($this->withJoinTable, $this->withJoinType)
            ->alias($alias)
            ->where($where)
            ->order($order)
            ->select()
            ->toArray();

        // 针对树形结构
        $treeData = \ba\Tree::instance()->assembleChild($res, 'parent_id', 'id');

        $this->success('', [
            'list'   => $treeData,
            'total'  => count($res),
            'remark' => get_route_remark(),
        ]);
    }
}