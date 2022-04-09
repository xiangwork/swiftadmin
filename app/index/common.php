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

if (!function_exists('usenav_highlighted')) {
    /**
     * 检测会员中心导航是否高亮
     */
    function usenav_highlighted($url, $classname = 'layui-this')
    {
        $requestUrl = request()->controller(true).'/'.request()->action(true);
        $url = str_replace('.','/',ltrim($url, '/'));
		$requestUrl = str_replace('.','/',$requestUrl);
        return $requestUrl === $url ? $classname : '';
    }
}

if (!function_exists('distance_day')) {

    /**
     * 计算天数
     * @param $time
     * @return false|float
     */
    function distance_day($time ='') {

        if (!$time) {
            return false;
        }

        if (!is_numeric($time)) {
            $time = strtotime($time);
        }

        $time = time() - $time;
        return ceil($time / (60*60*24) );
    }
}