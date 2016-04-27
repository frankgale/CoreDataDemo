//
//  ViewController.m
//  CoreDataDemo
//
//  Created by Ken Feng on 16/4/23.
//  Copyright © 2016年 vdaoyun. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Entity.h"
#import "CoreDataUtil.h"
#import "FGBase.h"
#import "WHttpUtil.h"
#import "Game.h"
#import "JsonUtil.h"
#import "UIImage+Util.h"
#import "CATransition+Util.h"

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) UIImagePickerController *pickerController;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (UIImagePickerController *)pickerController{
    if (!_pickerController) {
        _pickerController = [[UIImagePickerController alloc] init];
        _pickerController.delegate = self;
    }
    return _pickerController;
}
- (IBAction)pickerFromPhoto:(id)sender {
    self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.pickerController animated:YES completion:^{
        
    }];
}
- (IBAction)pickerFromCamera:(id)sender {
//    [self.imageView.layer addAnimation:[CATransition easeInAnimationWithTime:2] forKey:@"Reval"];
    CGRect rect = CGRectMake(100, 100, 10, 10);
    [CATransition flipFromRightWithView:self.imageView andTime:2 andObjc:self andStopSel:@selector(hide) andStopFrame:&rect];

    
//    self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//    [self presentViewController:self.pickerController animated:YES completion:^{
//        
//    }];
}

- (void)hide{
      NSLog(@"finish");
    if ([self.imageView isHidden]) {
      
        [self.imageView setHidden:false];
    } else {
        [self.imageView setHidden:true];
    }
    
}

- (IBAction)pickerFromAlbum:(id)sender {
    self.pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:self.pickerController animated:YES completion:^{
        
    }];
}


#pragma delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image =[info valueForKey:@"UIImagePickerControllerOriginalImage"];
    UIColor *color = [UIColor greenColor];
//    UIImage *newImage = [UIImage FilterImage:image andColor:color andIntensity:0.7];
//    UIImage *newImage = [UIImage FilterImage:image andAngle:0.8];
    UIImage *newImage = [UIImage FilterImage:image];
    CGRect frame = self.imageView.frame;
    CGRect rect = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width/2, frame.size.height/2);
//    [self.view addSubview:[UIImage BlurEffect:10 andRect:rect]];
   UIImage *qrcodeImage = [UIImage QRCodeImageWith:@"dazuidemeihaochuntian"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:qrcodeImage];
    imageView.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:imageView];
    self.imageView.image = newImage;
//    NSURL *url1 = [info valueForKey:@"UIImagePickerControllerReferenceURL"];
//    WHttpUtil *util = [WHttpUtil new];
//    __weak typeof (self)weakSelf = self;
//    url1 = [NSURL URLWithString:@"http://banbao.chazidian.com/uploadfile/2016-01-25/s145368924044608.jpg"];
//    [util downloadWithData:url1 success:^(NSURL *url) {
//        NSLog(@"url:%@", url);
//       NSData *data = [NSData dataWithContentsOfURL:url];
//        __block UIImage *image = [UIImage imageWithData:data];
//        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            weakSelf.imageView.image = [UIImage grayImage:image];
//        });
//        NSLog(@"image:%@", image);
//    } faile:^(NSError *error) {
//        NSLog(@"error:%@", error);
//    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //所有滤镜名称
//    [self.view.layer addAnimation:[CATransition easeOutAnimationWithTime:10] forKey:@"Reval"];
//    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(animation:) userInfo:self repeats:true];
}

- (void)animation:(NSTimer *)timer{

    
    [timer invalidate];
}

- (void)http{
    NSArray *keys = @[@"page", @"pageSize"];
    NSArray *values = @[@"1", @"1"];
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    
    [WHttpUtil get:@"http://192.168.0.112/game/getList" params:dict  success:^(id responseObj) {
        NSString *cName = NSStringFromClass([Game class]);
        NSArray *array = [JsonUtil DataToModel:cName andData:responseObj];
        for (Game *g in array) {
            NSLog(@"%@", g.name);
        }
    } failure:^(NSError *error) {
        NSLog(@"error:%@", error);
    }];
    [WHttpUtil post:@"http://192.168.0.112/game/getList" params:dict  success:^(id responseObj) {
        NSString *cName = NSStringFromClass([Game class]);
        NSArray *array = [JsonUtil DataToModel:cName andData:responseObj];
        for (Game *g in array) {
            NSLog(@"%@", g.name);
        }
    } failure:^(NSError *error) {
        NSLog(@"error:%@", error);
    }];
    //    [WHttpUtil post:@"http://192.168.0.112/game/getList" params:dict success:^(id responseObj) {
    //
    //
    //        NSString *cName = NSStringFromClass([Game class]);
    //        NSArray *dict = [[JsonUtil DataToDict:responseObj] valueForKey:@"data"];
    //        for (NSDictionary *str in dict) {
    //            Game *game = [JsonUtil DictToModel:cName andDict:str];
    //            NSError *error;
    //            NSData *data = [NSJSONSerialization dataWithJSONObject:str options:NSJSONWritingPrettyPrinted error:&error];
    //            NSLog(@"data:%@", data);
    //            NSLog(@"%@", game.name);
    //        }
    //
    //
    //
    //        NSArray *array = [JsonUtil DataToModel:cName andData:responseObj];
    //        for (Game *g in array) {
    //            NSLog(@"%@", g.name);
    //        }
    //    } failure:^(NSError *error) {
    //        NSLog(@"faile:%@", error.userInfo);
    //    }];
    
    
    //
    //    NSArray *array = [CoreDataUtil selectEntitiesFromCoreDataWithEntityName:@"Entity" andBegin:0 andLength:10];
    //    for (Entity *e in array) {
    //        NSLog(@"password:%@", e.passWord);
    //        NSLog(@"username:%@", e.userName);
    //    }
    //
    //    [CoreDataUtil deleteEntityWithEntityName:@"Entity" andBegin:0 andLength:1];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
