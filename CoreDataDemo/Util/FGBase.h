//
//  FGBase.h
//  CoreDataDemo
//
//  Created by Ken Feng on 16/4/26.
//  Copyright © 2016年 vdaoyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FGBase : NSObject<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *pickerController;

/**
 *  是否第一次启动
 *
 *  @return 是／否
 */
+ (BOOL)isFirstLaunches;

- (UIImage *)pickerImage;


@end
