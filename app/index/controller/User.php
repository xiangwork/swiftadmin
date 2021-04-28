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
namespace app\index\controller;


use app\HomeController;
use think\facade\Event;
use app\common\library\Sms;
use app\common\library\Email;
use app\common\library\Upload;
use app\common\model\system\UserInvitecode;
use app\common\model\system\User as UserModel;

class User extends HomeController
{
    /**
     * 鉴权控制器
     */
    public $needLogin = true;
    
    /**
     * 非登录鉴权方法
     */
    public $noNeedLogin = ['login','register','forgot','home','check','validation','setpwd'];

	// 初始化函数
	public function initialize() {
        parent::initialize();
        $this->model = new UserModel();
    }        

    /**
     * 用户中心
     */
    public function index()
    {    
        return view('',['data'=>$this->userData]);
    }

    /**
     * 用户注册
     */
    public function register()
    {
		// 判断是否开启注册
		if (!saenv('user_status')) {
			return $this->error('暂未开放注册！');
		}

        if (request()->isPost()) {

            // 验证数据
            $post = input('post.');
            $post['createip'] = ip2long(request()->ip());
			$post  = safe_field_model($post,$this->model::class);
			if (!is_array($post)) {
				return $this->error($post);
			}

            // 禁止批量注册
			$where[] = ['createip','=',$post['createip']];
			$where[] = ['createtime','>',linux_extime(1)];
			$total = $this->model->where($where)->select();
			if (!empty($total) && (count($total) >= saenv('user_register_second'))) {
				return $this->error('当日注册量已达到上限');
            }

            // 过滤用户信息
            if (isset($post['name']) && UserModel::getByName($post['name'])) {
                return $this->error('当前用户名已被占用！');
            }
            if (isset($post['email']) && UserModel::getByEmail($post['email'])) {
                return $this->error('当前邮箱已被占用！');
            }
            if (isset($post['mobile']) && UserModel::getByMobile($post['mobile'])) {
                return $this->error('当前手机号已被占用！');
            }

            // 开始注册
            $registerType = saenv('user_register_style');
            if ($registerType == 'normal') { 

            }
            else if ($registerType == 'mobile') {  // 手机验证
                if (1) {
                    return $this->error('手机验证码失效！');
                }
            }
            else if ($registerType == 'regcode') { // 激活码模式

                if (!UserInvitecode::check($post['code'])) {
                    return $this->error('激活码无效！');
                }

                // 注册回调事件
                Event::listen("register_success",function($code) {
                    UserInvitecode::del($code);
                });
            }
            
            if ($result = $this->model->create($post)) {
                Event::trigger("register_success",$post['code']);
                $this->auth->loginState($result, false);
                return $this->success('注册成功',cookie('referer'));
            }

            return $this->error('用户注册失败，请联系管理员！');
        }

        $this->setHttpRefrer();
        return view();
    }

    /**
     * 用户登录
     */
    public function login() 
    {
		if (request()->isPost()) {
			
			// 获取参数
			$name = input('name/s');
            $pwd = input('pwd/s');

            if (!$this->auth->login($name,$pwd)) {
                return $this->error($this->auth->getError());
            }

            return $this->success('登录成功',cookie('referer'));
		}
    
		$this->setHttpRefrer();
		return view('');        
    }

    /**
     * 用户资料
     */
    public function profile() 
    {

        if (request()->isPost()) {

            $id = input('id/d');
            $nickname = input('nickname');
            if ($this->model->where('nickname',$nickname)->find()) {
                return $this->error('当前昵称已被占用，请更换！');
            }

            if ($this->model->update(['id'=>$id,'nickname'=>$nickname])) {
                return $this->success('修改昵称成功！');
            }

            return $this->error();
        }

        return view('',[
            'data'=> $this->userData
        ]);
    }

    /**
     * 修改密码
     */
	public function changepwd() 
    {
        
        if (request()->isPost()) {
            $id = $this->userId;
            
            $pwd = hash_pwd(input('pwd'));
            if (input('oldpwd')) {
                $oldpwd = hash_pwd(input('oldpwd'));
            }
            else {
                $oldpwd = null;
            }
            
            if (!$this->model->where(['id'=>$id,'pwd'=>$oldpwd])->find()) {
                return $this->error('原密码输入错误！');
            }

            if ($this->model->update(['id'=>$id,'pwd'=>$pwd])) {
                return $this->success('修改密码成功！');
            }

            return $this->error();
        }

        
        return view('',[
            'data'=> $this->userData
        ]);
    }
    
    /**
     * 申请APPKEY
     */
    public function appid() 
    {

        if (request()->isAjax()) {
           
            $id = $this->userId;

            $data = array();
            $data['id'] = $id;
            $data['app_id'] = '10000'+ $id;
            $data['app_secret'] = create_rand(32);
            
            if ($this->model->update($data)) {
                return $this->success();
            }

            return $this->error();
        }

        return view('',[
            'data'=> $this->userData
        ]);
    }

    /**
     * 修改邮箱地址
     */
    public function email() 
    {

        if (request()->isPost()) {

            $email = input('email');
            $captcha = input('captcha');
            if ($email && UserModel::getByEmail($email)) {
                return $this->error("您输入的邮箱已被占用！");
            }

            // 校验验证码
            $instance = Email::instance();
            if (!empty($email) && !empty($captcha)) {
                // 查找事件
                if ($instance->check($email, "changeE")) {
                    $instance->objectValidate->delete();
                    $this->model->update(['id'=>$this->userId,'email'=>$email]);
                    return $this->success('修改邮箱成功！');
                }

                return $this->error($instance->getError());
            }

            $result = \app\common\model\system\UserValidate::where("email",$email)->order('id desc')->find();
            if (!empty($result)) {
                $difftime = time() - strtotime($result['createtime']);
                if (($difftime / 60) <= saenv('user_valitime')) {
                    return $this->error("请求的频率过快，请稍后再试！");
                }
            }

            // 发送验证码
            if ($instance->captcha($email,null,"changeE")->send()) {
                return $this->success("邮件发送成功，请查收！");
            }
            else {
                return $this->error($instance->getError());
            }
        }
    }

    /**
     * 修改手机号
     */
    public function mobile() 
    {

        if (request()->isPost()) {

            $mobile = input('mobile');
            $captcha = input('captcha');
            if ($mobile && UserModel::getByMobile($mobile)) {
                return $this->error("您输入的手机号已被占用！");
            }

            // 校验验证码
            $instance = Sms::instance();
            if (!empty($mobile) && !empty($captcha)) {
                // 查找事件
                if ($instance->check($mobile, "changer")) {
                    $instance->objectValidate->delete();
                    $this->model->update(['id'=>$this->userId,'mobile'=>(int)$mobile]);
                    return $this->success('修改手机号成功！');
                }

                return $this->error($instance->getError());
            }
            if ($instance->changer($mobile,'changer')) {
                return $this->success("验证码发送成功！");
            }
            else {
                return $this->error($instance->getError());
            }
        }
    }

	/**
     * 用户头像上传
     */
	public function avatars() 
    {
		if (request()->isPost()) {
            
            $filename = Upload::instance()->avatar($this->userId);
            if (!$filename) {
                return $this->error(Upload::instance()->getError());
            }

            $result = $this->model->find($this->userId);
            $result->avatar = $filename['url'].'?'.create_rand(12);
            if ($result->save()) {
                $this->auth->loginState($result->toArray(),true);
                return json($filename);
            }
		}
	}

    /**
     * 用户头像上传
     */
	public function upload()
    {
	    if (request()->isPost()) {

            $filename = Upload::instance()->upload();
            if (!$filename) {
                return $this->error(Upload::instance()->getError());
            }

            return json($filename);
		}
	}

	/**
     * 激活用户
     */
	public function validation()
    {
		$id = input('id/d');
		$code = input('code/s');
		
		// 判断空值
		if (is_empty($id) || is_empty($code)) {
			return $this->error('code error');
		}
		
        $result = $this->model->where(['id'=>$id,'valicode'=>$code])->find();
		if (!empty($result)) { // 验证是否超时
			$valicode = json_decode(cookies_decrypt($code),true);
			$difftime = time() - $valicode['time']; 
			if (($difftime / 60) <= saenv('user_valitime')) {
				if ($result->save(['valicode'=>'','status'=>1])) {
					$this->auth->loginState($result);
					$this->redirect('/');
                }
            }

            return $this->error('当前激活验证超时！');
		}else {
			return $this->error('当前用户不存在或已删除！');
		}
	}

}
