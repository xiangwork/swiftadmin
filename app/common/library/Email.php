<?php
declare (strict_types=1);

namespace app\common\library;

use PHPMailer\PHPMailer\PHPMailer;
use system\Random;

/**
 * 邮件发送类
 *
 */
class Email
{

    /**
     * @var object 对象实例
     */
    protected static $instance = null;

    /**
     * @PHPMailer 对象实例
     */
    protected $mail = [];

    /**
     * @vaObject 验证码对象实例
     */
    public $vaObject = null;


    /**
     * 错误信息
     */
    protected $_error = '';


    //默认配置
    protected $config = [
    ];

    /**
     * 类构造函数
     * class constructor.
     */

    public function __construct()
    {
        // 此配置项为数组。
        if ($email = saenv('email')) {
            $this->config = array_merge($this->config, $email);
        }

        //测试
//        var_dump($this->config);
        // 创建PHPMailer对象实例
        $this->mail = new PHPMailer();
        $this->mail->CharSet = 'UTF-8';
        $this->mail->IsSMTP();
        /**
         * 是否开启调试模式
         */
        $this->mail->SMTPDebug = $this->config['smtp_debug'];
        $this->mail->SMTPAuth = true;
        $this->mail->SMTPSecure = 'ssl';
        $this->mail->Host = $this->config['smtp_host'];
        $this->mail->Port = $this->config['smtp_port'];
        $this->mail->Username = $this->config['smtp_user'];
        $this->mail->Password = trim($this->config['smtp_pass']);
        $this->mail->SetFrom($this->config['smtp_user'], $this->config['smtp_name']);

        // 实例化数据库对象
        $this->vaObject = new \app\common\model\system\UserValidate();
    }

    /**
     * 初始化
     * @access public
     * @param array $options 参数
     * @return EMAIL
     */
    public static function instance($options = [])
    {
        if (is_null(self::$instance)) {
            self::$instance = new static($options);
        }
        // 返回实例
        return self::$instance;
    }

    /**
     * 设置邮件主题
     * @param string $subject 邮件主题
     * @return $this
     */
    public function Subject($subject)
    {
        $this->mail->Subject = $subject;
        return $this;
    }

    /**
     * 设置发件人
     * @param string $email 发件人邮箱
     * @param string $name 发件人名称
     * @return $this
     */
    public function from($email, $name = '')
    {
        $this->mail->setFrom($email, $name);
        return $this;
    }

    /**
     * 设置邮件内容
     * @param string $body 邮件下方
     * @param boolean $isHtml 是否HTML格式
     * @return $this
     */
    public function MsgHTML($MsgHtml, bool $isHtml = true)
    {
        if ($isHtml) {
            $this->mail->msgHTML($MsgHtml);
        } else {
            $this->mail->Body = $MsgHtml;
        }
        return $this;
    }

    /**
     * 设置收件人
     * @param mixed $email 收件人,多个收件人以,进行分隔
     * @param string $name 收件人名称
     * @return $this
     */
    public function to($email, $name = '')
    {
        $emailArr = $this->buildAddress($email);
        foreach ($emailArr as $address => $name) {
            $this->mail->addAddress($address, $name);
        }

        return $this;
    }

    /**
     * 添加附件
     * @param string $path 附件路径
     * @param string $name 附件名称
     * @return Email
     */
    public function attachment($path, $name = '')
    {
        if (is_file($path)) {
            $this->mail->addAttachment($path, $name);
        }

        return $this;
    }

    /**
     * 构建Email地址
     * @param mixed $emails Email数据
     * @return array
     */
    protected function buildAddress($emails)
    {
        $emails = is_array($emails) ? $emails : explode(',', str_replace(";", ",", $emails));
        $result = [];
        foreach ($emails as $key => $value) {
            $email = is_numeric($key) ? $value : $key;
            $result[$email] = is_numeric($key) ? "" : $value;
        }

        return $result;
    }

    /**
     * 发送验证码
     */
    public function captcha(string $email = '', string $event = "default")
    {
        $code = Random::number();
        $array = [
            'code' => $code,
            'event' => $event,
            'email' => $email,
        ];

        $this->vaObject->create($array);

        // 设置标题
        $this->to($email)->Subject("验证码")->MsgHTML("验证码为：" . $code);

        return $this;
    }

    /**
     * 检查验证码
     * @param string $email
     * @param string $event
     * @return bool
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function check(string $email, $code = '', string $event = "default")
    {
        $result = $this->vaObject->where([
            ['event', '=', $event],
            ['email', '=', $email],
            ['status', '=', 1],
        ])->order("id", "desc")->find();

        if (!empty($result) && $result->code == $code) {

            // 验证码失效
            $result->status = 0;
            $result->save();

            // 计算间隔期
            $time = strtotime($result['createtime']);
            $difftime = time() - $time;

            if (($difftime / 60) <= saenv('user_valitime')) {
                return true;
            }

            $this->setError("当前验证码已过期！");

        } else {
            $this->setError("无效验证码");
        }

        return false;
    }

    /**
     * 获取最后产生的错误
     * @return string
     */
    public function getError()
    {
        return $this->_error;
    }

    /**
     * 设置错误
     * @param string $error 信息信息
     */
    protected function setError($error)
    {
        $this->_error = $error;
    }

    /**
     * 发送邮件
     * @return boolean
     */
    public function send()
    {
        $result = false;

        try {
            $result = $this->mail->send();
        } catch (\PHPMailer\PHPMailer\Exception $e) {
            $this->setError($e->getMessage());
        }

        $this->setError($result ? '' : $this->mail->ErrorInfo);
        return $result;
    }

    /**
     * 测试发送
     */
    public function testEmail($config)
    {

        if (empty($config) || !is_array($config)) {
            return '缺少必要的信息';
        }

        $this->config = array_merge($this->config, $config);
        $this->mail->Host = $this->config['smtp_host'];
        $this->mail->Port = $this->config['smtp_port'];
        $this->mail->Username = $this->config['smtp_user'];
        $this->mail->Password = trim($this->config['smtp_pass']);
        $this->mail->SetFrom($this->config['smtp_user'], $this->config['smtp_name']);
        return $this->to($config['smtp_test'])->Subject("测试邮件")->MsgHTML("如果您看到这封邮件，说明测试成功了！")->send();
    }

}