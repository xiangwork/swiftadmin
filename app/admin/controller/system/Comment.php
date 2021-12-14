<?php
declare (strict_types = 1);
// +----------------------------------------------------------------------
// | swiftAdmin 极速开发框架 [基于ThinkPHP6开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2020-2030 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | swiftAdmin.net High Speed Development Framework
// +----------------------------------------------------------------------
// | Author: 权栈 <coolsec@foxmail.com> Apache 2.0 License Code
// +----------------------------------------------------------------------
namespace app\admin\controller\system;


use app\AdminController;
use think\facade\Db;
use app\common\model\system\Comment  as CommentModel;

class Comment extends AdminController 
{
   
    // 初始化函数
    public function initialize() {
        parent::initialize();
        $this->model = new CommentModel();
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
            $status = !empty($post['status']) ? $post['status']-1:1;

            // 生成查询数据
            $where = array();
            if (!empty($post['nickname'])) {
                $where[] = ['content','like','%'.$post['nickname'].'%'];
            }

            $count = $this->model->where($where)->where('status',$status)->count();
            $page = ($count <= $limit) ? 1 : $page;

            /**
             * 查询多个表
             * ->force('user')
             */
            $list = $this->model->where($where)
                                ->where('status',$status)
                                ->order('id','desc')
                                ->field('id,cid,uid,content,count,sid,status,ip,createtime')
                                ->limit($limit)
                                ->page($page)
                                ->select()
                                ->toArray();
            foreach ($list as $key => $value) {
                $result = Db::name('user')->field('nickname')->where('id',$value['uid'])->find();
                if (!empty($result)) {
                    $list[$key]['nickname'] = $result['nickname'];
                }
            }                             
 			// TODO..
            return $this->success('查询成功', "", $list, $count);

        }

        return view();
    }

    /**
     * 编辑评论
     */
    public function edit() 
    {
        // 更新数据
		if (request()->isPost()) {
			$post = input('post.');
			$result = $this->model->update($post);
			if ($result->id) {
				return $this->success('更新评论成功！');
			}else {
				return $this->error('更新评论失败！');
			}
		}
    }

    /**
     * 查看二级评论
     */
    public function view() 
    {
        $id = input('id/d');

        if (request()->isAjax()) {
            $page = input('page/d') ?? 1;
            $limit = input('limit/d') ?? 10;    
            $count = $this->model->where('status',1)->where('rid',$id)->count();
            $page = ($count <= $limit) ? 1 : $page; 

            $list = $this->model->view('comment','*')
                                ->view('user','nickname', 'user.id = comment.uid', 'LEFT')
                                ->where('comment.status',1)
                                ->where('rid',$id)
                                ->limit($limit)
                                ->page($page)
                                ->select()
                                ->toArray();
            return $this->success('查询成功', "", $list, $count);
        }

        $data = $this->model->find($id);
        return view('',[
            'data'=>$data
        ]);
    }

}   