<?php
declare (strict_types = 1);

namespace app\common\validate\system;

use think\Validate;
use SensitiveHelper\SensitiveHelper;

class Content extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */	
    protected $rule =   [
        'title'         => 'require|max:255',
        'pid'           => 'require',
        'pinyin'        => 'alphaDash',
        'content'       => 'require|sensitive',

    ];
	
    
    /**
     * 定义错误信息
     * 格式：'字段名.规则名'    =>	'错误信息'
     *
     * @var array
     */	
    protected $message  =   [
        'title.require'     => '标题不能为空',	
        'pid.require'       => '分类不能为空',	
        'pinyin.alphaDash'  => '拼音只能是字母和数字',	
        'content.require'   => '内容不能为空',	
        'content.sensitive' => '内容包含违禁词',	
    ];

    /**
     * 违禁词
     */
    protected function sensitive($value)
    {

        if ($value && saenv('user_sensitive')) {

            $instance = SensitiveHelper::instance();
            $words = $instance->setTree(null,false)->getBadWord($value);
            if (!empty($words)) {

                // 返回数据
                $words = implode(',',$words);
                $msg   = $this->message['content.sensitive'];
                $words = $msg.'：'.$words;
                throw new \Exception($words);

            }
        }

        return true;

    }
	
}
