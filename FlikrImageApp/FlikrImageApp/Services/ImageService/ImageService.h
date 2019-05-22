//
//  ImageService.h
//  FlikrImageApp
//
//  Created by Raunak Talwar on 21/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//
#import "ImageModel.h"

#ifndef ImageService_h
#define ImageService_h
 @protocol ImageService <NSObject>
- (void)searchImagesWithText:(NSString *)text
                  pageNumber: (NSInteger)pageNumber
          completionHandler:(void (^)(NSArray<ImageModel *> *data, NSError *error))completionHandler;
@end

#endif /* ImageService_h */
