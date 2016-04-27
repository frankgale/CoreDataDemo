//
//  UIImage+Util.m
//  CoreDataDemo
//
//  Created by Ken Feng on 16/4/26.
//  Copyright © 2016年 vdaoyun. All rights reserved.
//

#import "UIImage+Util.h"
#import <objc/runtime.h>


@implementation UIImage (Util)

static char *cName;

/**
 *  分类添加属性
 *
 *  @param pickerController
 */
- (void)setPickerController:(UIImagePickerController *)pickerController{
    objc_setAssociatedObject(self, cName, pickerController, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIImagePickerController *)pickerController{
    if (!self.pickerController) {
        self.pickerController = [[UIImagePickerController alloc] init];
    }
   return objc_getAssociatedObject(self, cName);
}



+ (UIImage *)scaleImage:(UIImage *)image andNewSize:(CGSize)size{
    //获取需要缩放图片尺寸
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    //计算缩放比例
    CGFloat widthFactor = size.width / width;
    CGFloat heightFactor = size.height / height;
    CGFloat scaleFactor = widthFactor < height ? widthFactor : heightFactor;
    //根据缩放比例计算新的图片尺寸
    CGFloat scaleWidth = width *scaleFactor;
    CGFloat scaleHeight = height *scaleFactor;
    CGSize scaleSize = CGSizeMake(scaleWidth, scaleHeight);
    //绘制图形上下文环境
    UIGraphicsBeginImageContext(scaleSize);
    [image drawInRect:CGRectMake(0, 0, scaleWidth, scaleHeight)];
    //根据上下文环境获取新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    return newImage;
}

+ (UIImage *)grayImage:(UIImage *)image{
    //获取需要缩放图片尺寸
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGColorSpaceRef spaceRef = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, width, height, 8, 0, spaceRef, 0);
    CGRect rect = CGRectMake(0, 0, width, height);
    CGContextDrawImage(context, rect, image.CGImage);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    return newImage;
}

+ (UIImage *)FilterImage:(UIImage *)image andColor:(UIColor *)color andIntensity:(CGFloat)intensity{
    CIImage *newImage = [[CIImage alloc] initWithImage:image];
    CIColor *cColor = [[CIColor alloc] initWithColor:color];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorMonochrome"];
    NSNumber *number = [NSNumber numberWithFloat:intensity];
    [filter setValue:cColor forKey:kCIInputColorKey];//设置颜色值
    [filter setValue:number forKey:kCIInputIntensityKey];//设置颜色浓度值
    [filter setValue:newImage forKey:kCIInputImageKey];
    CIImage *cImage = [filter outputImage];
    return [UIImage imageWithCIImage:cImage];
}

+ (UIImage *)FilterImage:(UIImage *)image andAngle:(CGFloat)angle{
    CIImage *newImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIHueAdjust"];
    NSNumber *number = [NSNumber numberWithFloat:angle];
    [filter setValue:number forKey:kCIInputAngleKey];
    [filter setValue:newImage forKey:kCIInputImageKey];
    CIImage *cImage = [filter outputImage];
    return [UIImage imageWithCIImage:cImage];
}

+ (UIImage *)FilterImage:(UIImage *)image{
    CIImage *newImage = [[CIImage alloc] initWithImage:image];
    CIFilter *filter = [CIFilter filterWithName:@"CIPixellate"];
    [filter setValue:newImage forKey:kCIInputImageKey];
    [filter setDefaults];
    CIImage *cImage = [filter outputImage];
    return [UIImage imageWithCIImage:cImage];
}

+ (UIVisualEffectView *)BlurEffect:(CGFloat)cornerRadius andRect:(CGRect)rect{
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.frame = rect;
    effectView.layer.cornerRadius = cornerRadius;
    effectView.layer.masksToBounds = true;
    return effectView;
}

+ (UIImage *)QRCodeImageWith:(NSString *)message{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *image = [filter outputImage];
    return [UIImage imageWithCIImage:image];
}
@end
