//
//  ImageService.h
//  FlikrImageApp
//
//  Created by Raunak Talwar on 21/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageModel.h"
#import "ImageService.h"


@interface ImageServiceImpl : NSObject<ImageService>
- (void)searchImagesWithText:(NSString *)text
                  pageNumber: (NSInteger)pageNumber
         completionHandler:(void (^)(NSArray<ImageModel *> *data, NSError *error))completionHandler;
@end


