//
//  ConFunc.m
//  CoreAnimation
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 QSP. All rights reserved.
//

#import "ConFunc.h"

@implementation ConFunc

+ (void)addContinuousTapGesturetInView:(UIView *)view andTarget:(id)target andTapGesture:(NSArray *)tapGestures
{
    for (UITapGestureRecognizer *tap in tapGestures) {
        NSInteger index = [tapGestures indexOfObject:tap];
        tap.numberOfTapsRequired = index + 1;
        if (index > 0) {
            //上一次点击事件触发失败，才触发本次点击事件。
            [(UITapGestureRecognizer *)tapGestures[index - 1] requireGestureRecognizerToFail:tap];
        }
        
        tap.delegate = target;
        [view addGestureRecognizer:tap];
    }
}
+ (UIColor *)randomColorWithAlpha:(float)alpha
{
    CGFloat r = (float)(arc4random()%256)/256;
    CGFloat g = (float)(arc4random()%256)/256;
    CGFloat b = (float)(arc4random()%256)/256;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

@end