<?php /*a:3:{s:70:"C:\wwwroot\demo.swiftadmin.net\app\admin\view\system\plugin\index.html";i:1646965795;s:64:"C:\wwwroot\demo.swiftadmin.net\app\admin\view\public\header.html";i:1649307415;s:64:"C:\wwwroot\demo.swiftadmin.net\app\admin\view\public\footer.html";i:1647424835;}*/ ?>
<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<title>SwiftAdmin 后台管理开发框架</title>
	<link href="/favicon.ico" rel="icon">
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<link href="/static/system/layui/css/layui.css?v=<?php echo config('app.version'); ?>" rel="stylesheet" type="text/css" />
	<link href="/static/system/css/style.css?v=<?php  echo rand(100,100000); ?>" rel="stylesheet" type="text/css" />
	<!-- <link href="/static/system/css/style.css?v=<?php echo config('app.version'); ?>" rel="stylesheet" type="text/css" /> -->
	<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
</head>
<script>
	var _fr4mework = {
		app: "<?php echo htmlentities((isset($app) && ($app !== '')?$app:'admin.php')); ?>",
		controller: "<?php echo htmlentities((isset($controller) && ($controller !== '')?$controller:'index')); ?>",
		action: "<?php echo htmlentities((isset($action) && ($action !== '')?$action:'index')); ?>",
		api: "<?php echo config('app.api_url'); ?>"
	};
</script>

<body>
<link rel="stylesheet" type="text/css" href="/static/system/css/plugin.css?<?php echo config('app.version'); ?>?x">

<!-- // 展示数据 -->
<div class="layui-fluid" id="swiftadmin-plugin">
    <div class="layui-card layui-elem">
        <!-- // 默认操作按钮 -->
        <div class="layui-card-header layadmin-card-header-auto ">
			<blockquote class="layui-elem-quote">插件管理：可在线安装、卸载、禁用、启用、配置、升级插件，插件升级前请做好备份。</blockquote>
			<div class="layui-form">
				<div class="layui-form-item">
					<label class="layui-form-label">插件分类：</label>
					<div class="layui-input-block" name="type">
						<span class="layui-plugin-select active first" data-value="">全部</span>
						<span class="layui-plugin-select" data-value="1">完整应用</span>
						<span class="layui-plugin-select" data-value="2">SEO优化</span>
						<span class="layui-plugin-select" data-value="3">开发测试</span>
						<span class="layui-plugin-select" data-value="4">小程序</span>
						<span class="layui-plugin-select" data-value="5">管理增强</span>
						<span class="layui-plugin-select" data-value="6">信息安全</span>
						<span class="layui-plugin-select" data-value="7">接口整合</span>
						<span class="layui-plugin-select" data-value="8">辅助增强</span>
						<span class="layui-plugin-select" data-value="9">扩展程序</span>
						<span class="layui-plugin-select" data-value="10">未归类</span>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">标签选项：</label>
					<div class="layui-input-block" name="pay">
						<span class="layui-plugin-select active first">全部</span>
						<span class="layui-plugin-select" data-value="1">免费</span>					
						<span class="layui-plugin-select" data-value="2">收费</span>
						<div class="layui-divider layui-divider-vertical"></div>
						<span name="label">
							<span class="layui-plugin-select layui-hot" data-value="hot">热门</span>
							<span class="layui-plugin-select" data-value="official">官方</span>
						</span>
						<div class="layui-divider layui-divider-vertical"></div>
						<span name="label">
							<button type="button" class="layui-btn layui-btn-xs" data-value="install">已安装插件</button>
							<button type="button" class="layui-btn layui-btn-danger layui-btn-xs" data-value="cache">更新插件缓存</button>
						</span>

						<div class="layui-inline">
							<div class="layui-input-inline" >
								<input name="title" class="layui-input layui-input-key" type="text" placeholder="<?php echo __('关键字搜索'); ?>"/>
							</div>
							<div class="layui-input-inline" >
							<button class="layui-btn layui-btn-xs icon-btn" lay-filter="formSearch" lay-submit ><i class="layui-icon layui-icon-search"></i><?php echo __('搜索'); ?></button>
							</div>
						</div>
					</div>

				</div>
			</div>   
        </div>

       	<!-- // 创建数据表实例 -->
        <table id="lay-tableList" lay-filter="lay-tableList"></table>   
    </div>
</div>



<!-- // 列表工具栏 -->
<script type="text/html" id="tableBar">
	{{# if(d.install) { }}
		{{# if(d.config) { }}
			<a class="layui-table-text" 
			data-title="<?php echo __('配置插件'); ?>" 
			data-area="{{d.area}}" 
			data-maxmin="true"
			data-url="<?php echo url('/system.plugin/config'); ?>?name={{d.name}}" lay-event="edit" ><?php echo __('配置'); ?></a>
			<div class="layui-divider layui-divider-vertical"></div>
		{{# } }}
		{{# if(d.upgrade) { }}
			<span class="layui-upgrade-elem">
			<a class="layui-table-text upgrade" 
			data-url="<?php echo url('/system.plugin/config'); ?>?name={{d.name}}" ><?php echo __('升级'); ?><span class="layui-badge-dot"></span></a>
			<div class="layui-divider layui-divider-vertical"></div>
			</span>
		{{# } }}
		
		<a class="layui-table-text uninstall" style="color:red" data-url="<?php echo url('/system.plugin/uninstall'); ?>?name={{d.name}}" ><?php echo __('卸载'); ?></a>
	{{# } else { }}
	    <a class="layui-table-text install" data-url="<?php echo url('/system.plugin/install'); ?>?name={{d.name}}" ><?php echo __('安装'); ?></a>
		{{# if(d.demourl) { }}
		<div class="layui-divider layui-divider-vertical"></div>
		<a class="layui-table-text" target="_blank" href="{{d.demourl}}" ><?php echo __('演示'); ?></a>
		{{# } }}

	{{# } }}
</script>


<script src="/static/system/layui/layui.js?v=<?php echo config('app.version'); ?>"></script>
<script src="/static/system/js/common.js?2v=<?php echo config('app.version'); ?>"></script>

<!-- // 全局加载第三方JS -->
<script src="/static/system/js/cascadata.js?v=<?php echo config('app.version'); ?>"></script>
<script src="/static/js/tinymce/tinymce.min.js?v=<?php echo config('app.version'); ?>"></script>
<script src="/static/system/module/xmselect/xmselect.js?v=<?php echo config('app.version'); ?>"></script>
<!-- // 加载font-awesome图标 -->
<link href="/static/system/layui/css/font-awesome.css?v=<?php echo config('app.version'); ?>" rel="stylesheet" type="text/css" />
<script>
    layui.use(['admin','table','plugin'], function () {

        var admin = layui.admin;
		var plugin = layui.plugin;
        var table = layui.table;
 		window.plugins = <?php echo $plugin; ?>;

        /*
         * 初始化表格
        */
		var isTable = table.render({
            elem: "#lay-tableList"
            ,url: plugin.apiUrl + "/plugin/index"
            ,method: 'post'
            ,page: true
            ,limit: 15
            ,cols: [[
                {type: 'checkbox', width:45},
                {field: 'id', align: 'center',templet:function(d){
                	if (typeof plugins[d.name] != 'undefined') {
                		var html = '<a href="/plugin/'+ d.name +'" target="_blank" lay-tips='+ d.name +' data-offset="1" lay-color="#1890ff">';
                			html += '<i class="layui-icon layui-icon-home" style="color:#1890ff;"></i></a>';
                		return html;
                	}
                	else {
                		return '<i class="layui-icon layui-icon-home" lay-tips='+ d.name +' data-offset="1" ></i>';
                	}
                }, width: 80,  title: '前台'},
                {field: 'title', align: 'left',width:200,templet:function(d){
                    var html = '<a target="_blank" href="'+d.readurl+'">'+d.title+'</a>';
                    if (d.album) {
                        html += '<i class="layui-icon layui-icon-picture"></i>';
                    }
                    return html;
                }, title: '<?php echo __("名称"); ?>'},
                {field: 'intro', align: 'left',title: '<?php echo __("介绍"); ?>'},
                {field: 'author', align: 'center',width:180,title: '<?php echo __("作者"); ?>'},
                {field: 'price', align: 'center',templet:function(d){
                	if (d.price > 0) {
                		return '<font color="red">￥'+d.price+'</font>';
                	} else {
                		return '免费';
                	}
                },width:180,title: '<?php echo __("价格"); ?>'},
                {field: 'status', align: 'center',templet: function(d) {
                	var html = '',item = plugins[d.name];
                	if (typeof item != 'undefined') {
                		html += '<input type="checkbox" lay-filter="pluginStatus"';
            			html += 'data-url="<?php echo url('/system.plugin/status'); ?>" lay-skin="switch" value="'+d.name+'"'; 
            			if (item.status) {
            				html += 'checked';
            			}
            			html += '>';
                	}
                	return  html;
                },width:80,  title: '<?php echo __("状态"); ?>'},
                {field: 'download', align: 'center',width:80,  title: '<?php echo __("下载"); ?>'},
                {field: 'version', align: 'center', width:180, title: '<?php echo __("版本"); ?>'},
                {align: 'center',  templet: function(d){
                	var html = '',item = plugins[d.name];
                	if (typeof item != 'undefined') {
                		if (item.config) {
							html += '<a class="layui-table-text" data-title="<?php echo __('配置插件'); ?>" data-area="' + item.area+' "';
							html += 'data-maxmin="true" data-url="<?php echo url('/system.plugin/config/'); ?>name/' +d.name+'" lay-event="edit" ><?php echo __('配置'); ?></a>';
							html += '<div class="layui-divider layui-divider-vertical"></div>';
                		}
                		if (d.version > item.version) {
                			html += '<span class="layui-upgrade-elem">';
							html += '<a class="layui-table-text upgrade" data-url="<?php echo url('/system.plugin/config/'); ?>name/' +d.name+'" ><?php echo __('升级'); ?>';
							html += '<span class="layui-badge-dot"></span></a>';
                			html += '</span>';
                			html += '<div class="layui-divider layui-divider-vertical"></div>';
                		}
                		html += '<a class="layui-table-text uninstall" style="color:red"';
                		html += ' data-url="<?php echo url('/system.plugin/uninstall/'); ?>name/'+d.name+'" ><?php echo __('卸载'); ?></a>';
                	}
                	else {
                		html += '<a class="layui-table-text install" data-url="<?php echo url('/system.plugin/install/'); ?>name/'+d.name+'" ><?php echo __('安装'); ?></a>';
	    				if (d.demourl) {
	    					html += '<div class="layui-divider layui-divider-vertical"></div>';
	    					html += '<a class="layui-table-text" target="_blank" href="'+d.demourl +'" ><?php echo __('演示'); ?></a>';
	    				}
                	}
                	return html;
                }, width:220, title: '<?php echo __("操作"); ?>'},
            ]] 
        })
    });
</script>
