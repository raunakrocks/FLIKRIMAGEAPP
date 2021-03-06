//
//  ImageServiceImpl.h
//  FlikrImageApp
//
//  Created by Raunak Talwar on 23/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ImageService.h"

@interface ImageServiceImpl : NSObject<ImageService>
- (instancetype)initWithImageAPI:(id<ImageAPI> )imageAPI imageStorageService:(id<ImageStorageService> )storageService;
- (void)getImageModelsWithText:(NSString *)text
                    pageNumber: (NSInteger)pageNumber
             completionHandler:(void (^)(NSArray<ImageModel *> *imageModels, NSError *error))completionHandler;
- (void)getImageForImageModel:(ImageModel *)imageModel
            completionHandler:(void (^)(UIImage *image, NSError *error))completionHandler;
@end

