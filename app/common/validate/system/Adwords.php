<?php
declare (strict_types = 1);

namespace app\common\validate\system;

use think\Validate;

class Adwords extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */	
    protected $rule =   [
        'alias'  => 'require|alphaDash',
    ];
	
    
    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */	
    protected $message  =   [
        'alias.require'		=> '标识不能为空',
        'alias.alphaDash'  => '标识只能是字母，数字和下划线！',		
    ];
	
	// 测试验证场景
    protected $scene = [
        
    ];   	
}
