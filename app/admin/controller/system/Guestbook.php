<?php
declare (strict_types = 1);
// +----------------------------------------------------------------------
// | swiftAdmin 极速开发框架 [基于ThinkPHP6开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2020-2030 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | swiftAdmin.net High Speed Development Framework
// +----------------------------------------------------------------------
// | Author: 权栈 <coolsec@foxmail.com>  MIT License Code
// +----------------------------------------------------------------------
namespace app\admin\controller\system;


use app\AdminController;
use app\common\model\system\Guestbook  as GuestbookModel;

class Guestbook extends AdminController 
{
   
    // 初始化函数
    public function initialize() {
        parent::initialize();
        $this->model = new GuestbookModel();
    }
  
	/**
	 * 获取资源
	 */
	public function index() 
    {
        if (request()->isAjax()) {
            // 获取数据
            $post = input();
            $page = input('page/d') ?? 1;
            $limit = input('limit/d') ?? 10;
            $post['status'] = input('status/d') ?? 1;
            
            // 生成查询数据
            $where = array();
            if (!empty($post['name'])) {
                $where[] = ['content','like','%'.$post['name'].'%'];
            }

            $where[] = ['status','=',$post['status']];
            $count = $this->model->where($where)->count();
            $page = ($count <= $limit) ? 1 : $page;
            $list = $this->model->where($where)
                                ->order('id', 'desc')
                                ->limit($limit)
                                ->page($page)
                                ->select()
                                ->toArray();

            foreach ($list as $key => $value) {
                $list[$key]['ip'] = long2ip($value['ip']);
            }                    
 			// TODO..
            return $this->success('查询成功', "", $list, $count, 0);

        }

        return view();
    }

    /**
     * 回复留言
     */
    public function reply() 
    {
        // 更新数据
		if (request()->isPost()) {
            $post = input('post.');
            $post['lasttime'] = time();
			$result = $this->model->update($post);
			if ($result->id) {
				return $this->success('回复成功');
			}else {
				return $this->error('回复失败！');
			}
		}
    }

}   