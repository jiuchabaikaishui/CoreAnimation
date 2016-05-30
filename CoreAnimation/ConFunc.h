//
//  ConFunc.h
//  CoreAnimation
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface ConFunc : NSObject

+ (void)addContinuousTapGesturetInView:(UIView *)view andTarget:(id)target andTapGesture:(NSArray *)tapGestures;
+ (UIColor *)randomColorWithAlpha:(float)alpha;

@end
