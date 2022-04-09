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

use app\common\model\system\Guestbook;
use app\HomeController;

use system\Random;
use think\facade\Db;
use app\common\library\Sms;
use app\common\library\Email;
use app\common\library\Upload;
use app\common\model\system\Comment;
use app\common\model\system\UserValidate;
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
    public $noNeedLogin = ['login', 'register', 'forgot', 'check'];

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
        return view();
    }

    /**
     * 用户注册
     */
    public function register()
    {

        if (request()->isPost()) {

            // 获取参数
            $post = input('post.');
            $post = safe_field_model($post, get_class($this->model));

            if (!is_array($post)) {
                return $this->error($post);
            }

            // 获取注册方式
            $registerType = saenv('user_register_style');

            if ($registerType == 'mobile') {
                $mobile = input('mobile');
                $captcha = input('captcha');

                // 校验手机验证码
                if (!Sms::instance()->check($mobile, $captcha, 'register')) {
                    return $this->error(Sms::instance()->getError());
                }
            }

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

            $nickname = input('nickname');
            if ($this->model->where('nickname', $nickname)->find()) {
                return $this->error('当前昵称已被占用，请更换！');
            }

            if ($this->model->update(['id' => $this->userId, 'nickname' => $nickname])) {
                return $this->success('修改昵称成功！',(string)url('/user/index'));
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

            // 获取参数
            $pwd = input('pwd');
            $oldpwd = input('oldpwd');
            $yPwd = encryptPwd($oldpwd, $this->userInfo->salt);

            if ($yPwd != $this->userInfo->pwd) {
                return $this->error('原密码输入错误！');
            }

            $salt = Random::alpha();
            $pwd = encryptPwd($pwd, $salt);

            $result = $this->model->update([
                'id' => $this->userId,
                'pwd' => $pwd,
                'salt' => $salt,
            ]);

            if (!empty($result)) {
                return $this->success('修改密码成功！');
            }

            return $this->error();
        }


        return view();
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
            $data['app_secret'] = Random::alpha(22);

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
     * 订单管理
     * @return string
     */
    public function order()
    {
        return $this->view();
    }

    /**
     * 消息中心
     * @return string
     */
    public function notice()
    {
        return $this->view();
    }

    /**
     * 实名认证
     * @return string
     */
    public function personal()
    {
        return $this->view();
    }

    /**
     * 我的评论
     * @return string
     */
    public function comment()
    {
        if (request()->isAjax()) {

            // 获取数据
            $post = input();
            $page = input('page/d') ?? 1;
            $limit = input('limit/d') ?? 10;

            // 生成查询数据
            $where = array();
            if (!empty($post['keyword'])) {
                $where[] = ['content','like','%'.$post['keyword'].'%'];
            }

            $where[] = ['status','=', 1];
            $where[] = ['user_id','=', $this->userId];
            $count = Comment::where($where)->count();
            $page = ($count <= $limit) ? 1 : $page;

            $list = Comment::where($where)
                ->order('id','desc')
                ->field('id,content,count,status,ip,createtime')
                ->limit($limit)
                ->page($page)
                ->select()
                ->toArray();

            return $this->success('查询成功', "", $list, $count);

        }

        return $this->view();
    }

    /**
     * 编辑评论
     * @param int $id
     * @return mixed|string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function commentedit(int $id = 0)
    {

        $where = [
            ['id','=', $id],
            ['user_id','=', $this->userId]
        ];

        $data = Comment::where($where)->find();

        if (!$data) {
            return $this->error('当前评论已被删除');
        }

        if (request()->isPost()) {

            try {

                $content = input('content');
                $data->content = remove_xss($content);
                $data->save();

            } catch (\Throwable $th) {
                return $this->error();
            }

            return $this->success('修改成功','');

        }

        return $this->view('',['data' => $data]);
    }


    /**
     * 我的留言
     * @return string
     */
    public function gbook()
    {
        if (request()->isAjax()) {
            // 获取数据
            $post = input();
            $page = input('page/d') ?? 1;
            $limit = input('limit/d') ?? 10;

            // 生成查询数据
            $where = array();
            if (!empty($post['keyword'])) {
                $where[] = ['content','like','%'.$post['keyword'].'%'];
            }


            $where[] = ['status','=', 1];
            $where[] = ['user_id','=', $this->userId];
            $count = Guestbook::where($where)->count();
            $page = ($count <= $limit) ? 1 : $page;
            $list = Guestbook::where($where)
                ->order('id', 'desc')
                ->limit($limit)
                ->page($page)
                ->select()
                ->toArray();

            foreach ($list as $key => $value) {
                $list[$key]['ip'] = long2ip($value['ip']);
            }

            // TODO..
            return $this->success('查询成功', "", $list, count($list));

        }

        return $this->view();
    }

    /**
     * 编辑留言
     * @param int $id
     * @return mixed|string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function gbookedit(int $id = 0)
    {

        $where = [
            ['id','=', $id],
            ['user_id','=', $this->userId]
        ];

        $data = Guestbook::where($where)->find();

        if (!$data) {
            return $this->error('当前留言已被删除');
        }

        if (request()->isPost()) {

            try {

                $content = input('content');
                $data->content = remove_xss($content);
                $data->save();

            } catch (\Throwable $th) {
                return $this->error();
            }

            return $this->success('修改成功','');

        }

        return $this->view('',['data' => $data]);
    }


    /**
     * 修改邮箱地址
     */
    public function email()
    {

        if (request()->isPost()) {

            $email = input('email');
            $event = input('event');
            $captcha = input('captcha');
            if ($email && UserModel::getByEmail($email)) {
                return $this->error("您输入的邮箱已被占用！");
            }

            // 校验验证码
            $instance = Email::instance();
            if (!empty($email) && !empty($captcha)) {

                // 查找事件
                if ($instance->check($email, $captcha, $event)) {
                    $this->model->update(['id' => $this->userId, 'email' => $email]);
                    return $this->success('修改邮箱成功！');
                }

                return $this->error($instance->getError());
            }

            $result = UserValidate::where([
                ['email', '=', $email],
                ['event', '=', $event],
                ['status', '=', 1],
            ])->order('id desc')->find();

            if (!empty($result)) {
                $difftime = time() - strtotime($result['createtime']);
                if (($difftime / 60) <= saenv('user_valitime')) {
                    return $this->error("请求的频率过快，请稍后再试！");
                }
            }

            // 发送验证码
            if ($instance->captcha($email, $event)->send()) {
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
            $event = input('event');
            $captcha = input('captcha');
            if ($mobile && UserModel::getByMobile($mobile)) {
                return $this->error("您输入的手机号已被占用！");
            }

            // 校验验证码
            $instance = Sms::instance();
            if (!empty($mobile) && !empty($captcha)) {

                // 查找事件
                if ($instance->check($mobile,$captcha, $event)) {
                    $this->model->update(['id' => $this->userId, 'mobile' => (int)$mobile]);
                    return $this->success('修改手机号成功！');
                }

                return $this->error($instance->getError());
            }

            if ($instance->register($mobile, $event)) {
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

            $this->userInfo->avatar = $filename['url'] . '?' . Random::alpha(12);
            if ($this->userInfo->save()) {
                return json($filename);
            }
        }
    }
}
