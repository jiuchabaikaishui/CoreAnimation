//
//  CAKeyfromAnimationViewController.m
//  CoreAnimation
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 QSP. All rights reserved.
//

#import "CAKeyfromAnimationViewController.h"
#import "ConFunc.h"

@interface CAKeyfromAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIView *animationView;
@property (weak, nonatomic) IBOutlet UIView *shakeView;
@property (strong,nonatomic) NSArray *tapGestures;

@end

@implementation CAKeyfromAnimationViewController
#pragma mark - 属性方法
- (NSArray *)tapGestures
{
    if (_tapGestures == nil) {
        _tapGestures = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _tapGestures;
}
#pragma mark - 控制器周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatKeyFromAnimationWithCount:3];
}

#pragma mark - 触摸点击方法
- (void)selfViewTaped:(UITapGestureRecognizer *)sender
{
    NSInteger index = [self.tapGestures indexOfObject:sender];
    if (index == 2) {
        [self keyFromAnimationInView:self.shakeView andTapCount:index + 1];
    }
    else
        [self keyFromAnimationInView:self.animationView andTapCount:index + 1];
}

#pragma mark - 自定义方法
- (void)creatKeyFromAnimationWithCount:(NSInteger)count
{
    self.tapGestures = [self creatTapGesturesWithCount:count];
    [ConFunc addContinuousTapGesturetInView:self.view andTarget:self andTapGesture:self.tapGestures];
}
- (NSArray *)creatTapGesturesWithCount:(NSInteger)count
{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
    for (int index = 0; index < count; index++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfViewTaped:)];
        [arr addObject:tap];
    }
    
    return arr;
}
- (void)keyFromAnimationInView:(UIView *)view andTapCount:(NSInteger)count
{
    //1.创建动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    //2.设置动画属性
    /*
        values:指明整个动画过程中的关键帧点，需要注意的是，起点必须作为values的第一个值。
     
        keyTimes:该属性是一个数组，用以指定每个子路径(AB,BC,CD)的时间。如果你没有显式地对keyTimes进行设置，则系统会默认每条子路径的时间为：ti=duration/(5-1)，即每条子路径的duration相等，都为duration的1\4。当然，我们也可以传个数组让物体快慢结合。例如，你可以传入{0.0, 0.1,0.6,0.7,1.0}，其中首尾必须分别是0和1，因此tAB=0.1-0, tCB=0.6-0.1, tDC=0.7-0.6, tED=1-0.7.....
     
        path:动画运动的路径。
     
        repeatCount:动画重复次数。
     
        timingFunctions:这个属性用以指定时间函数，控制动画节奏，类似于运动的加速度，有以下几种类型。记住，这是一个数组，你有几个子路径就应该传入几个元素
            属性值描述：
                1 kCAMediaTimingFunctionLinear//线性
                2 kCAMediaTimingFunctionEaseIn//淡入
                3 kCAMediaTimingFunctionEaseOut//淡出
                4 kCAMediaTimingFunctionEaseInEaseOut//淡入淡出
                5 kCAMediaTimingFunctionDefault//默认
     
        calculationMode：该属性决定了物体在每个子路径下是跳着走还是匀速走，跟timeFunctions属性有点类似
            属性值描述：
                1 const kCAAnimationLinear//线性，默认
                2 const kCAAnimationDiscrete//离散，无中间过程，但keyTimes设置的时间依旧生效，物体跳跃地出现在各个关键帧上
                3 const kCAAnimationPaced//平均，keyTimes跟timeFunctions失效
                4 const kCAAnimationCubic//平均，同上
                5 const kCAAnimationCubicPaced//平均，同上
     */
    animation.delegate = self;
    
    switch (count) {
        case 1:
        {
            animation.keyPath = @"position";
            CGPoint centerP = self.view.center;
            CGFloat L = [UIScreen mainScreen].bounds.size.width - 100;
            NSValue *value1 = [NSValue valueWithCGPoint:centerP];
            NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(centerP.x - L/2, centerP.y - L/2)];
            NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(centerP.x + L/2, centerP.y - L/2)];
            NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(centerP.x + L/2, centerP.y + L/2)];
            NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(centerP.x - L/2, centerP.y + L/2)];
            NSValue *value6 = [NSValue valueWithCGPoint:CGPointMake(centerP.x - L/2, centerP.y - L/2)];
            NSValue *value7 = [NSValue valueWithCGPoint:centerP];
            animation.values = @[value1,value2,value3,value4,value5,value6,value7];
            
            //animation.keyTimes = @[@(0),@(0.1),@(0.3),@(0.5),@(0.7),@(0.9),@(1)];
            animation.duration = 5;
            
            animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        }
            break;
        case 2:
        {
            animation.keyPath = @"position";
            CGMutablePathRef path = CGPathCreateMutable();
            CGFloat main_screen_w = [UIScreen mainScreen].bounds.size.width;
            CGFloat main_screen_h = [UIScreen mainScreen].bounds.size.height;
            CGFloat view_w = 100;
            CGPathAddEllipseInRect(path, NULL, CGRectMake(view_w/2, view_w/2, main_screen_w - view_w, main_screen_h - view_w - 49));
            animation.path = path;
            CGPathRelease(path);
            
            animation.duration = 10;
            
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        }
            break;
        case 3:
        {
            animation.keyPath = @"transform.rotation.z";
            animation.values = @[@(0),@(M_PI_4),@(-M_PI_4),@(0)];
            animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
            animation.duration = 2;
            animation.repeatCount = MAXFLOAT;
        }
            break;
            
        default:
            break;
    }
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    //3.添加动画到图层
    [view.layer addAnimation:animation forKey:nil];
}
- (void)animationDidStart:(CAAnimation *)anim
{
    self.view.userInteractionEnabled = NO;
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.view.userInteractionEnabled = YES;
}

@end
