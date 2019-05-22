//
//  FlikrHomeViewModel.m
//  FlikrImageApp
//
//  Created by Raunak Talwar on 21/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import "FlikrHomeViewModel.h"

@interface FlikrHomeViewModel()
@property(nonatomic, strong) id<ImageService> service;
@property(nonatomic, strong, readwrite) NSMutableArray<ImageModel *> *imageModels;
@end

@implementation FlikrHomeViewModel

- (instancetype)initWithImageService: (id<ImageService>)service {
    self = [super init];
    if(self) {
        self.service = service;
        self.imageModels = [NSMutableArray array];
    }
    return self;
}

- (void)searchImagesWithText:(NSString *)text
                  pageNumber: (NSInteger)pageNumber
           completionHandler:(void (^)(void))completionHandler {
    [self.service searchImagesWithText:text
                            pageNumber: pageNumber
                     completionHandler:^(NSArray<ImageModel *> *data, NSError *error) {
                         if(error==NULL) {
                             if(pageNumber ==1)
                                 self.imageModels = [data mutableCopy];
                             else {
                                 self.imageModels = [[self.imageModels arrayByAddingObjectsFromArray:[data mutableCopy]] mutableCopy];
                             }
                         }
                         completionHandler();
                     }];
}

@end
