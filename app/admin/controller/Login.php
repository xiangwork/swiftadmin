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
namespace app\admin\controller;
use app\AdminController;
use think\facade\Session;
use app\common\model\system\Admin;

// 后台登录文件
class Login extends AdminController
{
    protected function initialize(){
		$this->admin = Session::get($this->sename);
		$this->JumpUrl = request()->server()['SCRIPT_NAME'];
	}

	/**
	 * 管理员登录
	 */
    public function index()
    {
		if (request()->isPost()) {

			// 用户信息
			$user = input('post.name');
			$pwd = input('post.pwd');
			$captcha = input('post.captcha');

			// 错误次数
			if ((isset($this->admin['count']) 
				&& $this->admin['count'] >= 5)
				&& (isset($this->admin['time']) 
				&& $this->admin['time'] >= strtotime('- 5 minutes'))) {
				return $this->error('错误次数过多,请稍候再试!');
			}

			// 验证码
			if (isset($this->admin['isCaptcha'])) {
				if(!$captcha || !captcha_check($captcha)){
					return $this->error('验证码错误！');
				}
			}

			// 验证表单令牌
			if (!request()->checkToken('__token__')) {
				$token = request()->buildToken('__token__');
				return $this->error('表单令牌错误，请重试！','',['token'=>$token]);
			}
			else {

				$result = Admin::checkLogin($user, $pwd);
				if (empty($result)) {
					$this->admin['time'] = time();
					$this->admin['isCaptcha'] = true;
					$this->admin['count'] = isset($this->admin['count']) ? $this->admin['count'] + 1: 1;
					Session::set($this->sename,$this->admin);
					return $this->error('登录失败，用户名或密码错误！','',['token'=>request()->buildToken('__token__')]);                
				}

				if ($result['status'] != 1) {
					return $this->error('帐号未审核或已被禁用，原因：'.$result['banned'].'！');			
				}

				$result->loginip = request()->ip();
				$result->logintime = time();
				$result->count = $result->count + 1;
				
				try {
					$result->save();
					Session::set($this->sename,$result->toArray());
				} catch (\Throwable $th) {
					return $this->error($th->getMessage());
				}

				return $this->success('登录成功！',$this->JumpUrl);
			}
		}

		return view('',[
			'captcha' => $this->admin['isCaptcha'] ?? false,
		]);
	}
	 
	/**
	 * 管理员退出
	 */
	public function logout() 
	{
		\think\facade\Session::clear($this->sename);
		$this->success('退出成功！',$this->JumpUrl);
	}

	/**
	 * 管理员注册
	 * 为了安全
	 * 移除的后台注册若干代码
	 * 如果有需求请自行实现逻辑
	 */
	public function register() 
	{
		$this->throwError('error',403);
	}

	/**
	 * 找回密码
	 */
	public function forgot() {
		$this->throwError('error',403);
	}


}
