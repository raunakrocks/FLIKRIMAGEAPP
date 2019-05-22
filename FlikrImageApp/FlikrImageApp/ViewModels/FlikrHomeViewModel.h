//
//  FlikrHomeViewModel.h
//  FlikrImageApp
//
//  Created by Raunak Talwar on 21/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageModel.h"
#import "ImageService.h"

@interface FlikrHomeViewModel : NSObject
@property(nonatomic, strong, readonly) NSArray<ImageModel *> *imageModels;

- (instancetype)initWithImageService: (id<ImageService>)service;
- (void)searchImagesWithText:(NSString *)text
                  pageNumber: (NSInteger)pageNumber
             completionHandler:(void (^)(void))completionHandler;
@end

