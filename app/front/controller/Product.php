<?php
declare (strict_types=1);

namespace app\front\controller;

use think\Request;
use think\Response;

class Product
{
    /**
     * 显示资源列表
     *
     * @return Response
     */
    public function index(): Response
    {
        //
        return view('product/index');
    }

    /**
     * 显示创建资源表单页.
     *
     * @return Response
     */
    public function details($id): Response
    {
        //
        return view('product/read', ['id' => $id]);
    }

}