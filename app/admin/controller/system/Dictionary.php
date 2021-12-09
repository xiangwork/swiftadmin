<?php
declare (strict_types = 1);
// +----------------------------------------------------------------------
// | swiftAdmin 极速开发框架 [基于ThinkPHP6开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2020-2030 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | swiftAdmin.net High Speed Development Framework
// +----------------------------------------------------------------------
// | Author: 权栈 <coolsec@foxmail.com> MIT License Code
// +----------------------------------------------------------------------
namespace app\admin\controller\system;

use app\AdminController;
use app\common\model\system\Dictionary as DictionaryModel;

class Dictionary extends AdminController
{

    public function initialize() 
    {
		parent::initialize();
        $this->model = new DictionaryModel();
    }
    
    public function index() 
    {
        $post = input();
        $pid = input('pid'); 
        $limit = input('limit/d') ?? 10;
        if ($pid == null) {
            $pid = (string)$this->model->minId();
        } 

        if (request()->isAjax()) {

            // 生成查询数据
            $pid = !strstr($pid,',') ? $pid : explode(',',$pid);
            $where[] = ['pid','in',$pid];
            if (!empty($post['name'])) {
                $where[] = ['name','like','%'.$post['name'].'%'];
            }


            $list = $this->model->where($where)->limit($limit)->select()
                ->each(function($item,$key) use ($pid){
                if ($key == 0 && $pid == '0') {
                    $item['LAY_CHECKED'] = true;
                }

                return $item;
            });

            return $this->success('查询成功', null, $list, count($list));
        }

        return view('',[ 'pid' => $pid]);
    }
}
