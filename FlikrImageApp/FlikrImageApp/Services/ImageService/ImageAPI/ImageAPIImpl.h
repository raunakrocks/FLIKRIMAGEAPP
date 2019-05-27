//
//  ImageAPIImpl.h
//  FlikrImageApp
//
//  Created by Raunak Talwar on 23/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageAPI.h"

@interface ImageAPIImpl : NSObject
- (void)getImageModelsWithText:(NSString *)text
                    pageNumber: (NSInteger)pageNumber
             completionHandler:(void (^)(NSArray<ImageModel *> *data, NSError *error))completionHandler;

- (void)getImageForImageModel:(ImageModel *)imageModel
            completionHandler:(void (^)(UIImage *image, NSError *error))completionHandler;
@end

