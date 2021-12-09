<?php
declare (strict_types = 1);

namespace app\common\validate\system;

use app\common\model\system\Dictionary as SystemDictionary;
use think\Validate;

class Dictionary extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */	
    protected $rule =   [
        'name'       => 'require|notEqRepeat',
        'value'      => 'require|notEqRepeat',
    ];
	
    
    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */	
    protected $message  =   [
        'name.notEqRepeat'    => '顶级分类标识不可重复',		
        'value.notEqRepeat'   => '顶级分类值不可重复',		
    ];
	
	// 自定义验证规则
    protected function notEqRepeat($value, $rule, $post) 
    {
        if (0 == $post['pid']) {

            if ($post['name'] == $value) {
                if (SystemDictionary::getByName($value)) {
                    return false;
                }
            } 

            if ($post['value'] == $value) {
                if (SystemDictionary::getByValue($value)) {
                    return false;
                }
            } 
        }

        return true;
    }
}