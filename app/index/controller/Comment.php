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

namespace app\index\controller;


use app\HomeController;
use think\facade\Config;

use app\common\model\system\Comment as CommentModel;

class Comment extends HomeController
{
    /**
	 * 系统表情包
	 */
	protected $facearray = [];

    public function initialize()
    {
        parent::initialize();
        $this->facearray = config('facePacket');
    }

    /**
     * 展示评论
     */
    public function index() {

        return view();
    }

	/**
	 * 获取数据
	 */
	public function ajax() 
	{
		if (request()->isAjax()) {

			$post = input();
			$post = safe_field_model($post,CommentModel::class,'ajax');

			if (!is_array($post)) {
				return $this->error('请求参数错误！');
			}

			// 配置页码
			if (is_numeric($post['p']) && $post['p'] >= 0) {
				Config::set(['page'=>$post['p']],'comment');
			}else {
				Config::set(['page'=>1],'comment');
			}

			$post['time'] = empty($post['time']) ? time() : (!is_numeric($post['time']) ? strtotime($post['time']) : $post['time']);
			$result = mysql_comment('cid:'.$post['cid'].';sid:'.$post['sid'].';time:'.$post['time'].';limit:10;page:true;');
			if (!empty($result['data'])) {
				return $this->success('请求成功！',null,$result['data']);
			}else {
				
				return $this->error("没有更多评论了",null,101);
			}
		}
	}

	/**
     * 插入评论数据
     */
	public function insert() 
	{
		
		if (request()->isPost()) {

			// 评论开关
			if (!saenv('user_form_status')) {
				return $this->error('本站评论已关闭！请联系管理员');
			}
			
			// 是否游客评论
			if (!saenv('user_isLogin') && !$this->userId) {
				return $this->error('请登录后发表评论！');
			}

            // 限制发布频率
            $ip = request()->ip();
			$second = saenv('user_form_second');
			if (system_cache((string)$ip)) {
				return $this->error('您的评论太快,休息一下！');
			}
            
            $post = input(); // 接收参数
			$post  = safe_field_model($post,CommentModel::class);
			if (!is_array($post)) {
				return $this->error($post);
			}      
            
			// 用户ID
			$post['uid'] = $this->userId ?? 0;
			
			// 需审核
			if(saenv('user_form_check')) {
				$post['status'] = 0;
			}
            
			$post['ip'] = request()->ip(); // 过滤敏感词组
			$post['content'] = reply_anti($post['content']);			
			$post['content'] = reply_face($this->facearray,$post['content']);
			$result = CommentModel::create($post);

			if (!empty($result)) {
				system_cache((string)$ip,$ip,$second);
				$result['createtime'] = differ_time(time());
				if(!saenv('user_form_check')) {
					$result['user'] = $result->user;

					if (empty($result['user'])) {
						$result['user'] = [
							'name'=>'游客',
							'avatar'=> '/static/images/user_default.jpg'
						];
					}
					
					return $this->success('评论成功！',null,$result);
				}else {
					return $this->error('您的评论待管理员审核后显示！');
				}

			}else {
				return $this->error('评论失败！');
			}
		}
	}	

    /**
     * 获取评论表情
     */
    public function getfacePacket(array $array = []) 
	{

		foreach ($this->facearray as $key => $value) {
			$array[$key]['k'] = $key;
			$array[$key]['v'] = $value;
		}

		return $this->success('请求成功',null,$array);
    }
	
}
