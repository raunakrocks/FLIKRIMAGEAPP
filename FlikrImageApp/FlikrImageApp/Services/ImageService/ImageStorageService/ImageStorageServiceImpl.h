//
//  ImageStorageServiceImpl.h
//  FlikrImageApp
//
//  Created by Raunak Talwar on 23/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ImageStorageService.h"

@interface ImageStorageServiceImpl : NSObject
- (UIImage *)getImageForImageModel:(ImageModel *)imageModel;
- (void)saveImage:(UIImage *)image forImageModel:(ImageModel *)imageModel;
@end

