<?php
declare (strict_types = 1);

namespace app\common\library;

use Endroid\QrCode\Builder\Builder;
use Endroid\QrCode\Encoding\Encoding;
use Endroid\QrCode\ErrorCorrectionLevel\ErrorCorrectionLevelHigh;
use Endroid\QrCode\Label\Alignment\LabelAlignmentCenter;
use Endroid\QrCode\Label\Font\NotoSans;
use Endroid\QrCode\RoundBlockSizeMode\RoundBlockSizeModeMargin;
use Endroid\QrCode\Writer\PngWriter;

/**
 * 生成二维码
 */
class Qrcode 
{
    public static function qrcode($params)
    {
        $params = is_array($params) ? $params : [$params];
        $params['data'] = isset($params['data']) ? $params['data'] : 'Hello world!';
        $params['size'] = isset($params['size']) ? $params['size'] : 280;
        $params['margin'] = isset($params['margin']) ? $params['margin'] : 0;
        $params['format'] = isset($params['format']) ? $params['format'] : 'png';
        $params['errorlevel'] = isset($params['errorlevel']) ? $params['errorlevel'] : 'medium';
        $params['foreground'] = isset($params['foreground']) ? $params['foreground'] : "#000000";
        $params['background'] = isset($params['background']) ? $params['background'] : "#ffffff";
        $params['label'] = isset($params['label']) ? $params['label'] : '';
        $params['logo'] = isset($params['logo']) ? $params['logo'] : '';
        $params['logosize'] = isset($params['logosize']) ? $params['logosize'] : '50';

        // 前景色
        list($r, $g, $b) = sscanf($params['foreground'], "#%02x%02x%02x");
        $foregroundcolor = ['r' => $r, 'g' => $g, 'b' => $b];

        // 背景色
        list($r, $g, $b) = sscanf($params['background'], "#%02x%02x%02x");
        $backgroundcolor = ['r' => $r, 'g' => $g, 'b' => $b];

        // 创建对象
        $qrcode = Builder::create()
        ->writer(new PngWriter())
        ->writerOptions([])
        ->data($params['data'])
        ->encoding(new Encoding('UTF-8'))
        ->errorCorrectionLevel(new ErrorCorrectionLevelHigh())
        ->size((int)$params['size'])
        ->margin($params['margin'])
        ->roundBlockSizeMode(new RoundBlockSizeModeMargin());
        // ->foregroundColor($foregroundcolor)
        // ->backgroundColor($backgroundcolor);
        if (!empty($params['logo'])) {
            $qrcode = $qrcode->logoPath($params['logo'])
            ->logoResizeToWidth($params['logosize'])->logoResizeToHeight($params['logosize']);
        }

        $qrcode = $qrcode->labelText($params['label'])
        ->labelFont(new NotoSans(20))
        ->labelAlignment(new LabelAlignmentCenter())
        ->build();

        return $qrcode;
    } 
}
