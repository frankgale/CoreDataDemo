//
//  CATransition+Util.h
//  CoreDataDemo
//
//  Created by Ken Feng on 16/4/27.
//  Copyright © 2016年 vdaoyun. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CATransition (Util)

+ (CATransition *)easeOutAnimationWithTime:(CGFloat)seconds;

+ (CATransition *)pushAnimationWithTime:(CGFloat)seconds;

/**
 *  翻转动画
 *
 *  @param view    动画视图
 *  @param seconds 动画时长
 */
+ (void)flipFromRightWithView:(UIView *)view andTime:(CGFloat)seconds  andObjc:(id)objc andStopSel:(SEL)sel andStopFrame:(CGRect *)rect;

/**
 *  卷曲动画
 *
 *  @param view    动画视图
 *  @param seconds 动画时长
 */
+ (void)curlUpAnimationWithView:(UIView *)view andTime:(CGFloat)seconds andObjc:(id)objc andStopSel:(SEL)sel andStopFrame:(CGRect *)rect;
@end
