//
//  ImageStorageServiceImpl.m
//  FlikrImageApp
//
//  Created by Raunak Talwar on 23/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import "ImageStorageServiceImpl.h"
#import "ImageStorageHelper.h"

@implementation ImageStorageServiceImpl
- (UIImage *)getImageForImageModel:(ImageModel *)imageModel {
    NSString *imageName = [self getImageNameForImageModel:imageModel];
    return [ImageStorageHelper loadImage:imageName];
}

- (void)saveImage:(UIImage *)image forImageModel:(ImageModel *)imageModel {
    NSString *imageName = [self getImageNameForImageModel:imageModel];
    [ImageStorageHelper saveImage:image withName:imageName];
}

#pragma private methods

- (NSString *)getImageNameForImageModel:(ImageModel *)imageModel {
    return [NSString stringWithFormat:@"%@_%@_%@_%@", imageModel.farm, imageModel.server, imageModel.imageID, imageModel.secret];
}

@end
