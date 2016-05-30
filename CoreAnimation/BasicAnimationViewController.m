//
//  ViewController.m
//  CoreAnimation
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 QSP. All rights reserved.
//

#import "BasicAnimationViewController.h"
#import "ConFunc.h"

#define Main_Screen_With      [UIScreen mainScreen].bounds.size.width
#define Main_Screen_Height    [UIScreen mainScreen].bounds.size.height

@interface BasicAnimationViewController ()<UIGestureRecognizerDelegate>
@property (strong,nonatomic) NSMutableArray *layers;

@end

@implementation BasicAnimationViewController
#pragma mark - 属性方法
- (NSMutableArray *)layers
{
    if (_layers == nil) {
        _layers = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _layers;
}
#pragma mark - 控制器周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatBasicAnimationWithCount:5];
}
#pragma mark - 触摸点击事件
- (void)selfViewTaped:(UITapGestureRecognizer *)sender {
    [self basicAnimation:self.layers[sender.numberOfTapsRequired - 1]];
}
#pragma mark - 自定义方法
- (void)creatBasicAnimationWithCount:(int)count
{
    [self creatLayersWithCount:count];
    [ConFunc addContinuousTapGesturetInView:self.view andTarget:self andTapGesture:[self creatTapGesturesWithCount:count]];
}
- (NSArray *)creatTapGesturesWithCount:(int)count
{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
    for (int index = 0; index < count; index++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfViewTaped:)];
        [arr addObject:tap];
    }
    
    return arr;
}
- (void)creatLayersWithCount:(int)count
{
    /*
     使用floor函数。floor(x)返回的是小于或等于x的最大整数。如：
     floor(2.5) = 2
     floor(-2.5) = -3
     4、使用ceil函数。ceil(x)返回的是大于x的最小整数。如：
     ceil(2.5) = 3
     ceil(-2.5) = -2
     */
    CGFloat W = Main_Screen_With/3;
    CGFloat H = W;
    for (int i = 0; i < ceilf((float)count/3); i++) {//确定行数
        for (int j = 0; j < 3; j++) {//确定列数
            if (i*3 + j < count) {//判断是否超出范围
                CALayer *layer = [self getOneLayerWith:CGRectMake(j*W, i*H, W, H) andColor:[ConFunc randomColorWithAlpha:1]];
                [self.view.layer addSublayer:layer];
                [self.layers addObject:layer];
            }
        }
    }
}
- (CALayer *)getOneLayerWith:(CGRect)frame andColor:(UIColor *)color
{
    CALayer *layer = [CALayer layer];
    layer.frame = frame;
    layer.backgroundColor = color.CGColor;
    
    return layer;
}
- (void)basicAnimation:(CALayer *)layer
{
    //1.创建动画对象
    CABasicAnimation *animation = [CABasicAnimation animation];
    //2.设置动画对象
    /*
        keyPath:决定执行怎样的动画，调整哪个属性来执行动画。
        fromValue:属性值丛什么值开始执行动画。
        toValue:属性值到达什么值结束动画。
        byVale:属性值增加了多少值之后结束动画。
        duration:动画持续时间。
     
        注意：以下两个属性结合起来用能让图层保持动画结束后的状态。
        removedOnCompletion:执行完动画后是否移除该动画。
        fillMode:动画保持的状态。
            fillMode的作用就是决定当前对象过了非active时间段的行为. 比如动画开始之前,动画结束之后。如果是一个动画CAAnimation,则需要将其removedOnCompletion设置为NO,要不然fillMode不起作用.
            fillMode取值：
                 1.kCAFillModeRemoved： 这个是默认值,也就是说当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer会恢复到之前的状态 。
                 2.kCAFillModeForwards： 当动画结束后,layer会一直保持着动画最后的状态
                 3.kCAFillModeBackwards： 这个和kCAFillModeForwards是相对的,就是在动画开始前,你只要将动画加入了一个layer,layer便立即进入动画的初始状态并等待动画开始.你可以这样设定测试代码,将一个动画加入一个layer的时候延迟5秒执行.然后就会发现在动画没有开始的时候,只要动画被加入了layer,layer便处于动画初始状态
                 4.kCAFillModeBoth： 理解了上面两个,这个就很好理解了,这个其实就是上面两个的合成.动画加入后开始之前,layer便处于动画初始状态,动画结束后layer保持动画最后的状态.
     */
    CGFloat tabbar_height = 49;
    switch ([self.layers indexOfObject:layer]) {
        case 0:
            animation.keyPath = @"position";
            animation.fromValue = [NSValue valueWithCGPoint:self.view.center];
            animation.toValue = [NSValue valueWithCGPoint:CGPointMake(Main_Screen_With/3/2, Main_Screen_Height - Main_Screen_With/3/2 - tabbar_height)];
            break;
        case 1:
            animation.keyPath = @"transform.translation.y";
            animation.fromValue = [NSNumber numberWithFloat:0];
            animation.toValue = [NSNumber numberWithFloat:Main_Screen_Height - Main_Screen_With/3 - tabbar_height];
            break;
        case 2:
            animation.keyPath = @"transform.translation";
            animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
            animation.toValue = [NSValue valueWithCGPoint:CGPointMake(0, Main_Screen_Height - Main_Screen_With/3 - tabbar_height)];            break;
        case 3:
            animation.keyPath = @"bounds";
            animation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, Main_Screen_With/3, Main_Screen_With/3)];
            animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, Main_Screen_With/3, -Main_Screen_With/3/5)];
            break;
        case 4:
            animation.keyPath = @"transform";
            animation.byValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 1, 1, 0)];
            break;
            
        default:
            break;
    }
    animation.duration = 2;
    animation.delegate = self;
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    //3.添加动画
    [layer addAnimation:animation forKey:nil];
}
#pragma mark - <UIGestureRecognizerDelegate>代理方法
/**
 *  是否允许多个手势识别器同时有效
 *  Simultaneously : 同时地
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
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
