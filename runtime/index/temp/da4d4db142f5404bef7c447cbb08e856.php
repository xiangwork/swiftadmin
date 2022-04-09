<?php /*a:2:{s:64:"C:\wwwroot\demo.swiftadmin.net\app\index\view\user\register.html";i:1647395717;s:64:"C:\wwwroot\demo.swiftadmin.net\app\index\view\public\header.html";i:1639049764;}*/ ?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>SwiftAdmin 用户注册</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black"> 
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="format-detection" content="telephone=no">
<link rel="stylesheet" href="/static/js/layui/css/layui.css">
<link rel="stylesheet" href="/static/css/style.css?<?php echo rand(1000,9000) ?>">
<script src="/static/js/layui/layui.js"></script>
<script src="/static/js/common.js?<?php echo rand(1000,9000) ?>"></script>
<!--[if lt IE 9]>
  <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
  <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
<![endif]--> 
</head>
<body>

<div class="layui-fluid">
	<form class="layui-form layui-form-fixed" action="/user/register" method="post" >
		<div class="layui-form-item">
		<label class="layui-form-label">用户帐号</label>
		<div class="layui-input-block">
		  <input type="text" id="name" name="nickname" autocomplete="off" placeholder="请输入帐号" class="layui-input" value="admin">
		</div>
		</div>
		<div class="layui-form-item">
		<label class="layui-form-label">密码</label>
		<div class="layui-input-block">
		  <input type="password" id="pwd" name="pwd" autocomplete="off" placeholder="请输入密码" class="layui-input" value="admin888">
		</div>
		</div>
		<div class="layui-form-item" style="display: none;">
		<label class="layui-form-label">确认密码</label>
		<div class="layui-input-block">
		  <input type="password" id="repwd"  name="repwd" autocomplete="off" placeholder="请输入确认密码" class="layui-input" value="admin888"  >
		</div>
		</div>
		<div class="layui-form-item">
		<label class="layui-form-label">邀请码</label>
		<div class="layui-input-block">
		  <input type="text" id="code" name="code" autocomplete="off" class="layui-input" value="admin888" >
		</div>
		</div>
		<div class="layui-form-item">
		<label class="layui-form-label">邮箱地址</label>
		<div class="layui-input-block">
		  <input type="text" id="email" name="email" autocomplete="off" placeholder="请输入邮箱" class="layui-input" value="one@swiftadmin.net" >
		</div>
		</div>
		<div class="layui-footer" style="text-align: center;">
		  	<button type="reset" class="layui-btn layui-btn-primary">重置</button>
		 	<button type="submit" class="layui-btn layui-btn-normal" lay-submit="" lay-filter="submitIframe">立即提交</button>
		</div>				
	</form>					
</div>
</html>