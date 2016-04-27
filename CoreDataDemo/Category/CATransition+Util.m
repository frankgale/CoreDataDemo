//
//  CATransition+Util.m
//  CoreDataDemo
//
//  Created by Ken Feng on 16/4/27.
//  Copyright © 2016年 vdaoyun. All rights reserved.
//

#import "CATransition+Util.h"

@implementation CATransition (Util)

+ (CATransition *)easeOutAnimationWithTime:(CGFloat)seconds{
    CATransition *animation = [[CATransition alloc] init];
    animation.duration = seconds;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = kCATransitionReveal;//设置动画类型为渐变动画
    return animation;
}

+ (CATransition *)pushAnimationWithTime:(CGFloat)seconds{
    CATransition *animation = [[CATransition alloc] init];
    animation.duration = seconds;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = kCATransitionPush;//设置动画类型为渐变动画
    return animation;
}

+ (void)flipFromRightWithView:(UIView *)view andTime:(CGFloat)seconds andObjc:(id)objc andStopSel:(SEL)sel andStopFrame:(CGRect *)rect{
    [self baseAnimationWithView:view andTime:seconds andAnimationCurve:UIViewAnimationCurveEaseInOut andTransition:UIViewAnimationTransitionFlipFromRight andIsCurrentState:true andIsCache:true andObjc:objc andSel:sel andStopFrame:rect];
}

+ (void)curlUpAnimationWithView:(UIView *)view andTime:(CGFloat)seconds andObjc:(id)objc andStopSel:(SEL)sel andStopFrame:(CGRect *)rect{
    [self baseAnimationWithView:view andTime:seconds andAnimationCurve:UIViewAnimationCurveEaseInOut andTransition:UIViewAnimationTransitionCurlUp andIsCurrentState:true andIsCache:true andObjc:objc andSel:sel andStopFrame:rect];
}

/**
 *  基础动画块
 *
 *  @param view       动画视图
 *  @param seconds    动画时长
 *  @param curve      动画播放速度
 *  @param transition 动画类型
 *  @param isStates   是否从当前状态开始播放
 *  @param isCache    是否缓存
 *  @param objc       协议对象
 *  @param sel        动画结束后触发方法
 *  @param rect       动画结束时rect
 */
+ (void)baseAnimationWithView:(UIView *)view andTime:(CGFloat)seconds andAnimationCurve:(UIViewAnimationCurve)curve andTransition:(UIViewAnimationTransition)transition andIsCurrentState:(BOOL)isStates andIsCache:(BOOL)isCache andObjc:(id)objc andSel:(SEL)sel andStopFrame:(CGRect *)rect{
    //发出开始时图动画的请求，视图动画的开始
    [UIView beginAnimations:nil context:nil];
    //设置动画的播放速度
    [UIView setAnimationCurve:curve];
    //设置动画的时长
    [UIView setAnimationDuration:seconds];
    [UIView setAnimationBeginsFromCurrentState:isStates];
    if (objc) {
        [UIView setAnimationDelegate:objc];
    }
    if (sel) {
         [UIView setAnimationDidStopSelector:sel];
    }

    if (rect) {
        view.frame = *(rect);
    }
    [UIView setAnimationTransition:transition forView:view cache:isCache];
    [UIView commitAnimations];
}

@end
