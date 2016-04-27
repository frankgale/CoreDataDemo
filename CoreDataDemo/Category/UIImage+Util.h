//
//  UIImage+Util.h
//  CoreDataDemo
//
//  Created by Ken Feng on 16/4/26.
//  Copyright © 2016年 vdaoyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Util)

@property (nonatomic, strong) UIImagePickerController *pickerController;


/**
 *  按照一定比例缩放图片
 *
 *  @param image 需要处理的图片
 *  @param size  需要缩放的尺寸
 *
 *  @return 缩放完成的图片
 */
+ (UIImage *)scaleImage:(UIImage *)image andNewSize:(CGSize)size;

/**
 *  将图片转为灰色图片
 *
 *  @param image 需要转换的图片
 *
 *  @return 灰色图片
 */
+ (UIImage *)grayImage:(UIImage *)image;

/**
 *  设置图片的单色效果
 *
 *  @param image 需要添加效果图片
 *
 *  @return 处理完成图片
 */
+ (UIImage *)FilterImage:(UIImage *)image andColor:(UIColor *)color andIntensity:(CGFloat)intensity;

/**
 *  更改图片色相
 *
 *  @param image 需要添加效果图片
 *  @param angle 色相角度
 *
 *  @return 处理完成图片
 */
+ (UIImage *)FilterImage:(UIImage *)image andAngle:(CGFloat)angle;

/**
 *  添加马赛克
 *
 *  @param image 需要添加效果图片
 *
 *  @return 马赛克图片
 */
+ (UIImage *)FilterImage:(UIImage *)image;

/**
 *  返回模糊视图
 *
 *  @param cornerRadius 圆角
 *  @param rect         尺寸
 *
 *  @return 模糊仕途
 */
+ (UIVisualEffectView *)BlurEffect:(CGFloat)cornerRadius andRect:(CGRect)rect;

/**
 *  二维码图片
 *
 *  @param message 参数
 *
 *  @return 二维码
 */
+ (UIImage *)QRCodeImageWith:(NSString *)message;


@end
