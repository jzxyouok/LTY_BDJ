# LTY_BDJ
##精仿百思不得姐iOS客户端
##截图
<img src="https://github.com/AAYuan/LTY_BDJ/blob/master/readme/all.gif" width="375" height="667" />
<img src="https://github.com/AAYuan/LTY_BDJ/blob/master/readme/publish.gif" width="375" height="667" />
<p></p>
<img src="https://github.com/AAYuan/LTY_BDJ/blob/master/readme/comment.gif" width="375" height="667" />
<img src="https://github.com/AAYuan/LTY_BDJ/blob/master/readme/login.gif" width="375" height="667" />
<p></p>
<img src="https://github.com/AAYuan/LTY_BDJ/blob/master/readme/me.gif" width="375" height="667" />
<img src="https://github.com/AAYuan/LTY_BDJ/blob/master/readme/recommand.gif" width="375" height="667" />

##说明

- 开发工具：Xcode7 Charles
- 完成功能
   - 音频、视频、图片、大图、段子、评论等帖子的显示
   - 自定义MenuView TabBar Button Cell TextView以及一些工具类 都在项目中封装好了 拿到我的接口就可以直接用
   - '关注'NavigationController中点击navigationItem的leftBarButtonItem会进入推荐控制器
   - '推荐'控制器是采用两个tableview放在同一个controller中做的抽屉模型  
   - '我'模块中点击小方格加载webview
   - 发布、登录、注册、的动画
   - 图片下载进度

- 现有问题 
   - 点击tabBarItem中发布按钮发布视图 退出时有些问题 需要重复点击才能退出 还望各位同学能指正
   - 由于接口限制，登录功能没有实现 所以分享和收藏等没有实现
   - 音视频没有传上来 代码重构之后视频播放有时会崩掉 稍后完善 音视频我采用系统AVPlayer开发并封装好了 如果有同学需要我会传上来
   - 发段子中的标签模块正在完善中 
   - 如果有什么错误欢迎大家指正 请Issues或Email ayuan95@yeah.net

##依赖 
- DACircularProgress
- SDWebImage
- AFNetworking
- NJKWebViewProgress
- MJRefresh
- MJExtension
- pop
- SVProgressHUD


