//
//  ViewAnimationViewController.m
//  CoreAnimation
//
//  Created by apple on 15/12/7.
//  Copyright © 2015年 QSP. All rights reserved.
//

#import "ViewAnimationViewController.h"
#import "ConFunc.h"

@interface ViewAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageVIew;
@property (strong,nonatomic) NSMutableArray *tapGesturets;
@property (assign,nonatomic) NSInteger index;

@end

@implementation ViewAnimationViewController
#pragma mark - 控制器周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tapGesturets = [self creatTapGesturesWithCount:2];
    [ConFunc addContinuousTapGesturetInView:self.view andTarget:self andTapGesture:self.tapGesturets];
}
#pragma mark - 点击触摸事件
- (void)selfViewTaped:(UITapGestureRecognizer *)sender
{
    NSInteger index = [self.tapGesturets indexOfObject:sender];
    switch (index) {
        case 0:
        {
            //核心动画都是假象，并没有改变真实的属性。
            [UIView transitionWithView:self.view duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{
                self.index ++;
                if (self.index > 8) {
                    self.index = 0;
                }
                self.imageVIew.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i.jpg",(int)self.index + 1]];
            } completion:nil];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - 自定义方法
- (NSMutableArray *)creatTapGesturesWithCount:(int)count
{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
    for (int index = 0; index < count; index++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfViewTaped:)];
        [arr addObject:tap];
    }
    
    return arr;
}

@end
