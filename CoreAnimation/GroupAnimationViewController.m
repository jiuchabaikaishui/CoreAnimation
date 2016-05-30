//
//  GroupAnimationViewController.m
//  CoreAnimation
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 QSP. All rights reserved.
//

#import "GroupAnimationViewController.h"

@interface GroupAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation GroupAnimationViewController
#pragma mark - 控制器周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.button.layer.cornerRadius = 15;
    self.button.layer.masksToBounds = YES;
}

#pragma mark - 触摸点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self groupAnimation];
}
- (IBAction)buttonClicked:(UIButton *)sender {
    NSLog(@"%@",sender);
}

#pragma mark - 自定义方法
- (void)groupAnimation
{
    //1.创建组动画
    CAAnimationGroup *group = [CAAnimationGroup animation];
    //2.将其他动画加入组动画中
    group.animations = @[[self creatOpacityAnimation],[self creatKeyfromAnimation]];
    group.duration = 0.5;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    //1.将动画组添加到图层上
    [self.button.layer addAnimation:group forKey:nil];
}
- (CABasicAnimation *)creatOpacityAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"opacity";
    animation.fromValue = @(0);
    animation.toValue = @(1);
    
    return animation;
}
- (CAKeyframeAnimation *)creatKeyfromAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, self.view.center.x + 50, self.view.center.y, 50, M_PI, 0, YES);
    animation.path = path;
    
    return animation;
}

@end
