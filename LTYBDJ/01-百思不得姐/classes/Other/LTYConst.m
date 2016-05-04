
#import <UIKit/UIKit.h>

/** 精华-顶部标题的高度 */
CGFloat const LTYTitilesViewH = 35;
/** 精华-顶部标题的Y */
CGFloat const LTYTitilesViewY = 64;

/** 精华-cell-间距 */
CGFloat const LTYTopicCellMargin = 10;
/** 精华-cell-文字内容的Y值 */
CGFloat const LTYTopicCellTextY = 55;
/** 精华-cell-底部工具条的高度 */
CGFloat const LTYTopicCellBottomBarH = 35;

/** 精华-cell-图片帖子的最大高度 */
CGFloat const LTYTopicCellPictureMaxH = 1000;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
CGFloat const LTYTopicCellPictureBreakH = 250;

/** LTYUserMal用户性别- 男 */
NSString * const LTYUserSexMale = @"m";
/** LTYUserFemal用户性别- 女 */
NSString * const LTYUserSexFemal = @"f";

/** 精华-cell-最热评论标题的高度 */
CGFloat const LTYTopicCellTopCmtTitleH = 20;

/** tabBar被选中的通知名字*/
NSString * const LTYTabBarDidSelectNotification = @"LTYTabBarDidSelectNotification";
/** tabBar被选中的通知 - 被选中的控制器的index key*/
NSString * const LTYUserSelectControllerKey = @"LTYTabBarDidSelectNotification";
/** tabBar被选中的通知 - 被点击的控制器的key*/
NSString * const LTYUserSelectController = @"LTYTabBarDidSelectNotification";
