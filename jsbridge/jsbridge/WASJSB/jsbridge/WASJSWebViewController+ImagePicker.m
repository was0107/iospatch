//
//  WASJSWebViewController+ImagePicker.m
//  JSBridge
//
//  Created by boguang on 15/3/20.
//  Copyright (c) 2015年 b5m. All rights reserved.
//

#import "WASJSWebViewController+ImagePicker.h"


typedef void (^ImagePickerBlock)(UIImage *image);

@class WASJSImagePickerViewController;
static WASJSImagePickerViewController *_instancePickerViewController;

#pragma
#pragma WASJSImagePickerViewController

@interface WASJSImagePickerViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *pickerController;
@property (nonatomic, copy) ImagePickerBlock block;
@end


@implementation WASJSImagePickerViewController

- (id) init {
    self = [super init];
    if (self) {
        self.pickerController = [[UIImagePickerController alloc] init];
        self.pickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
        self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.pickerController.delegate = self;
    }
    return self;
}

- (void) captureWithViewController:(UIViewController *) controller withBlock:(ImagePickerBlock) block {
    self.block = block;
    [controller presentViewController:self.pickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    self.block(image);
    [self dismiss];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismiss];
}


- (void) dismiss {
    [self.pickerController dismissViewControllerAnimated:YES completion:nil];
    _instancePickerViewController = nil;
}

@end

#pragma
#pragma WASJSWebViewController

@implementation WASJSWebViewController (ImagePicker)
- (void) jsapi_imagePicker:(NSDictionary *)parames {
    if (!_instancePickerViewController) {
        _instancePickerViewController = [WASJSImagePickerViewController new];
    }
    
    __weak typeof(self) weakSelf = self;
    [_instancePickerViewController captureWithViewController:self withBlock:^(UIImage *image) {
        float quality = parames[@"quality"] ? [parames[@"quality"] floatValue] : 0.8f;
        NSData *imageData = UIImageJPEGRepresentation(image, quality);
        NSString *base64String = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [weakSelf jsCallbackForId:parames[@"callbackId"] withRetValue:@{@"image":base64String}];
    }];

}

@end
