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

@end

@implementation LTYAddTargetViewController

- (UIButton *)targetBtn
{
    if (_targetBtn == nil) {
        
        UIButton *targetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        targetBtn.width = self.contentView.width;
        targetBtn.height = 35;
        [targetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [targetBtn addTarget:self action:@selector(targetBtnClick) forControlEvents:UIControlEventTouchUpInside];
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

- (void)targetBtnClick
{
    NSLog(@"%s",__func__);
    UIButton *tabButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tabButton setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
    [tabButton setTitle:self.textField.text forState:UIControlStateNormal];
    [tabButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [tabButton setBackgroundColor:LTYTabBg];
    [tabButton sizeToFit];
    [self.contentView addSubview:tabButton];
    self.textField.text = nil;
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
