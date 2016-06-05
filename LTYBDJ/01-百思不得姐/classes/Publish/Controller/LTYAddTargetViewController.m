//
//  LTYAddTargetViewController.m
//  01-百思不得姐
//
//  Created by AYuan on 16/5/22.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYAddTargetViewController.h"
#import "LTYTagButton.h"
#import "LTYTagTextField.h"

@interface LTYAddTargetViewController () <UITextFieldDelegate>

/** 内容*/
@property (nonatomic, weak) UIView *contentView;
/** 标签按钮*/
@property (nonatomic, weak) UIButton *targetBtn;
/** 文本输入框*/
@property (nonatomic, weak) LTYTagTextField *textField;
/** 标签数组 */
@property (nonatomic, strong) NSMutableArray *tagArray;

@end

@implementation LTYAddTargetViewController

#pragma mark - 懒加载
- (NSMutableArray *)tagArray
{
    if (_tagArray == nil) {
        _tagArray = [NSMutableArray array];
    }
    return _tagArray;
}

- (UIButton *)targetBtn
{
    if (_targetBtn == nil) {
        
        LTYTagButton *targetBtn = [LTYTagButton buttonWithType:UIButtonTypeCustom];
        targetBtn.width = self.contentView.width;
        [targetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [targetBtn addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        targetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        targetBtn.contentEdgeInsets = UIEdgeInsetsMake(0, LTYTargetMargin, 0, LTYTargetMargin);
        // 让按钮内部的文字和图片都左对齐
        targetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        targetBtn.backgroundColor = LTYTabBg;
        [self.contentView addSubview:targetBtn];
        _targetBtn = targetBtn;
    }
    return _targetBtn;
}
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    
    [self setupContentView];
    
    [self setupTextFiled];
}

- (void)done
{
    
}

#pragma mark - 监听文字改变
/*
 *  监听文字改变
 */
- (void)textDidChange
{
    [self updateTagButtonFrame];
    if (self.textField.hasText) { // 有文字
        // 显示"添加标签"的按钮
        self.targetBtn.hidden = NO;
        self.targetBtn.y = CGRectGetMaxY(self.textField.frame) + LTYTargetMargin;
        [self.targetBtn setTitle:[NSString stringWithFormat:@"添加标签: %@", self.textField.text] forState:UIControlStateNormal];
        self.targetBtn.height = 35;
    } else { // 没有文字
        // 隐藏"添加标签"的按钮
        self.targetBtn.hidden = YES;
    }
    
}

#pragma mark - 监听按钮点击
/*
 * 标签按钮的点击
 */
- (void)tagButtonClick:(LTYTagButton *)tagButton
{
    [tagButton removeFromSuperview];
    [self.tagArray removeObject:tagButton];
    //更新所有标签按钮的frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
        [self updateTextFieldFrame];
    }];
    
}

/*
 * 添加标签按钮
 */
- (void)addButtonClick
{
    //添加一个标签按钮
    LTYTagButton *tabButton = [LTYTagButton buttonWithType:UIButtonTypeCustom];
    [tabButton setTitle:self.textField.text forState:UIControlStateNormal];
    
    //sizeToFit要放在设置height的前面 否则设置height后调用sizeToFit又会被算回去
    tabButton.height = self.textField.height;
    [tabButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:tabButton];
    [self.tagArray addObject:tabButton];
    
    //更新标签按钮的frame
    [self updateTagButtonFrame];
    [self updateTextFieldFrame];
    
    //清空textfield文字
    self.textField.text = nil;
    self.targetBtn.hidden = YES;
    
}

#pragma mark - 子控件的frame处理
/*
 * 专门用来更新标签按钮的frame
 */
- (void)updateTagButtonFrame
{
    
    for (int i = 0; i < self.tagArray.count; i++) {
    
        LTYTagButton *tagButton = self.tagArray[i];
        if (i == 0) { //第一个标签按钮
            tagButton.x = 0;
            tagButton.y = 0;
        } else { //其他标签按钮
            LTYTagButton *lastTagButton = self.tagArray[i - 1];
            //当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + LTYTargetMargin;
            //计算当前行右边的宽度
            CGFloat rightWidth = self.contentView.width - leftWidth;
            if (rightWidth >= tagButton.width) { //按钮显示在当前行
                tagButton.x = CGRectGetMaxX(lastTagButton.frame) + LTYTargetMargin;
                tagButton.y = lastTagButton.y;
            }else { //按钮显示在下一行
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastTagButton.frame) + LTYTargetMargin;
            }
        }
    }
}

- (void)updateTextFieldFrame
{
    //更新textField的frame
    LTYTagButton *lastButton = [self.tagArray lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastButton.frame) + LTYTargetMargin;
    if (self.contentView.width - leftWidth >= [self textFieldTextWidth]) {
        self.textField.x = leftWidth;
        self.textField.y = lastButton.y;
    } else {
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastButton.frame) + LTYTargetMargin;
    }

}

- (CGFloat)textFieldTextWidth
{
    CGFloat testFieldWidth = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    
    return MAX(100, testFieldWidth);
}



- (void)setupTextFiled
{
    __weak typeof(self) weakSelf = self;
    LTYTagTextField *textField = [[LTYTagTextField alloc] init];
    textField.width = self.contentView.width;
    textField.height = 25;
    textField.deleteBlock = ^{
        if ([weakSelf.textField hasText]) return;
        [weakSelf tagButtonClick:[weakSelf.tagArray lastObject]];
    };
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    //设置了占位文字内容以后，才能设置占位文字的颜色，这个label内部是懒加载的，有人用再会创建
    [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    [textField becomeFirstResponder];
    [self.contentView addSubview:textField];
    textField.delegate = self;
    self.textField = textField;
    
}


- (void)setupContentView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.x = LTYTargetMargin;
    contentView.y = 64 + LTYTargetMargin;
    contentView.width = LTYScreenW - 2 * LTYTargetMargin;
    contentView.height = LTYScreenW;
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

- (void)setupNav
{
    self.title = @"标签";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成 " style:UIBarButtonItemStyleDone target:self action:@selector(done)];
                                        
}

#pragma mark - <LTYTagTextFieldDelegate>
- (BOOL)textFieldShouldReturn:(LTYTagTextField *)textField
{
    if (textField.hasText) {
        [self addButtonClick];
    }
    return YES;
}


@end
