<?php
declare (strict_types = 1);

namespace app\common\validate\system;

use think\Validate;

class Tags extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */	
    protected $rule =   [
        'name'           => 'require|chsAlphaNum|unique:tags',
    ];
	
    
    /**
     * 定义错误信息
     * 格式：'字段名.规则名'    =>	'错误信息'
     *
     * @var array
     */	
    protected $message  =   [
        'name.unique'=> '词条已经存在',		
        'name.require'=> '词条不能为空',		
        'name.chsAlphaNum'  => '词条名称不允许特殊字符',	
    ];
}
