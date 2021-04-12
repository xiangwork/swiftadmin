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
use app\common\library\Auth;
use app\common\model\system\AdminRules;

class Recyclebin extends AdminController
{

    public function initialize() 
    {
		parent::initialize();
    }

    /**
     * 查看回收站
     */
    public function index() {

        if (request()->isAjax()) {
            $parent = []; 
            $systemMenu = AdminRules::select()->toArray();
            $result = Auth::instance()->getAuthList();
            foreach ($result as $key => $value) {
                if (!preg_match('/.*?:recyclebin/i',$value['alias'],$match)) {
                    continue;
                }

                $router = str_replace('recyclebin','index',$value['alias']);
                foreach ($systemMenu as $field => $data) {
                    if ($data['alias'] == $router) {
                        if ($data['pid'] == $value['pid']) {
                            continue;
                        }
                        // 改变路由地址
                        $data['router'] = (string)url($value['router'],[],false);
                        $parent[] = $data;
                        if ($data['pid'] != 0 && !\list_search($parent,['id'=>$data['pid']])) {
                            $parent = array_merge($parent,$this->closure($data['pid'],$systemMenu));
                        }
                    }
                }
            }

            foreach ($parent as $key => $value) {
                $parent[$key]['spread'] = true;
                $parent[$key]['title'] = __($value['title']);
            }
    
            return json(list_to_tree($parent));
        }
        
        return view();
    }

    /**
     * 递归查询
     */
    public function closure(&$pid,$list,&$array = []) {
        $finder = list_search($list,['id'=>$pid]);
        $array[] = $finder;
        if ($finder['pid'] != 0) {
            $this->closure($finder['pid'],$list,$array);
        }
        return $array;
    }

    /**
     * 重载添加
     */
    public function add() {
        return $this->error('invalid');
    }
    
    /**
     * 重载编辑
     */
    public function edit() {
        return $this->error('invalid');
    }

    /**
     * 重载删除
     */
    public function del() {
        return $this->error('invalid');
    }
}