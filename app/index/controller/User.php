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
use app\common\library\Sms;
use app\common\library\Email;
use app\common\library\Upload;
use app\common\model\system\Comment;
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
    public $noNeedLogin = ['login', 'register', 'forgot', 'check', 'wechat'];

    // 初始化函数
    public function initialize()
    {
        parent::initialize();
        $this->model = new UserModel();
    }

    /**
     * 用户中心
     */
    public function index(): \think\response\View
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
     * @return \think\response\View
     */
    public function login(): \think\response\View
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
     * ajax登录
     * @return \think\response\View
     */
    public function ajaxLogin(): \think\response\View
    {
        /**
         * 获取来源
         */
        $ref = request()->server('HTTP_REFERER','/');
        return $this->view('',[
            'ref' => $ref,
        ]);
    }

    /**
     * 用户资料
     */
    public function profile()
    {

        if (request()->isPost()) {

            $nickname = safe_input('nickname/s');

            $post = safe_field_model(input(), get_class($this->model),'nickname');
            if (!is_array($post)) {
                return $this->error($post);
            }

            if ($this->model->where('nickname', $nickname)->find()) {
                return $this->error('当前昵称已被占用，请更换！');
            }

            if ($this->model->update(['id' => $this->userId, 'nickname' => $nickname])) {
                return $this->success('修改昵称成功！', (string)url('/user/index'));
            }

            return $this->error();
        }

        return $this->view('', []);
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
                                               'id'   => $this->userId,
                                               'pwd'  => $pwd,
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

        if (request()->isPost()) {

            $data = array();
            $data['id'] = $this->userId;
            $data['app_id'] = 10000 + $this->userId;
            $data['app_secret'] = Random::alpha(22);

            if ($this->model->update($data)) {
                return $this->success();
            }

            return $this->error();
        }

    }

    /**
     * 我的评论
     * @return string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function comment()
    {

        if (request()->isAjax()) {

            // 获取数据
            $page = input('page/d') ?? 1;
            $limit = input('limit/d') ?? 10;
            $keyword = safe_input('keyword/s');
            // 生成查询数据
            $where = array();
            if (!empty($keyword)) {
                $where[] = ['content', 'like', '%' . $keyword . '%'];
            }

            $where[] = ['user_id', '=', $this->userId];
            $count = Comment::where($where)->count();
            $page = ($count <= $limit) ? 1 : $page;

            $list = Comment::where($where)
                           ->order('id', 'desc')
                           ->field('id,content,count,status,ip,create_time')
                           ->limit($limit)
                           ->page($page)
                           ->select()
                           ->toArray();

            return $this->success('查询成功', "", $list, $count);
        } else if (request()->isPost()) {

            /**
             * 编辑评论
             */

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
    public function commentEdit(int $id = 0)
    {
        $where = [
            ['id', '=', $id],
            ['user_id', '=', $this->userId]
        ];

        $data = Comment::where($where)->find();

        if (empty($data)) {
            return $this->error('当前评论已被删除');
        }

        if (request()->isPost()) {

            try {
                /**
                 * XSS过滤
                 */
                Comment::update(['id' => $id, 'content' => safe_input('content/s')]);
            } catch (\Throwable $th) {
                return $this->error();
            }

            return $this->success('修改成功', '');

        }

        return $this->view('', ['data' => $data]);
    }

    /**
     * @return mixed|\think\response\View
     */
    public function gbook()
    {
        if (request()->isAjax()) {

            // 获取数据
            $page = input('page/d') ?? 1;
            $limit = input('limit/d') ?? 10;

            // 生成查询数据
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
    public function gbookEdit(int $id = 0)
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
     * @return mixed|\think\response\View
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function email()
    {

        if (request()->isPost()) {

            $email = safe_input('email');
            $event = safe_input('event');
            $captcha = safe_input('captcha');

            if ($email && UserModel::getByEmail($email)) {
                return $this->error("您输入的邮箱已被占用！");
            }

            $Ems = Email::instance();
            if (!empty($email) && !empty($captcha)) {

                if ($Ems->check($email, $captcha, $event)) {
                    $this->model->update(['id' => $this->userId, 'email' => $email]);
                    return $this->success('修改邮箱成功！');
                }

                return $this->error($Ems->getError());
            }

            $last = $Ems->getLast($email);
            if ($last && (time() - strtotime($last['create_time'])) < 60) {
                return $this->error(__('发送频繁'));
            }

            if ($Ems->captcha($email, $event)->send()) {
                return $this->success("邮件发送成功，请查收！");
            } else {
                return $this->error($Ems->getError());
            }
        }

        return $this->view();
    }

    /**
     * 修改手机号
     * @return mixed|\think\response\View
     */
    public function mobile()
    {

        if (request()->isPost()) {

            $mobile = safe_input('mobile');
            $event = safe_input('event');
            $captcha = safe_input('captcha');

            if (!is_mobile($mobile)) {
                return $this->error('手机号码不正确');
            }

            if ($mobile && UserModel::getByMobile($mobile)) {
                return $this->error("您输入的手机号已被占用！");
            }

            $Sms = Sms::instance();
            if (!empty($mobile) && !empty($captcha)) {

                if ($Sms->check($mobile, $captcha, $event)) {
                    $this->model->update(['id' => $this->userId, 'mobile' => (int)$mobile]);
                    return $this->success('修改手机号成功！');
                }

                return $this->error($Sms->getError());
            }
            else {

                $last = $Sms->getLast($mobile);
                if ($last && (time() - strtotime($last['create_time'])) < 60) {
                    return $this->error(__('发送频繁'));
                }

                if ($Sms->changer($mobile, $event)) {
                    return $this->success("验证码发送成功");
                } else {
                    return $this->error($Sms->getError());
                }
            }
        }

        return $this->view();
    }

    /**
     * 设置密保
     * @return \think\response\View
     */
    public function protection(): \think\response\View
    {
        $validate = [
            '你家的宠物叫啥？',
            '你的幸运数字是？',
            '你不想上班的理由是？',
        ];

        if (request()->isPost()) {
            $question = safe_input('question/s');
            $answer = safe_input('answer/s');

            if (!$question || !$answer) {
                return $this->error('设置失败');
            }

            if (!in_array($question, $validate)) {
                $question = current($validate);
            }

            try {
                $this->userInfo->question = $question;
                $this->userInfo->answer = $answer;
                $this->userInfo->save();
            } catch (\Throwable $th) {
                return $this->error();
            }

            return $this->success();
        }

        return $this->view('', [
            'validate' => $validate
        ]);
    }

    /**
     * 安全配置中心
     * @return \think\response\View
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function security(): \think\response\View
    {
        /**
         * 计算安全比例
         */
        $maxProgress = 5;
        $thisProgress = 1;
        if ($this->userInfo->email) {
            $thisProgress++;
        }
        if ($this->userInfo->mobile) {
            $thisProgress++;
        }

        if ($this->userInfo->answer) {
            $thisProgress++;
        }

        if ($this->userInfo->wechat) {
            $thisProgress++;
        }

        // 计算比例
        $progress = (($thisProgress / $maxProgress) * 100);
        return $this->view('', [
            'progress' => $progress,
        ]);
    }

    /**
     * 用户头像上传
     * @return mixed|\think\response\Json|void
     */
    public function avatar()
    {

        if (request()->isPost()) {

            $filename = Upload::instance()->upload();

            if (!$filename) {
                return $this->error(Upload::instance()->getError());
            }

            $this->userInfo->avatar = $filename['url'] . '?' . Random::alpha(12);
            if ($this->userInfo->save()) {
                return json($filename);
            }
        }
    }

    /**
     * 单文件上传函数
     *
     * @return mixed
     * @throws \Exception
     */
    public function upload()
    {
        /**
         * 依赖注入
         */
        $invokeUpload = invoke('\app\api\controller\User');
        return $invokeUpload->upload();
    }
}
