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
namespace app\admin\controller;
use app\AdminController;
use think\facade\Session;
use app\common\model\system\Admin;

// 后台登录文件
class Login extends AdminController
{
	// 数据库接口
	protected $db;
	
	// 入口地址
	protected $isEnterUrl;

    protected function initialize(){
		/**
		 * 初始化入口文件
		 */
		$this->db = new Admin();
		$this->isEnterUrl = request()->server()['SCRIPT_NAME'];
	}

	/**
	 * 管理员登录
	 * 
	 */
    public function index()
    {
		// 分析访问模式
		if (!request()->isPost()) {

			// 登录状态
			$status = session::get('AdminLogin');
			if(is_array($status)&&!empty($status['id'])){
				return $this->success('您已登录,即将跳转!',$this->isEnterUrl);
			}

			return view('',[
				'captcha'=>session("AdminLogin.isCaptcha"),
			]);
			
		} else {
			
			// 用户信息
            $user = input('post.name');
            $pwd = input('post.pwd');
			$captcha = input('post.captcha');

			// 检测错误次数
			if (session('AdminLogin.count') >= 5 
				&& session('AdminLogin.time') >=  strtotime('- 5 minutes')) {
					return $this->error('错误次数过多,请稍候再试!');
			}
				
			// 图形验证码
			if (session("AdminLogin.isCaptcha")) {
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

				// 数据库验证
				$result = Admin::checkLogin($user, $pwd);
				if (empty($result)) {
					$AdminLogin = session('AdminLogin');
					$AdminLogin['count'] = isset($AdminLogin['count']) ? $AdminLogin['count'] + 1: 1;
					$AdminLogin['time'] = time();
					$AdminLogin['isCaptcha'] = true;
					session('AdminLogin',$AdminLogin);
					return $this->error('登录失败，用户名或密码错误！','',['token'=>request()->buildToken('__token__')]);                
				}

				// 用户已被封禁
				if ($result['status'] != 1) {
					session('AdminLogin.isCaptcha',true);
					return $this->error('帐号未审核或已被禁用，原因：'.$result['banned'].'！');			
				}
				// 验证成功
				if ($this->_after_login($result)) {
					return $this->success('登录成功！',$this->isEnterUrl);
				}
			}
		}
		
		return $this->error('登录异常，请检查您的数据！');
	}

	/**
	 * 后置操作
	 * 
	 */
	public function _after_login($object) 
	{	
		if (!empty($object) && is_object($object)) {
			$object->loginip = ip2long(request()->ip());	
			$object->logintime = time();
			$object->count = $object->count + 1;
			if ($object->save()) { // 缓存数据
				$this->_token($object->toArray());
				return true;
			}
			return false;
		}
	}

	/**
	 * 设置登录令牌
	 */
	public function _token($object) 
	{
		session('AdminLogin',$object);
	}

	/**
	 * 管理员退出
	 */
	public function logout() 
	{
		session::clear();
		$this->success('退出成功！',$this->isEnterUrl);
	}

	/**
	 * 为了安全
	 * 移除的后台注册若干代码
	 * 如果有需求请自行实现逻辑
	 */
	/**
	 * 管理员注册
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
