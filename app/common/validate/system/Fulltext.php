<?php
declare (strict_types = 1);

namespace app\common\validate\system;

use think\Validate;
use SensitiveHelper\SensitiveHelper;

class Fulltext extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */	
    protected $rule =   [
        'name'           => 'require|alpha',
    ];
	
    
    /**
     * 定义错误信息
     * 格式：'字段名.规则名'    =>	'错误信息'
     *
     * @var array
     */	
    protected $message  =   [
        'name.require'=> '索引名称不能为空',		
        'name.alpha'  => '索引名称必须为字母',	
    ];
}
