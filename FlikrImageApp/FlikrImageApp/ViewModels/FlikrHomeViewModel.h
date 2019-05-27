//
//  FlikrHomeViewModel.h
//  FlikrImageApp
//
//  Created by Raunak Talwar on 21/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ImageAPIImpl.h"
#import "ImageModel.h"
#import "ImageService.h"

@interface FlikrHomeViewModel : NSObject
@property(nonatomic, strong, readonly) NSMutableArray<ImageModel *> *imageModels;

- (instancetype)initWithImageService: (id<ImageService>)service;
- (void)searchImageModelsWithText: (NSString *)text
                       pageNumber: (NSInteger)pageNumber
                completionHandler:(void (^)(NSError *error))completionHandler;
- (void)getImageForImageModel:(ImageModel *)imageModel
            completionHandler:(void (^)(UIImage *image, NSError *error))completionHandler;
@end

