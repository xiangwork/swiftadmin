<?php
declare (strict_types = 1);

namespace app\common\validate;

use think\Validate;

class Generate extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */	
    protected $rule =   [
        'menus'  => 'rules',
    ];
    
    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */	
    protected $message  =   [
        'menus.rules'  => '路由规则匹配错误',		
    ];
	
	/**
     * 自定义验证规则
     *
     * @param [type] $value
     * @param [type] $rule
     * @param [type] $post
     * @return void
     */
    protected function rules($value, $rule, $post) 
    {

        if (!empty($value)) {

            $controller = $post['controller'];
            $controller = substr($controller,1,strrpos($controller,'/')-1);
            $variable = unserialize($value);

            foreach ($variable as $value) {
                $route = $value['route'];
                $route = substr($route,0,strrpos($route,':'));
                if ($route != $controller) {
                    $this->message['menus.rules'] = $route.' regex error';
                    return false;
                }
            }
        }

        return true;
    }	
}
