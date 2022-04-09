<?php
declare (strict_types=1);

namespace app\api\controller;

use app\ApiController;

use app\common\library\Email;
use app\common\library\Sms;
use app\common\model\system\User;

/**
 * 异步调用
 */
class Ajax extends ApiController
{

    // 初始化函数
    public function initialize()
    {
        parent::initialize();
    }

    /**
     * 发送短信
     * @return mixed|void
     */
    public function smsSend()
    {
        if (request()->isAjax()) {

            $mobile = input('mobile');
            $event = input('event', 'register');

            if (!is_mobile($mobile)) {
                return $this->error('手机号码不正确');
            }

            // 查询是否存在
            $resultUser = User::getByMobile($mobile);
            if ($event == 'register' && !empty($resultUser)) {
                return $this->error('当前手机号已被占用');
            }

            $sms = Sms::instance();
            if ($sms->register($mobile, $event)) {
                return $this->success("验证码发送成功！");
            } else {
                return $this->error($sms->getError());
            }
        }
    }

    /**
     * 发送邮件
     * @return mixed|void
     */
    public function emailSend()
    {
        if (request()->isAjax()) {

            $email = input('email');
            $event = input('event', 'register');

            if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
                return $this->error('邮件格式不正确');
            }

            // 注册事件查询邮箱
            if ($event == 'register' && User::getByEmail($email)) {
                return $this->error('当前邮箱已被占用');
            }

            $sms = Email::instance();
            if ($sms->captcha($email,$event)->send()) {
                return $this->success("验证码发送成功！");
            } else {
                return $this->error($sms->getError());
            }
        }
    }
}
