<?php
declare (strict_types = 1);
// +----------------------------------------------------------------------
// | swiftAdmin 极速开发框架 [基于ThinkPHP6开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2019-2020 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | swiftAdmin.net High Speed Development Framework
// +----------------------------------------------------------------------
// | Author: 权栈 <coolsec@foxmail.com>，河北赢图网络科技版权所有
// +----------------------------------------------------------------------
namespace app\admin\controller\system;


use app\AdminController;
use app\common\model\system\Channel;
use app\common\model\system\Collect as CollectModel;


class Collect extends AdminController 
{
   
    // 初始化函数
    public function initialize() 
    {
        parent::initialize();
        $this->model = new CollectModel();
    }

    /**
     * 获取资源 
     */    
    public function index() 
    {
       
        if (request()->isAjax()) {

            // 生成查询条件
            $post = input();
            $where = array();
            if (!empty($post['title'])) {
                $where[] = ['title','like','%'.$post['title'].'%'];
            }
            
            if (!empty($post['status'])) {
                if($post['status'] == 1){
                    $where[]=['status','=','1'];
                }else if($post['status'] == 2){
                    $where[]=['status','=','0'];
                }		
            }

            // 生成查询数据
            $list = $this->model->where($where)->order("id asc")->select()->toArray();
            return $this->success('查询成功', "", $list, count($list), 0);
        }
       
        $table = Channel::field('table')->select();
        return view('',[
            'table'=>$table
        ]);
    }

}   