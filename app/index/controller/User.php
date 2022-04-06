<?php

declare(strict_types=1);
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
use system\Random;

class User extends HomeController
{
    /**
     * 鉴权控制器
     */
    public $needLogin = true;

    /**
     * 非登录鉴权方法
     */
    public $noNeedLogin = ['login', 'register', 'forgot', 'home', 'check', 'validation', 'setpwd'];

    // 初始化函数
    public function initialize()
    {
        parent::initialize();
        $this->model = new UserModel();
    }

    /**
     * 用户中心
     */
    public function index()
    {
        return view('', ['data' => $this->auth->userInfo]);
    }

    /**
     * 用户注册
     */
    public function register()
    {
        if (request()->isPost()) {

            // 获取参数
            $post = input('post.');
            $post = safe_field_model($post,get_class($this->model));

            if (!is_array($post)) {
                return $this->error($post);
            }

            // 邮箱 手机 等验证流程 暂时没时间测试，代码还没写
            // 你可以先自行实现这块的代码

            if (!$this->auth->register($post)) {
                return $this->error($this->auth->getError());
            }

            return $this->success('注册成功', (string)url("/user/index"));

        }

        return view();
    }

    /**
     * 用户登录
     */
    public function login()
    {
        if (request()->isPost()) {

            $nickname = input('nickname/s');
            $password = input('pwd/s');

            if (!$this->auth->login($nickname, $password)) {
                return $this->error($this->auth->getError());
            }

            return $this->success('登录成功', (string)url('/'));
        }

        return view();
    }

    /**
     * 用户资料
     */
    public function profile()
    {

        if (request()->isPost()) {

            $id = input('id/d');
            $nickname = input('nickname');
            if ($this->model->where('nickname', $nickname)->find()) {
                return $this->error('当前昵称已被占用，请更换！');
            }

            if ($this->model->update(['id' => $id, 'nickname' => $nickname])) {
                return $this->success('修改昵称成功！');
            }

            return $this->error();
        }

        return view('', [
            'data' => $this->auth->userInfo
        ]);
    }

    /**
     * 修改密码
     */
    public function changepwd()
    {

        if (request()->isPost()) {
            $id = $this->userId;

            $pwd = member_encrypt(input('pwd'));
            if (input('oldpwd')) {
                $oldpwd = member_encrypt(input('oldpwd'),$pwd->salt);
            } else {
                $oldpwd = null;
            }

            if (!$this->model->where(['id' => $id, 'pwd' => $oldpwd])->find()) {
                return $this->error('原密码输入错误！');
            }

            if ($this->model->update(['id' => $id, 'pwd' => $pwd])) {
                return $this->success('修改密码成功！');
            }

            return $this->error();
        }


        return view('', [
            'data' => $this->auth->userInfo
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
            $data['app_id'] = '10000' + $id;
            $data['app_secret'] = Random::alpha(32);

            if ($this->model->update($data)) {
                return $this->success();
            }

            return $this->error();
        }

        return view('', [
            'data' => $this->auth->userInfo
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
                    $this->model->update(['id' => $this->userId, 'email' => $email]);
                    return $this->success('修改邮箱成功！');
                }

                return $this->error($instance->getError());
            }

            $result = \app\common\model\system\UserValidate::where("email", $email)->order('id desc')->find();
            if (!empty($result)) {
                $difftime = time() - strtotime($result['createtime']);
                if (($difftime / 60) <= saenv('user_valitime')) {
                    return $this->error("请求的频率过快，请稍后再试！");
                }
            }

            // 发送验证码
            if ($instance->captcha($email, null, "changeE")->send()) {
                return $this->success("邮件发送成功，请查收！");
            } else {
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
                    $this->model->update(['id' => $this->userId, 'mobile' => (int)$mobile]);
                    return $this->success('修改手机号成功！');
                }

                return $this->error($instance->getError());
            }
            if ($instance->changer($mobile, 'changer')) {
                return $this->success("验证码发送成功！");
            } else {
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
            $result->avatar = $filename['url'] . '?' . Random::alpha(12);
            if ($result->save()) {
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

        $result = $this->model->where(['id' => $id, 'valicode' => $code])->find();
        if (!empty($result)) { // 验证是否超时
            $valicode = json_decode(cookies_decrypt($code), true);
            $difftime = time() - $valicode['time'];
            if (($difftime / 60) <= saenv('user_valitime')) {
                if ($result->save(['valicode' => '', 'status' => 1])) {
                    $this->auth->returnToken($result);
                    $this->redirect('/');
                }
            }

            return $this->error('当前激活验证超时！');
        } else {
            return $this->error('当前用户不存在或已删除！');
        }
    }
}
