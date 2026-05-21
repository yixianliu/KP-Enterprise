<?php
declare (strict_types=1);

namespace app\front\controller;

use think\Request;
use think\Response;

class Index
{
    /**
     * 显示资源列表
     *
     * @return Response
     */
    public function index(): Response
    {
        //
        return view('index');
    }

    /**
     * 显示创建资源表单页.
     *
     * @return Response
     */
    public function about(): Response
    {
        //
        return view('about');
    }

}