<?php
declare (strict_types = 1);

namespace app\api\controller;

use app\ApiController;

/**
 * API用户登录
 */
class Template extends ApiController
{

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
