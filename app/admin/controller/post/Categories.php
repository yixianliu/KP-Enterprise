<?php

namespace app\admin\controller\post;

use app\common\controller\Backend;

/**
 * 文章分类管理
 */
class Categories extends Backend
{
    /**
     * Categories模型对象
     * @var object
     * @phpstan-var \app\admin\model\post\Categories
     */
    protected object $model;

    protected array|string $preExcludeFields = ['id', 'update_time', 'create_time'];

    protected string|array $quickSearchField = ['id'];

    public function initialize(): void
    {
        parent::initialize();
        $this->model = new \app\admin\model\post\Categories();
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

        $this->success('ok', [
            'list'   => $treeData,
            'total'  => count($res),
            'remark' => get_route_remark(),
        ]);
    }

    /**
     * 作用：获取分类树
     * 作者：Zcc
     * 日期：2026/5/17 09:03
     */
    public function tree(): void
    {

        $res = $this->model
            ->field($this->indexField)
            ->withJoin($this->withJoinTable, $this->withJoinType)
            ->order('weigh', 'desc')
            ->select()
            ->toArray();

        $treeData = $this->buildCategoryTree($res);

        $this->success('ok', $treeData);
    }

    /**
     * 作用：构建分类树形结构（转换为 value/label/children 格式）
     * 作者：Zcc
     * 日期：2026/5/17 09:03
     * @param array $categories 分类数据
     * @param int $parentId 父级ID
     * @return array
     */
    protected function buildCategoryTree(array $categories, int $parentId = 0): array
    {
        $tree = [];

        foreach ($categories as $category) {
            if ($category['parent_id'] == $parentId) {
                $node = [
                    'value' => $category['id'],
                    'label' => $category['title'],
                ];

                $children = $this->buildCategoryTree($categories, $category['id']);
                if (!empty($children)) {
                    $node['children'] = $children;
                }

                $tree[] = $node;
            }
        }

        return $tree;
    }
}