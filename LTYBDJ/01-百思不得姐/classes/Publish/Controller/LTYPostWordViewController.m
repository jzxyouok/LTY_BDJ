//
//  LTYPostWordViewController.m
//  01-百思不得姐
//
//  Created by AYuan on 16/5/7.
//  Copyright © 2016年 AYuan. All rights reserved.
//

#import "LTYPostWordViewController.h"
#import "LTYPlacehorderTextView.h"
#import "LTYAddTargetTool.h"

@interface LTYPostWordViewController () <UITextViewDelegate>
/** 文本输入控件*/
@property (nonatomic, weak) LTYPlacehorderTextView *textView;
/** targetTool控件*/
@property (nonatomic, weak) LTYAddTargetTool *targetTool;

@end

@implementation LTYPostWordViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTextView];
    
    [self setupTargetTool];
    
}

- (void)setupTargetTool
{
    LTYAddTargetTool *targetTool = [LTYAddTargetTool viewFromNib];
    targetTool.width = self.view.width;
    targetTool.y = self.view.height - targetTool.height;

    [self.view addSubview:targetTool];
    self.targetTool = targetTool;
    [self.view addSubview:targetTool];
    
}

- (void)setupTextView
{
    LTYPlacehorderTextView *textView = [[LTYPlacehorderTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    [self.view addSubview:textView];
    textView.delegate = self;
    self.textView = textView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 键盘最终的frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.targetTool.transform = CGAffineTransformMakeTranslation(0,keyboardF.origin.y - LTYScreenH);
    }];
}

//如果控件是通过代码创建的 则拿到view的宽高与屏幕是一致的 如果控件是通过xib创建的 则就不一定了
//可以在viewDidLayoutSubviews中布局子控件 确保从xib中加载的控件尺寸准确
//- (void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//}

- (void)setupNav
{
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO;//默认不能点击
    
    
    //强制刷新(有时候设置状态属性但不显示，可能是延迟的问题，则可以强制刷新)
    [self.navigationController.navigationBar layoutIfNeeded];
    //    下面这句不起作用，因为导航控制器与view不在一个层级上，可以拿到导航控制器的view强制刷新
    //    [self.view layoutIfNeeded];
    
    
}

- (void)post
{
    
}

- (void)cancel
{
   [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.textView becomeFirstResponder];
}

#pragma mark - <UITextViewDelegate>

- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.textView endEditing:YES];
}


@end
