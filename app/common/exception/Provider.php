<?php
declare (strict_types = 1);
namespace app\common\exception;

use Throwable;
use think\Response;
use think\exception\Handle;
use app\common\model\system\Systemlog;

class Provider extends Handle
{
    protected $error;

    public function render($request, Throwable $e): Response
    {
        /**
         * 默认捕获所有异常信息
         */
        if ($e instanceof \Throwable) {
            $status = config('system.logs.system_log_status');
            if ($status && !empty($e->getMessage()) && $e->getLine() >= 1) {
                $systemlogs = get_system_logs();
                $systemlogs['type'] = 1;
                $systemlogs['file'] = $e->getFile();
                $systemlogs['line'] = $e->getLine();
                $systemlogs['error'] = $e->getMessage();
                Systemlog::write($systemlogs);
            }
        }

        // 其他错误交给系统处理
        return parent::render($request, $e);
    }

}