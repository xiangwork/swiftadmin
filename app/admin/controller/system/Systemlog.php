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
use app\common\model\system\Systemlog as SystemlogModel;

class Systemlog extends AdminController
{
	// 初始化函数
    public function initialize() 
    {
        parent::initialize();
        $this->model = new SystemlogModel();
	}
	
    /**
     * 获取资源列表
     */
    public function index()
    {
        
        if (request()->isAjax()) {
            // 获取数据
            $post = input();
            $page = input('page/d') ?? 1;
            $limit = input('limit/d') ?? 10;
            
            // 生成查询数据
            $where = array();
            if (!empty($post['name'])) {
                $where[] = ['content','like','%'.$post['name'].'%'];
            }

            if (!empty($post['type']) && $post['type'] == 'user') {
                $where[] = ['name','<>','system'];
            }else if (!empty($post['type']) && $post['type'] == 'system') {
                $where[] = ['name','=','system'];
            }

            if (!empty($post['status']) && $post['status'] == 'normal') {
                $where[] = ['error','=',null];
            }else if (!empty($post['status']) && $post['status'] == 'error') {
                $where[] = ['error','<>',''];
            }

            $where[] = ['status','=','1'];
            $count = $this->model->where($where)->count();
            $page = ($count <= $limit) ? 1 : $page;
            $list = $this->model->where($where)->order('id', 'desc')
                                ->limit($limit)->page($page)->select()->toArray();

            foreach ($list as $key => $value) {
                $list[$key]['ip'] = long2ip($value['ip']);
            }   

            return $this->success('查询成功', "", $list, $count, 0);

        }

        return view();
    }
}