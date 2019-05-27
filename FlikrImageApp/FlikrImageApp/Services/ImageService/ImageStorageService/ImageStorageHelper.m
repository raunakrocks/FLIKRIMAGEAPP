//
//  ImageStorageHelper.m
//  FlikrImageApp
//
//  Created by Raunak Talwar on 23/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import "ImageStorageHelper.h"

@implementation ImageStorageHelper
+ (void)saveImage:(UIImage *)image withName:(NSString *)name {
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *tmpDirectory = NSTemporaryDirectory();
    NSString *fullPath = [tmpDirectory stringByAppendingPathComponent:name];
    [fileManager createFileAtPath:fullPath contents:data attributes:nil];
}

+ (UIImage *)loadImage:(NSString *)name {
    NSString *tmpDirectory = NSTemporaryDirectory();
    NSString *fullPath = [tmpDirectory stringByAppendingPathComponent:name];
    UIImage *img = [UIImage imageWithContentsOfFile:fullPath];
    return img;
}
@end
