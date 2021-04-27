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

namespace app\index\controller;

use app\HomeController;
use app\common\model\system\User;
use app\common\model\system\UserThird;

class Third extends HomeController
{
    /**
     * 类型
     * @var string
     */
    public $type = null;

    /**
     * 类型实例
     * @var Object
     */
    public $oauth = null;

    /**
     * 构造函数
     */
    public function __construct($type = null) {

        $this->type = input('type/s') ?? null;
        try {
            $class = "\\system\\third\\".$this->type;
            $this->oauth = new $class;
        } catch (\Throwable $th) {
            exit("暂时还不支持该方式扩展！");
        }
    }

    /**
     * 用户登录操作
     */
    public function login()
    {
        return $this->oauth->login();
    }

    /**
     * 用户回调函数
     */
    public function callback() 
    {
  
        $userInfos = $this->oauth->getUserInfo();

         // 注册新用户
        if (!empty($userInfos) && !$this->auth->isLogin()) {
            $this->register($userInfos,$this->type);
        }
        else if ($this->auth->isLogin()) { // 绑定用户
            $this->doBind($userInfos,$this->type);
        }
    }

    /**
     * 用户注册操作
     */
    public function register(array $userInfos = [], string $type = null) 
    {
        // 查询是否已经注册
        $openid = $userInfos['openid'];
        $nickname = $userInfos['userinfo']['name'] ?? $userInfos['userinfo']['nickname'];
        $result = UserThird::alias('th')->view('user','*','user.id=th.user_id')
                                        ->where(['openid'=>$openid,'type'=>$this->type])->find();
        if (!empty($result)) {
            $result['logintime'] = time(); // 更新登录数据
            $result['loginip'] = ip2long(request()->ip());
            $result['logincount'] = $result['logincount'] + 1;
            $result->save();
            $this->reload();
            $this->auth->loginState($result->toArray());
        }
        else {

            // 注册本地用户
			$local['name'] = $nickname;
			$local['avatar'] = $userInfos['userinfo']['avatar'];	
            if (User::getByName($nickname)) {
                $local['name'] .= create_rand(6);
            }

            $local['createip'] = ip2long(request()->ip());
            $result = User::create($local);

            // 封装第三方数据
            if (!empty($result)) {
                $third = [
                    'type'          => $this->type,
                    'user_id'       => $result->id,
                    'openid'        => $openid,
                    'nickname'      => $nickname,
                    'access_token'  => $userInfos['access_token'],
                    'refresh_token' => $userInfos['refresh_token'],
                    'expires_in'    => $userInfos['expires_in'],
                    'logintime'     => time(),
                    'expiretime'    => time() + $userInfos['expires_in'],
                ];
            }

            // 注册第三方数据
            if (isset($third) && is_array($third)) {
                if (UserThird::create($third)) {
                    $this->reload();
                    $this->auth->loginState($result->toArray());
                }
            }
        }
    }

    /**
     * 用户绑定操作
     */
    public function bind() 
    {
        if ($this->auth->isLogin()) {
            // 跳转到登录的地址
            $this->redirect("/third/login?bind=true&type=".$this->type);
        }
    }

    /**
     * 用户解除绑定
     */
    public function unbind() 
    {

        if ($this->auth->isLogin()) {

          $result = $this->auth->userData;
          if (!empty($result)) {
            
            if (empty($result['email']) || empty($result['pwd'])) {
                return $this->error('解除绑定需要设置邮箱和密码！');
            }

            $where['type'] = $this->type;
            $where['user_id'] = cookie('uid');
            if (UserThird::where($where)->delete()) {
                return $this->success('解除绑定成功！');
            }
          }
        }

        return $this->error();
    }

    /**
     * 用户绑定操作实例
     */
    protected function doBind(array $userInfos = [], string $type = null) 
    {
        
        $openid = $userInfos['openid'];
        $nickname = $userInfos['userinfo']['name'] ?? $userInfos['userinfo']['nickname'];

        // 查询是否被注册
        $where['openid'] = $openid;
        $where['type'] = $this->type;
        if (!UserThird::where($where)->find()) {

            // 拼装数据
            $third = [
                'type'          => $this->type,
                'user_id'       => cookie('uid'),
                'openid'        => $openid,
                'nickname'      => $nickname,
                'access_token'  => $userInfos['access_token'],
                'refresh_token' => $userInfos['refresh_token'],
                'expires_in'    => $userInfos['expires_in'],
                'logintime'     => time(),
                'expiretime'    => time() + $userInfos['expires_in'],
            ];

            try {
                if (UserThird::create($third)) {
                    return $this->reload();
                }
            } catch (\Throwable $th) {
                return $this->error($th->getMessage());
            }
        }

        return $this->error('当前用户已被其他账户绑定！');
    }

	/**
     * 刷新页面登录
     */
	protected function reload () 
    {
		$script = '<script>';
		$script .= 'parent.location.reload();';
		$script .= 'window.close();';
		$script .= '</script>';		
		echo $script;
	}
}
