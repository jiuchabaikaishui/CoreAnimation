//
//  TransitionViewController.m
//  CoreAnimation
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 QSP. All rights reserved.
//

#import "TransitionViewController.h"

@interface TransitionViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (assign,nonatomic) int pageNumber;

@end

@implementation TransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)panGestureAction:(UIPanGestureRecognizer *)sender {
}
- (IBAction)swipeGestureAction:(UISwipeGestureRecognizer *)sender {
    NSString *picName;
    CATransition *animation = [CATransition animation];
    /* 转场动画
         动画属性：
         type:执行什么样的动画。
         属性取值：
                fade     //交叉淡化过渡(不支持过渡方向) kCATransitionFade
                push     //新视图把旧视图推出去  kCATransitionPush
                moveIn   //新视图移到旧视图上面   kCATransitionMoveIn
                reveal   //将旧视图移开,显示下面的新视图  kCATransitionReveal
                cube     //立方体翻滚效果
                oglFlip  //上下左右翻转效果
                suckEffect   //收缩效果，如一块布被抽走(不支持过渡方向)
         rippleEffect //滴水效果(不支持过渡方向)
         pageCurl     //向上翻页效果
                pageUnCurl   //向下翻页效果
                cameraIrisHollowOpen  //相机镜头打开效果(不支持过渡方向)
                cameraIrisHollowClose //相机镜头关上效果(不支持过渡方向)
         startProgress:动画从什么时候开始（相对于整个动画过程）
         endProgress:动画从什么时候结束（相对于整个动画过程）
         
         subType:动画的方向
          kCATransitionFromRight：从右边
          kCATransitionFromLeft：从左边
          kCATransitionFromBottom：从底部
          kCATransitionFromTop：从上边
     */
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        self.pageNumber --;
        if (self.pageNumber < 0) {
            self.pageNumber = 8;
        }
        picName = [NSString stringWithFormat:@"%i.jpg",abs(self.pageNumber + 1)];
        animation.type = @"pageUnCurl";
        //animation.subtype = kCATransitionFromRight;
        animation.duration = 0.5;
    }
    else if (sender.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        self.pageNumber ++;
        if (self.pageNumber > 8) {
            self.pageNumber = 0;
        }
        picName = [NSString stringWithFormat:@"%i.jpg",self.pageNumber + 1];
        animation.type = @"pageCurl";
        animation.subtype = kCATransitionFromBottom;
        animation.duration = 0.5;
    }
    self.imageView.image = [UIImage imageNamed:picName];
    [self.imageView.layer addAnimation:animation forKey:nil];
}

@end
