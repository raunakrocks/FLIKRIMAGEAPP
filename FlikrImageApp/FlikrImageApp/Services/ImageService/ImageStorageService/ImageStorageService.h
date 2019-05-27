//
//  IImageStorageService.h
//  FlikrImageApp
//
//  Created by Raunak Talwar on 23/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import "ImageModel.h"

#ifndef ImageStorageService_h
#define ImageStorageService_h
/*
 Created a protocol ImageStorageService that will be exposed in the ImageService,
 which will help in mocking it with fake implementation for testing.
 */
@protocol ImageStorageService <NSObject>
- (UIImage *)getImageForImageModel:(ImageModel *)imageModel;
- (void)saveImage:(UIImage *)image forImageModel:(ImageModel *)imageModel;
@end
#endif /* ImageStorageService_h */
