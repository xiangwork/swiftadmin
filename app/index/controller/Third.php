<?php
declare (strict_types=1);
// +----------------------------------------------------------------------
// | swiftAdmin 极速开发框架 [基于ThinkPHP6开发]
// +----------------------------------------------------------------------
// | Copyright (c) 2020-2030 http://www.swiftadmin.net
// +----------------------------------------------------------------------
// | swiftAdmin.net High Speed Development Framework
// +----------------------------------------------------------------------
// | Author: 权栈 <coolsec@foxmail.com> Apache 2.0 License Code
// +----------------------------------------------------------------------

namespace app\index\controller;

use app\HomeController;
use app\common\library\Auth;
use app\common\model\system\User;
use app\common\model\system\UserThird;
use system\Random;
use think\facade\Cookie;

/**
 * 社会化登录
 * @ QQ 微信 微博
 */
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
    public function __construct($type = null)
    {
        $this->auth = Auth::instance();
        $this->type = input('type/s') ?? null;

        try {
            $class = "\\system\\third\\" . $this->type;
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
        $referer = input('ref/s', request()->server('HTTP_REFERER', '/'));
        Cookie::set('redirectUrl', $referer, 3600);
        return $this->oauth->login();
    }

    /**
     * 用户回调函数
     * @return mixed|void
     */
    public function callback()
    {
        $userInfos = $this->oauth->getUserInfo();
        // 注册新用户
        if (!empty($userInfos) && !$this->auth->isLogin()) {
            return $this->register($userInfos, $this->type);
        } else if ($this->auth->isLogin()) { // 绑定用户
            return $this->doBind($userInfos, $this->type);
        }
    }

    /**
     * 用户注册操作
     * @param array $userInfos
     * @param string|null $type
     * @return void
     */
    public function register(array $userInfos = [], string $type = null)
    {

        // 查询是否已经注册
        $openid = $userInfos['openid'] ?? $userInfos['id'];
        $nickname = $userInfos['userinfo']['name'] ?? $userInfos['userinfo']['nickname'];

        $result = UserThird::alias('th')
                           ->view('user', '*', 'user.id=th.user_id')
                           ->where(['openid' => $openid, 'type' => $type])
                           ->find();

        if (!empty($result)) {
            $array['id'] = $result['id'];
            $array['login_time'] = time();
            $array['login_ip'] = request()->ip();
            $array['login_count'] = $result['login_count'] + 1;

            if (User::update($array)) {
                $this->auth->returnToken($result);
                $this->redirectUrl();
            }

        } else {

            // 注册本地用户
            $post['nickname'] = $nickname;
            $post['avatar'] = $userInfos['userinfo']['avatar'];

            if (User::getByNickname($nickname)) {
                $post['nickname'] .= Random::alpha(3);
            }

            $post['group_id'] = 1;
            $post['create_ip'] = request()->ip();
            $result = $this->auth->register($post);

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
                    'login_time'    => time(),
                    'expiretime'    => time() + $userInfos['expires_in'],
                ];
            }

            // 注册第三方数据
            if (isset($third) && is_array($third)) {
                if (UserThird::create($third)) {
                    $this->auth->returnToken($result);
                    $this->redirectUrl();
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
            $buildQuery = [
                'bind' => true,
                'type' => $this->type,
                'ref' => input('ref/s', request()->server('HTTP_REFERER', '/')),
            ];
            $this->redirect("/third/login?" . http_build_query($buildQuery));
        }
    }

    /**
     * 用户解除绑定
     */
    public function unbind()
    {
        if ($this->auth->isLogin()) {

            $result = $this->auth->userInfo;
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

        $openid = $userInfos['openid'] ?? $userInfos['id'];
        $nickname = $userInfos['userinfo']['name'] ?? $userInfos['userinfo']['nickname'];

        // 查询是否被注册
        $where['openid'] = $openid;
        $where['type'] = $this->type;
        if (!UserThird::where($where)->find()) {

            // 拼装数据
            $third = [
                'type'          => $type,
                'user_id'       => cookie('uid'),
                'openid'        => $openid,
                'nickname'      => $nickname,
                'access_token'  => $userInfos['access_token'],
                'refresh_token' => $userInfos['refresh_token'],
                'expires_in'    => $userInfos['expires_in'],
                'login_time'    => time(),
                'expiretime'    => time() + $userInfos['expires_in'],
            ];

            if (UserThird::create($third)) {
                return $this->redirectUrl();
            } else {
                return $this->error('绑定异常');
            }
        }

        return $this->error('当前用户已被其他账户绑定！');
    }

    /**
     * 跳转URL
     * @return mixed
     */
    protected function redirectUrl(): mixed
    {
        $referer = Cookie::get('redirectUrl', '/');
        if (preg_match("/(user\/login|user\/register|user\/logout)/i", $referer)) {
            $referer = '/';
        }
        Cookie::delete('redirectUrl');
        return $this->redirect($referer);
    }
}
