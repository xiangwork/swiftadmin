<?php
declare (strict_types = 1);

namespace app\api\controller;

use app\ApiController;
use app\common\library\Sms;
use app\common\library\Upload;

/**
 * API用户登录
 */
class User extends ApiController
{
    /**
     * 需要登录
     * @var bool
     */
	public $needLogin = true;

	// 初始化函数
    public function initialize()
    {
        parent::initialize();
	}

    /**
     * 用户注册
     * @return mixed|void
     */
    public function register()
    {
        if (request()->isPost()) {

            // 获取参数
            $post = input('post.');

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
    }

    /**
     * 用户登录
     * @return mixed|void
     */
    public function login() {

        if (request()->isPost()) {
			// 获取参数
			$nickname = input('nickname/s');
            $password = input('pwd/s');
            if (!$this->auth->login($nickname,$password)) {
                return $this->error($this->auth->getError());
            }
            return $this->success('登录成功',null,['token' => $this->auth->token]);
		}

        return $this->throwError();
    }

    /**
     * 文件上传
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
}
