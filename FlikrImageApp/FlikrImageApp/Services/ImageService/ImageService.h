//
//  ImageService.h
//  FlikrImageApp
//
//  Created by Raunak Talwar on 23/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//
#import "ImageModel.h"
#import "ImageAPI.h"
#import "ImageStorageService.h"

#ifndef ImageService_h
#define ImageService_h
/*
 Created a protocol ImageService that will be exposed in the FlickrHomeViewModel,
 which will help in mocking it with fake implementation for testing.
 */
@protocol ImageService <NSObject>
/*
 API to get the images models given image search text as input. Result will be returned in the completionHandler.
 */
- (void)getImageModelsWithText:(NSString *)text
                    pageNumber: (NSInteger)pageNumber
             completionHandler:(void (^)(NSArray<ImageModel *> *imageModels, NSError *error))completionHandler;

/*
 API to get the images given image URL text string as input. Result will be returned in the completionHandler.
 */
- (void)getImageForImageModel:(ImageModel *)imageModel
               completionHandler:(void (^)(UIImage *image, NSError *error))completionHandler;
@end
#endif /* ImageService_h */
