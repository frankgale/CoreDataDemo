//
//  FGBase.m
//  CoreDataDemo
//
//  Created by Ken Feng on 16/4/26.
//  Copyright © 2016年 vdaoyun. All rights reserved.
//

#import "FGBase.h"

@implementation FGBase

- (UIImagePickerController *)pickerController{
    if (!_pickerController) {
        _pickerController = [[UIImagePickerController alloc] init];
        _pickerController.delegate = self;
        _pickerController.allowsEditing = true;
    }
    return _pickerController;
}

- (UIImage *)pickerImage{
    self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    return NULL;
}

+ (BOOL)isFirstLaunches{
    NSString *firstLaunches = @"firstLaunches";
    NSString *yes = @"YES";
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([[userDefault valueForKey:firstLaunches] isEqualToString:yes]) {
        [userDefault setValue:yes forKey:firstLaunches];
        [userDefault synchronize];
        return true;
    }
    return false;
}

@end
