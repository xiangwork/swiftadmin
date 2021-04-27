## 前言
> 基于ThinkPHP6版本开发， 学习本手册有利于您快速的掌握本框架的开发架构！
<div align="center">
<img src="https://images.gitee.com/uploads/images/2021/0412/110400_6a5e130d_904542.png" width="100" height="100"/>
</div>
<p align="center"><strong>价值源自分享</strong></p>

<p align="center">
	<a href="https://www.swiftadmin.net" target="_blank">官方平台</a> 
    <a href="http://demo.swiftadmin.net/admin.php" rel="nofollow" >在线演示</a>
	<a href="https://www.yuque.com/meystack/swiftadmin"  target="_blank">在线使用手册</a>
</p>
<p align="center">
<font size="20" >请先右上角送颗星星，谢谢！</font>
</p>
<b>请注意，本框架只支持PHP8版本，低版本已经不兼容了~ </b><br/>
<b>请注意，框架安装成功后会自动删除安装脚本文件！！！</b><br/>
<b>开发环境：Windows服务器版 VScode Apache MySQL5.7 PHP8</b><br/>
<b>后台演示 <a href="http://demo.swiftadmin.net/admin.php"  target="_blank">http://demo.swiftadmin.net/admin.php</a> </b><br/>
<b>管理账号  admin admin888 </b><br/>
<b>测试账号  ceshi admin888 </b>注意：前端使用JavaScript鉴权！<br/>

<a href="https://gitee.com/meystack/swiftadmin/"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="swiftadmin"></a>
<a href="https://gitee.com/meystack/swiftadmin/"><img src="https://img.shields.io/badge/ThinkPHP-6.0.8-brightgreen.svg" alt="thinkphp"></a>
<a href="https://gitee.com/meystack/swiftadmin/"><img src="https://img.shields.io/badge/Layui-2.6.4-red.svg" alt="layui"></a>
<a href="https://gitee.com/meystack/swiftadmin/stargazers"><img src="https://gitee.com/meystack/swiftadmin/badge/star.svg?theme=gvp" alt="star"></a>
<a href="https://gitee.com/meystack/swiftadmin/members"><img src="https://gitee.com/meystack/swiftadmin/badge/fork.svg?theme=gvp" alt="fork"></a>
<a href="https://qm.qq.com/cgi-bin/qm/qr?k=Idivrh-log25t0ryx19nWeqUk8oFrI-X&jump_from=webapi"><img src="https://img.shields.io/badge/qq一群-68221484-blue.svg" alt="一群"></a>
<a href="https://qm.qq.com/cgi-bin/qm/qr?k=L_SKDh46TnWDVrudKEON2XAlgm02RNic&jump_from=webapi"><img src="https://img.shields.io/badge/qq二群-68221585-blue.svg" alt="二群"></a>
<a href="https://qm.qq.com/cgi-bin/qm/qr?k=p6N-b7AkWiESpcrZmOKWpm3t05qt4MQ-&jump_from=webapi"><img src="https://img.shields.io/badge/qq三群-68221618-blue.svg" alt="三群"></a>

### `在官网搭建好之前，更新日志都先会发在这里`

## v1.0.1
> v1.0.1 对代码进行重构和修复，有以下改动

* 重写了AUTH鉴权类，鉴权更清晰明了，代码更健壮
* 框架默认自带的模型，后端数据添加修改已编写完毕，你可以直接注重前端开发
* 摒弃config获取配置信息字符过长，自写saenv函数获取变量更简单[默认system]
* 重写回收站操作逻辑，注重主要数据的维护，只在操作界面保留主要模型的数据恢复与销毁
* 增加了自动图片本地化、自动祛除非本站链接、自动提取缩略图、自动获取对象属性
* 编写了大量常用标签，增加TAG违禁字检测、网站内链功能，强化SEO效果！！！
* 修复代码审计后的中危/高危漏洞、提高代码安全质量！
* 修复了各种已知的BUG。。。。

- 去掉了默认继承的回收站、还原和销毁方法
--- 

## 开发初衷

1.  swiftadmin框架的开发，主要是为了减少在自己开发过程中的频繁造轮子，并且swiftAdmin框架主张简单就是高效的原则，相信没有比判断0或者1更有效率的算法了吧，所以最简单的东西才是效率最高的，可能你的应用场景很复杂，但是你可以把复杂的事情简单化！

2.  在最开始接触互联网的时候，都是用一些开源的CMS系统制作自己的网站，后期因为扩展和二次开发的问题，导致觉得很多东西并不是那么简单易用，比如后台的很多JS代码封装的不是很好，而且界面也操作性很差，所以自己开发这款框架封装了很多常用的特性，足以满足日常后台的开发需要，在使用的过程中你会发现，SAPHP框架里面用的最多的是属性而不是对象，一是为了在书写HTML标签的时候方便。二是为了和layui本身区分开！这样让你更容易在这个上面进行扩展！

3.  系统默认从基础控制器继承了增删改查操作。但这种方式并不适合大多数硬性的应用场景和逻辑需求，你可能在后期需要摈弃大多数利用了一键CURD的方法进行重载函数，虽然swiftadmin框架里面也有，但swiftadmin框架的设计初衷是为了在易用性和操作性上折中找一个方案来做，当前基于第一个版本的SAPHP框架在这方面的表现还不是特别好。但随着应用场景检验和优化，本框架会逐步的进行完善和提高性能！

4.  在市面上目前的开源极速开发框架的学习成本略高，想搞一个学习成本极低，但性能不低的框架！

5.  想着开发一款底层设计配置和应用分开的系统，这样对于很多小白用户不会在项目已经上线运行中的时候，误操作系统的配置导致数据丢失，错乱的问题。比如有些字段需要手动在数据库进行修改，


## 侧重点

 +  一、swiftAdmin的架构和开发更倾向于内容管理系统[CMS]的方向，当然你也可以当中API系统使用<br/>
 
 +  二、系统默认的缓存机制为redis缓存，所以请确保安装redis扩展和服务器[摒弃操蛋的file缓存吧]<br/>

 *  三、如果你只是需要一个极简的API管理系统，那么建议你删除不需要的模块和菜单项！<br/>

 *  四、本框架会侧重于SEO优化、流量管理、蜘蛛池、区块链以及采集方面的应用！！！<br/>

 *  五、本框架会逐渐偏向于社区版开源的方向，主要由社区共同的爱好者免费开发维护插件！！！

 *  六、本框架特别适合个人开发者和小型创业公司，找一款真正适合自己的框架不容易，所以先来试试swiftadmin吧！

## `框架优势`

* `代码量最少、逻辑最清晰`

* `入门学习成本是同类框架中最低的`

* `界面基于ant design设计 [可操作性强]`

* `控制器与栏目管理双鉴权，满足日常大部分需求`

* `前端JavaScript鉴权，后端AUTH类鉴权，减少请求`

* `代码安全质量高，修复大部分低危、高危代码漏洞`

* `高占比AJAX数据调用，响应速度可媲美前后端分离`

## 集成功能

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
- [ ] `服务监控` 服务监控：监视当前系统CPU、内存、磁盘、堆栈等相关信息。
- [ ] `定时任务` 在线（添加、修改、删除)任务调度包含执行结果日志。
- [ ] `代码生成` 前后端代码的生成（php、html、layui、sql）支持一键CRUD 。

> 自带管理功能太多就不一一列举了，更多功能请下载安装后体验。
> 注意：框架默认集成了第三方社会化登录、前端用户注册/登录 邮件发送、点击、评论、评分等功能。


## 组件属性
本框架封装了layui前端页面的很多属性，比如：
```
 表单提交，时间组件、滑块、评分、开关、下拉框、颜色选择器
 lay-ajax/lay-open/lay-batch/lay-event/lay-upload/lay-image-hover/lay-image-click # 具体的可以参考开发文档
```

## 安装使用
1、首先将本框架直接clone到你本地,或者直接下载
```
git clone https://gitee.com/meystack/swiftadmin.git
```
<font color="#dd0000">2、以宝塔面板为例：将你的网站访问目录修改为public文件夹</font>
```
请自行安装宝塔面板，并做好相关配置！
```
3、在根目录直接执行 composer install 命令加载第三方库即可！
```
composer install
```
或者使用一键安装命令 请确保你的机器上安装了 Composer
```
通过 Composer 来管理依赖，Linux系统请sudo composer install
git clone https://gitee.com/meystack/swiftadmin.git ./src && cd src && composer install
```

## 软件截图
<table>
    <tr>
        <td><img src="https://images.gitee.com/uploads/images/2021/0412/135434_82477f64_904542.png"/></td>
        <td><img src="https://images.gitee.com/uploads/images/2021/0412/135446_e5a0fb94_904542.png"/></td>
    </tr>
    <tr>
        <td><img src="https://images.gitee.com/uploads/images/2021/0412/135451_c75d3ca2_904542.png"/></td>
        <td><img src="https://images.gitee.com/uploads/images/2021/0412/135457_d4429ce5_904542.png"/></td>
    </tr>
    <tr>
        <td><img src="https://images.gitee.com/uploads/images/2021/0427/122537_60f07d17_904542.png"/></td>
        <td><img src="https://images.gitee.com/uploads/images/2021/0427/122545_8b8872af_904542.png"/></td>
    </tr>
    <tr>
        <td><img src="https://images.gitee.com/uploads/images/2021/0427/122556_1f07ce34_904542.png"/></td>
        <td><img src="https://images.gitee.com/uploads/images/2021/0427/122603_373375e6_904542.png "/></td>
    </tr>
    <tr>
        <td><img src="https://images.gitee.com/uploads/images/2021/0427/122610_b79d5d77_904542.png"/></td>
        <td><img src="https://images.gitee.com/uploads/images/2021/0427/122618_1f8983ad_904542.png"/></td>
    </tr>	
</table>

## 项目演示
<table>
	<tr>
		<td><img src="https://images.gitee.com/uploads/images/2021/0412/135519_aa76fdcf_904542.gif"/></td>
	</tr>
	<tr>
		<td><img src="https://images.gitee.com/uploads/images/2021/0412/140708_8baf92f1_904542.gif"/></td>
	</tr>	
	<tr>
		<td><img src="https://images.gitee.com/uploads/images/2021/0412/151945_66490698_904542.gif"/></td>
	</tr>	    
</table>

## 如何使用？
> 
> 推荐你以下两种快速使用SwiftAdmin的方法：<br/>
> 一、 你可以在此基础上直接进行二次开发，前端已经为你准备了若干个常用的PHP接口文件<br/>
> 二、 你可以在后台插件管理中安装你所需要的完整应用或者部分插件，注意安装完整应用的话，
>      是会直接覆盖index.php的，但是会生成一个文件冲突TXT以供查阅！<br/>

## 授权协议
> 
1. 本软件支持个人/企业免费商用，二次开发，但必须保留SwiftAdmin的版权标识，包括但不限于（logo、素材、代码注释）
2. 使用本框架不得用于开发违反国家有关政策的相关软件和应用，否则要付法律责任！
3. SwiftAdmin框架及相关官方插件，使用这只拥有本框架和插件的使用权，不具备著作权，故任何人不得使用SwiftAdmin软件来申请著作权
4. 本软件依法享有国家著作权保护，故使用本软件者不得恶意篡改本源码，包括但不限于（植入木马病毒，编写违法应用）进行恶意传播。
5. 不得对本软件进行二次专收或倒卖，不得对本软件进行二次包装后声称为自己的产品等，请尊重国家著作权法！
6. 如需去除软件版权，请购买域名授权，授权期间本软件作者有义务对授权者提供技术支持！