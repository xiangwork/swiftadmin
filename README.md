SwiftAdminPHP 极速后台开发框架
===============
> `SwiftAdmin` 基于ThinkPHP6版本开发， 学习本手册有利于您快速的掌握本框架的开发架构！

![logo](https://images.gitee.com/uploads/images/2021/0412/110400_6a5e130d_904542.png "logo.png")

[     ](https://gitee.com/meystack/swiftadmin/)                                                       ![](https://cdn.nlark.com/yuque/0/2021/svg/8402819/1610364922243-0b15baa9-4ed4-4b1c-abfe-13e08d844790.svg#align=left&display=inline&height=20&margin=%5Bobject%20Object%5D&originHeight=20&originWidth=118&size=0&status=done&style=none&width=118)  ![](https://cdn.nlark.com/yuque/0/2021/svg/8402819/1610364922073-b2bfd470-e92f-495f-bef8-5f6923e91b5c.svg#align=left&display=inline&height=20&margin=%5Bobject%20Object%5D&originHeight=20&originWidth=100&size=0&status=done&style=none&width=100)  ![](https://cdn.nlark.com/yuque/0/2021/svg/8402819/1610364921931-98fdac7d-cf4d-4bed-b8a1-d5d0d17c07a3.svg#align=left&display=inline&height=20&margin=%5Bobject%20Object%5D&originHeight=20&originWidth=86&size=0&status=done&style=shadow&width=86)  [![](https://cdn.nlark.com/yuque/0/2021/svg/8402819/1610364920693-f9a5b0b9-3bb2-4cdb-bf26-300d2c102b36.svg#align=left&display=inline&height=21&margin=%5Bobject%20Object%5D&originHeight=21&originWidth=75&size=0&status=done&style=none&width=75)](https://gitee.com/meystack/swiftadmin/)

## 开发初衷

1. `SwiftAdmin` 框架的开发，主要也是为了减少在自己开发过程中的频繁造轮子，并且swiftAdmin框架主张简单就是高效的原则，相信没有比判断0或者1更有效率的算法了吧，所以最简单的东西才是效率最高的，可能你的应用场景很复杂，但是你可以把复杂的事情简单化，复杂的维度无外乎  `n+0 or 1` 



2. 在最开始接触互联网的时候，都是用一些开源的CMS系统制作自己的网站，后期因为扩展和二次开发的问题，导致觉得很多东西并不是那么简单易用，比如后台的很多JS代码封装的不是很好，而且界面也操作性很差，所以自己开发这款框架封装了很多常用的特性，足以满足日常后台的开发需要，在使用的过程中你会发现，SA框架里面用的最多的是属性而不是对象，一是为了在书写HTML标签的时候方便。二是为了和layui本身区分开！这样让你更容易在这个上面进行扩展！



3. 由于我本人不太喜欢一键增删改查，因为一键增删改查的方式并不适合大多数硬性的应用场景和逻辑需求，你可能在后期需要摈弃大多数利用了一键CURD的方法进行重载函数，虽然swiftadmin框架里面也有，但swiftadmin框架的设计初衷是为了在易用性和操作性上折中找一个方案来做，当前基于第一个版本的SA框架在这方面的表现还不是特别好。但随着应用场景和市场的检验和优化，本框架会逐步的进行完善和提高性能！



4. 在市面上目前的开源极速开发框架的学习成本略高，想搞一个学习成本极低，但性能不低的框架！



5. 想着开发一款底层设计配置和应用分开的系统，这样对于很多小白用户不会在项目已经上线运行中的时候，误操作系统的配置导致数据丢失，错乱的问题。比如有些字段需要手动在数据库进行修改，



## 侧重点

1、swiftAdmin的架构和开发更倾向于内容管理系统[CMS]的方向，所以如果你使用本框架搭建一个简易的API管理系统，那么你需要自行删除一些不必要的代码文件！使得你的项目在SA精简框架下更易维护！


2、系统默认的缓存机制为redis缓存，所以请确保安装redis扩展和服务器[摒弃操蛋的file缓存吧]


3、如果你只是需要一个极简的API管理系统，那么建议你删除不需要的模块和菜单项！


## 如何使用？
> 推荐你以下两种快速使用SwiftAdmin的方法：<br/>
> 一、 你可以在此基础上直接进行二次开发，前端已经为你准备了若干个常用的PHP接口文件<br/>
> 二、 你可以在后台插件管理中安装你所需要的完整应用或者部分插件，注意安装完整应用的话，
>      是会直接覆盖index.php的，但是会生成一个文件冲突TXT以供查阅！

## 授权协议

1. 本软件支持个人/企业免费商用，二次开发，但必须保留SwiftAdmin的版权标识，包括但不限于（logo、素材、代码注释）
1. 使用本框架不得用于开发违反国家有关政策的相关软件和应用，否则要付法律责任！
1. SwiftAdmin框架及相关官方插件，使用这只拥有本框架和插件的使用权，不具备著作权，故任何人不得使用SwiftAdmin软件来申请著作权
1. 本软件依法享有国家著作权保护，故使用本软件者不得恶意篡改本源码，包括但不限于（植入木马病毒，编写违法应用）进行恶意传播。
1. 不得对本软件进行二次专收或倒卖，不得对本软件进行二次包装后声称为自己的产品等，请尊重国家著作权法！
1. 如需去除软件版权，请购买域名授权，授权期间本软件作者有义务对授权者提供技术支持！



关于`本框架`的入门建议、代码规范、踩坑指南以及常见问题可以参考官方的《[入门必读]()》教程，推荐新手阅读。


发布本资料须遵守开放出版许可协议 MIT 或者更新版本。 
未经版权所有者明确授权，禁止发行本文档及其被实质上修改的版本。 
未经版权所有者事先授权，禁止将此作品及其衍生作品以标准（纸质）书籍形式发行。 
使用SwiftAdmin软件构建的任何项目和应用中如包含的信息内容和服务内容（包括但不限于文字、图片、视频、不当言论等）
以及任何可能导致的法律风险，与SwiftAdmin无关，本软件仅为一款方便开发者构建各类应用的管理员后台基础框架，本身不包含任何非法的功能，欢迎广大授权者进行监督。

如果有兴趣再发行或再版本手册的全部或部分内容，不论修改过与否，或者有任何问题，请联系版权所有者 [coolsec@foxmail.com](mailto:coolsec@foxmail.com)。 
对SwiftAdmin有任何疑问或者建议，请加入官方QQ群  ![](https://cdn.nlark.com/yuque/0/2021/svg/8402819/1610365016652-71ef17b2-710a-4ff1-9857-c8a79b85b55b.svg#align=left&display=inline&height=20&margin=%5Bobject%20Object%5D&originHeight=20&originWidth=98&size=0&status=done&style=none&width=98)  ![](https://cdn.nlark.com/yuque/0/2021/svg/8402819/1610365017264-ef3810ec-cd21-460d-8b1b-9e621df0f975.svg#align=left&display=inline&height=20&margin=%5Bobject%20Object%5D&originHeight=20&originWidth=98&size=0&status=done&style=none&width=98) ![](https://cdn.nlark.com/yuque/0/2021/svg/8402819/1610365134411-34fad338-fa2c-427a-bc6f-2dc609072799.svg#align=left&display=inline&height=20&margin=%5Bobject%20Object%5D&originHeight=20&originWidth=98&size=0&status=done&style=none&width=98) 
有关SwiftAdmin项目及本文档的最新资料，请及时访问SwiftAdmin项目主站 [http://www.swiftadmin.net](http://www.swiftadmin.net)。
> 本文档版权归`SwiftAdmin`文档小组所有，本文档及其描述的内容受有关法律的版权保护，对本文档内容任何形式的非法复制，将导致相应的法律责任。

