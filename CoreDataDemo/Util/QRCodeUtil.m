//
//  QRCodeUtil.m
//  CoreDataDemo
//
//  Created by Ken Feng on 16/4/27.
//  Copyright © 2016年 vdaoyun. All rights reserved.
//

#import "QRCodeUtil.h"
#import <AVFoundation/AVFoundation.h>

@interface QRCodeUtil() <AVCaptureMetadataOutputObjectsDelegate>
/**显示图层*/
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *layer;
/**捕捉会话*/
@property (nonatomic, strong) AVCaptureSession *session;
@end

@implementation QRCodeUtil

- (void)scanQRCode{
    // 二维码的扫描
    // 1、创建捕捉会话
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    self.session = session;
    // 2.添加输入设备(数据从摄像头输入)
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    [session addInput:input];
    // 3、添加输出数据(示例对象-->类对象-->元类对象-->根元类对象)
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [session addOutput:output];
    // 3.1.设置输入元数据的类型(类型是二维码数据)
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    // 4、添加扫描图层
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
//    layer.frame = self.view.bounds;
//    [self.view.layer addSublayer:layer];
    self.layer = layer;
    // 5、开始扫描
    [session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    // 数组metadataObjects中存放结果数据
    if (metadataObjects.count > 0) {
        // 获取最终的读取结果
        AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
        NSLog(@"%@",object.stringValue);
        [self.session stopRunning];
        [self.layer removeFromSuperlayer];
    }
    else
    {
        NSLog(@"没有扫描到数据");
    }
}

@end
