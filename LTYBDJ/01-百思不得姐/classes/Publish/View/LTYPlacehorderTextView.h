//
//  LTYPlacehorderTextView.h
//  01-百思不得姐
//
//  Created by AYuan on 16/5/10.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTYPlacehorderTextView : UITextView

//封装时，要考虑到提供给别人的属性可能随时会被修改 所以要重写set方法 除了自己定义的属性以外还要考虑到父类等所有肯呢过被修改的属性

/** UITextView的占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;


@end

