<?php
declare (strict_types = 1);

namespace app\api\controller;

use app\ApiController;
use app\common\library\ResultCode;

/**
 * API用户登录
 */
class User extends ApiController
{
	public $authWorkflow = false;

	// 初始化函数
    public function initialize()
    {
        parent::initialize();
	}

    /**
     * 用户登录
     */
    public function login() {

        if (request()->isPost()) {

			// 获取参数
			$name = input('name/s');
            $pwd = input('pwd/s');
            if (!$this->auth->login($name,$pwd)) {
                return $this->error($this->auth->getError());
            }
            return $this->success('登录成功',null,['token' => $this->auth->token]);
		}
    
    }
}
