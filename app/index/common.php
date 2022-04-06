<?php

// 这是系统自动生成的公共文件
if (!function_exists('check_user_third')) {
    /**
     * 获取第三方登录
     * @param mixed $type
	 * @param int $id	 
     * @return array
     * @noinspection PhpReturnDocTypeMismatchInspection
     */
	function check_user_third($type, $id = 0) 
	{
		if (!$id || !$type) {
			return false;
		}
		
		if (\app\common\model\system\UserThird::where('user_id',$id)->getByType($type)) {
			return true;
		}
		return false;

	}
}