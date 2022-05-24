## 前言
> 基于ThinkPHP6版本开发， 学习本手册有利于您快速的掌握本框架的开发架构！
<div align="center">
<img src="https://www.swiftadmin.net/static/images/sademo/110400_6a5e130d_904542.png" width="100" height="100"/>
</div>
<p align="center"><strong>价值源自分享</strong></p>

<p align="center">
	<a href="https://www.swiftadmin.net" target="_blank">官方平台</a> 
    <a href="https://demo.swiftadmin.net/admin.php" rel="nofollow" >在线演示</a>
	<a href="https://doc.swiftadmin.net/help/"  target="_blank">在线使用手册</a>
</p>
<p align="center">
<font>开源不易，右上角请点击stars，感谢</font>
</p>

> 请注意，框架安装成功后会自动删除安装脚本文件！！！如权限问题未删除，请手动删除！<br/>

<b>后台演示 
<a href="http://demo.swiftadmin.net/admin.php" target="_blank">http://demo.swiftadmin.net/admin.php </a> </b><br/>
<b>管理账号  admin admin888 </b><br/>
<b>测试账号  ceshi admin888 </b>如正式运营环境请删除测试账号;<br/>


<b>开发环境：Linux PhpStorm Apache MySQL>=5.7 PHP >= 7.3 支持PHP8  [最低支持PHP7.3]</b><br/>

<a href="https://gitee.com/meystack/swiftadmin/"><img src="https://img.shields.io/badge/license-Apache-blue.svg" alt="swiftadmin"></a>
<a href="https://gitee.com/meystack/swiftadmin/"><img src="https://img.shields.io/badge/ThinkPHP-6LTS-brightgreen.svg" alt="thinkphp"></a>
<a href="https://gitee.com/meystack/swiftadmin/"><img src="https://img.shields.io/badge/Layui-2.Fix-red.svg" alt="layui"></a>
<a href="https://gitee.com/meystack/swiftadmin/stargazers"><img src="https://gitee.com/meystack/swiftadmin/badge/star.svg?theme=gvp" alt="star"></a>
<a href="https://gitee.com/meystack/swiftadmin/members"><img src="https://gitee.com/meystack/swiftadmin/badge/fork.svg?theme=gvp" alt="fork"></a>
<a href="https://qm.qq.com/cgi-bin/qm/qr?k=Idivrh-log25t0ryx19nWeqUk8oFrI-X&jump_from=webapi"><img src="https://img.shields.io/badge/qq一群-68221484-blue.svg" alt="一群"></a>
<a href="https://qm.qq.com/cgi-bin/qm/qr?k=L_SKDh46TnWDVrudKEON2XAlgm02RNic&jump_from=webapi"><img src="https://img.shields.io/badge/qq二群-68221585-blue.svg" alt="二群"></a>
<a href="https://qm.qq.com/cgi-bin/qm/qr?k=p6N-b7AkWiESpcrZmOKWpm3t05qt4MQ-&jump_from=webapi"><img src="https://img.shields.io/badge/qq三群-68221618-blue.svg" alt="三群"></a>

## 💡 软件介绍
swiftadmin框架开发的初衷，主要是为了减少自己在开发过程中重复的造轮子，在自己这几年建站的过程中，都是用一些开源的CMS系统制作自己的网站，后期因为扩展和二次开发的问题，导致觉得很多东西并不是那么简单易用，比如后台的很多JS代码封装的不是很好，而且界面可操作性很差，所以自己开发这款框架封装了很多常用的特性，足以满足日常后台的开发需要，在使用的过程中你会发现，SAPHP框架里面用的最多的是属性而不是对象，一是为了在书写HTML标签的时候方便。二是为了和layui本身区分开！这样让你更容易在这个上面进行扩展！

## 💻 系统架构

swiftadmin极速后台开发框架采用PHP+MYSQL的基础架构，秉承着代码最精简、逻辑最清晰的设计理念、只要你熟悉ThinkPHP layui完全可以达到开箱即用的效果

并且界面基于ant design的设计，可操作性很强、控制器和栏目支持前后端鉴权，减少Ajax的请求、封装了大量常用的组件和快捷属性、

支持全文索引XS/ElasticSearch轻松支持PB级数据、并且采用了基于ThinkPHP的原生插件模式，可以轻松迁移其他TP插件；

## 重要通知

> 当前版本为核心版, 以下部分模块在当前版本以至后期的升级版本中，都会已插件的方式存在
```injectablephp
> 也就是说，类似于API、广告管理、全文检索都已经被删掉了。
> 如果你热衷于原生实现某些功能，可以使用 v1.1.0版本；
> 你还需要注意的是，v1.1.0版本已经不再升级和维护！！！
```

## 🔥 集成功能

- [x] `API模块`  支持token鉴权，支持细分规则
- [x] `用户管理` 用户是系统操作者，该功能主要完成系统用户配置。
- [x] `公司管理` 设置公司常用信息，前端标签调用
- [x] `部门管理` 配置系统组织机构（部门、小组），树结构展现支持数据权限。
- [x] `岗位管理` 配置系统用户所属担任职务。
- [x] `菜单管理` 配置系统菜单，操作权限，按钮、栏目等权限标识等。
- [x] `角色管理` 角色菜单权限分配、设置角色按机构进行数据范围权限划分。
- [x] `插件管理` 可开发定制属于自己的插件，可安装升级社区插件！！！
- [x] `导航管理` 支持导航定制，小分类导航配置适合SEO
- [x] `内容管理` 系统默认模型数据已完成后端数据录入，可快速二次开发！！！！
- [x] `广告管理` 运营必选功能，获取广告代码自动校验过期时间
- [x] `数据字典` 对系统中经常使用的一些较为固定的数据进行维护。
- [x] `操作日志` 用户后台操作日志，全局异常、SQL注入等记录
- [x] `TAG过滤`  支持违规词、敏感词配置
- [x] `短信平台` 支持阿里云、腾讯云短信发送
- [x] `附件上传` 支持FTP、阿里云、腾讯云OSS附件上传
- [x] `全文检索` 支持XunSearch、<font color="red">ElasticSearch集群</font>PB级全文检索
- [x] `代码生成` 前后端代码的生成（php、html、layui、sql）支持一键CRUD 。
- [x] `网站安全` 拦截恶意扫描的SQL注入语句，危险函数等
- [ ] `服务监控` 服务监控：监视当前系统CPU、内存、磁盘、堆栈等相关信息。
- [ ] `定时任务` 在线（添加、修改、删除)任务调度包含执行结果日志。


> 自带管理功能太多就不一一列举了，更多功能请下载安装后体验。
> 注意：框架默认集成了第三方社会化登录、前端用户注册/登录 邮件发送、点击、评论、评分等功能。


## ✨ 组件属性
本框架封装了layui前端页面的很多属性，比如：
```
 表单提交，时间组件、滑块、评分、开关、下拉框、颜色选择器
 lay-ajax/lay-open/lay-batch/lay-event/lay-upload/lay-image-hover/lay-image-click # 具体的可以参考开发文档
```

## 🛠️ 安装使用
1、首先将本框架直接clone到你本地,或者直接下载
```
git clone https://gitee.com/meystack/swiftadmin.git
```
<font color="#dd0000">2、以宝塔面板为例：将你的网站访问目录修改为public文件夹</font>
```
请自行安装宝塔面板，并做好相关配置！
注意：请一定设置伪静态规则，宝塔面板有自带的TP伪静态
```
3、本地搭建好运行环境后，访问网址进行系统安装
```
http://www.swiftadmin.net/ # 把该域名换成你的域名
```


## ⁉️ 常见问题

在安装的过程中你可能会出现以下问题
> 安装500问题 ; 

```

安装的时候直接报500错误，请确保你的runtime有写入权限，如果还存在错误的话，请在根目录创建.env文件，并设置app_debug = 1

或者你可以直接浏览Apache 或者NGINX的访问日志，可以快速的定位到问题所在

```


## 📃 征集PR
> 开源项目的发展，离不开您的支持、所以现征集以下PR

1、规则验证类，目前的验证器规则写的不是很全面，为了可以让当前数据更加健壮， 
   
    你可以在验证器里面增加一些验证规则补全进行PR的提交；比如限定写数据的提交的格式，非字母 数字之类

2、CSS样式类，当默认的几款皮肤，可能有些CSS没有写入到位，你可以补充CSS样式

3、代码流程 函数命名的优化，当某些函数命名规则有问题的时候，你可以重命名这个函数，使其更具有代表意义！

4、文档的编写，目前文档已经开源至项目本身，可在线编译文档进行PR提交合并。

5、控制台，分析页，监控页的AJAX数据调用，你可以写一个接口，页面定时任务去调用这些数据进行显示

6、多语言包的制作，缺少未翻译的语句可以自行翻译提交到仓库合并

7、预埋HOOK钩子，并把他同步到文档中已做说明，钩子只需要写一行就可以了！！！参考TP6事件。


## 🖼️ 软件截图
<table>
    <tr>
        <td><img src="https://www.swiftadmin.net/static/images/sademo/135434_82477f64_904542.png"/></td>
        <td><img src="https://www.swiftadmin.net/static/images/sademo/135446_e5a0fb94_904542.png"/></td>
    </tr>
    <tr>
        <td><img src="https://www.swiftadmin.net/static/images/sademo/135451_c75d3ca2_904542.png"/></td>
        <td><img src="https://www.swiftadmin.net/static/images/sademo/135457_d4429ce5_904542.png"/></td>
    </tr>
    <tr>
        <td><img src="https://www.swiftadmin.net/static/images/sademo/122537_60f07d17_904542.png"/></td>
        <td><img src="https://www.swiftadmin.net/static/images/sademo/122545_8b8872af_904542.png"/></td>
    </tr>
    <tr>
        <td><img src="https://www.swiftadmin.net/static/images/sademo/122556_1f07ce34_904542.png"/></td>
        <td><img src="https://www.swiftadmin.net/static/images/sademo/122603_373375e6_904542.png "/></td>
    </tr>
    <tr>
        <td><img src="https://www.swiftadmin.net/static/images/sademo/122610_b79d5d77_904542.png"/></td>
        <td><img src="https://www.swiftadmin.net/static/images/sademo/122618_1f8983ad_904542.png"/></td>
    </tr>	
</table>

## 🔥 项目演示
<table>
	<tr>
		<td><img src="https://www.swiftadmin.net/static/images/sademo/135519_aa76fdcf_904542.gif"/></td>
	</tr>
	<tr>
		<td><img src="https://gitee.com/meystack/swiftadmin/raw/master/public/upload/1.gif"/></td>
	</tr>	
	<tr>
		<td><img src="https://www.swiftadmin.net/static/images/sademo/140708_8baf92f1_904542.gif"/></td>
	</tr>	
</table>

## ✔️ 特别鸣谢

感谢以下的项目,排名不分先后

jQuery：http://jquery.com

layui: https://www.layuion.com

ThinkPHP：http://www.thinkphp.cn
> 感谢Jetbrains 免费License ：https://www.jetbrains.com/


## 📋 如何使用？
> 推荐你以下两种快速使用的方法：<br/>

1、你可以在此基础上直接进行二次开发，前端已经为你准备了若干个常用的PHP接口文件

2、你可以在后台插件管理中安装你所需要的完整应用或者部分插件，注意安装完整应用请参考插件文档，如有安装文件冲突，会生成一个文件`冲突TXT`以供查阅！

## ©️ 版权信息

[`SwiftAdmin`] 遵循Apache2开源协议发布，并提供免费使用。

使用本框架不得用于开发违反国家有关政策的相关软件和应用，否则要付法律责任！

本软件依法享有国家著作权保护，故使用本软件者不得恶意篡改本源码，包括但不限于（植入木马病毒，违法应用）进行恶意传播。

不得对本软件进行恶意篡改或倒卖，不得对本软件进行二次包装后声称为自己的产品等，请尊重国家著作权法！

本项目著作权号 `2021SR0761953`, 其中包含的第三方源码和二进制文件之版权信息另行标注。

版权所有Copyright © 2020-2030 by swiftadmin (https://www.swiftadmin.net)

All rights reserved。

## 😊 捐助我们

<table>
	<tr>
		<td><img src="https://www.swiftadmin.net/static/images/pay/wxfk.jpg" width="220"/></td>
		<td><img src="https://www.swiftadmin.net/static/images/pay/zfbfk.jpg" width="220" /></td>
	</tr>
</table>
<code>👍👍👍👍👍👍 您的捐助和赞赏，将会是SAPHP极速后台开发框架和社区得到更快更好的发展！</code>