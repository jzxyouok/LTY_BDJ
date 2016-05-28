//
//  LTYAddTargetViewController.m
//  01-百思不得姐
//
//  Created by AYuan on 16/5/22.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYAddTargetViewController.h"

@interface LTYAddTargetViewController ()

/** 内容*/
@property (nonatomic, weak) UIView *contentView;
/** 标签按钮*/
@property (nonatomic, weak) UIButton *targetBtn;
/** 文本输入框*/
@property (nonatomic, weak) UITextField *textField;
/** 标签数组 */
@property (nonatomic, strong) NSMutableArray *tagArray;



@end

@implementation LTYAddTargetViewController

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
        
        UIButton *targetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        targetBtn.width = self.contentView.width;
        targetBtn.height = 35;
        [targetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [targetBtn addTarget:self action:@selector(addTargetBtn) forControlEvents:UIControlEventTouchUpInside];
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

/*
 * 添加标签按钮
 */
- (void)addTargetBtn
{
    //添加一个标签按钮
    UIButton *tabButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tabButton setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
    [tabButton setTitle:self.textField.text forState:UIControlStateNormal];
    [tabButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [tabButton setBackgroundColor:LTYTabBg];
    [tabButton sizeToFit];
    [tabButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:tabButton];
    [self.tagArray addObject:tabButton];
    
    //更新标签按钮的frame
    [self updateTagButtonFrame];
    
    //清空textfield文字
    self.textField.text = nil;
    self.targetBtn.hidden = YES;
    
}

/*
 * 专门用来更新标签按钮的frame
 */
- (void)updateTagButtonFrame
{
    
    for (int i = 0; i < self.tagArray.count; i++) {
    
        UIButton *tagButton = self.tagArray[i];
        if (i == 0) { //第一个标签按钮
            tagButton.x = 0;
            tagButton.y = 0;
        } else { //其他标签按钮
            UIButton *lastTagButton = self.tagArray[i - 1];
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
    
    
    //更新textField的frame
    self.textField.x = 0;
    self.textField.y = CGRectGetMaxY([[self.tagArray lastObject] frame]) + LTYTargetMargin;
    
}

/*
 * 标签按钮的点击
 */
- (void)tagButtonClick:(UIButton *)tagButton
{
    [tagButton removeFromSuperview];
    [self.tagArray removeObject:tagButton];
    //更新所有标签按钮的frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
    }];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    
    [self setupContentView];
    
    [self setupTextFiled];
}

- (void)setupTextFiled
{
    UITextField *textField = [[UITextField alloc] init];
    textField.width = LTYScreenW;
    textField.height = 25;
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    [textField becomeFirstResponder];
    [self.contentView addSubview:textField];
    self.textField = textField;
    
}

- (void)textDidChange
{
    if (self.textField.hasText) { // 有文字
        // 显示"添加标签"的按钮
        self.targetBtn.hidden = NO;
        self.targetBtn.y = CGRectGetMaxY(self.textField.frame) + LTYTargetMargin;
        [self.targetBtn setTitle:[NSString stringWithFormat:@"添加标签: %@", self.textField.text] forState:UIControlStateNormal];
    } else { // 没有文字
        // 隐藏"添加标签"的按钮
        self.targetBtn.hidden = YES;
    }
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

- (void)done
{
    
}


@end
