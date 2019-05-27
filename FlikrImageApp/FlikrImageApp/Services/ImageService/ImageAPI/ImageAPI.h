//
//  ImageAPI.h
//  FlikrImageApp
//
//  Created by Raunak Talwar on 23/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ImageModel.h"

#ifndef ImageAPI_h
#define ImageAPI_h

@protocol ImageAPI <NSObject>

- (void)getImageModelsWithText:(NSString *)text
                    pageNumber: (NSInteger)pageNumber
             completionHandler:(void (^)(NSArray<ImageModel *> *data, NSError *error))completionHandler;

- (void)getImageForImageModel:(ImageModel *)imageModel
                 completionHandler:(void (^)(UIImage *image, NSError *error))completionHandler;
@end

#endif /* ImageAPI_h */
