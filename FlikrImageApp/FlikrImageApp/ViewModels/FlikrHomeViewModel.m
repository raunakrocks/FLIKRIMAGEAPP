//
//  FlikrHomeViewModel.m
//  FlikrImageApp
//
//  Created by Raunak Talwar on 21/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import "FlikrHomeViewModel.h"
#import "ImageService.h"

@interface FlikrHomeViewModel()
@property(nonatomic, strong) id<ImageService> service;
@property(nonatomic, strong, readwrite) NSMutableArray<ImageModel *> *imageModels;
@end

@implementation FlikrHomeViewModel

/**NOTE: Injecting service as a protocol in the init so that
        this can be mocked for writing testing
 **/
- (instancetype)initWithImageService: (id<ImageService>)service {
    self = [super init];
    if(self) {
        self.service = service;
        self.imageModels = [NSMutableArray array];
    }
    return self;
}

- (void)searchImageModelsWithText: (NSString *)text
                       pageNumber: (NSInteger)pageNumber
                completionHandler:(void (^)(NSError *error))completionHandler {
    [self.service getImageModelsWithText:text
                              pageNumber:pageNumber
                       completionHandler:^(NSArray<ImageModel *> *imageModels, NSError *error) {
                           if(error == NULL) {
                               [self updateImageModels:imageModels pageNumber:pageNumber];
                               completionHandler(NULL);
                           } else {
                               completionHandler(error);
                           }
    }];
}

- (void)getImageForImageModel:(ImageModel *)imageModel
            completionHandler:(void (^)(UIImage *image, NSError *error))completionHandler {
    [self.service getImageForImageModel:imageModel completionHandler:completionHandler];
}

- (void)updateImageModels: (NSArray<ImageModel *> *) imageModels pageNumber: (NSInteger)pageNumber {
    if(pageNumber == 1) {
        self.imageModels = [imageModels mutableCopy];
    } else {
        self.imageModels = [[self.imageModels arrayByAddingObjectsFromArray:[imageModels mutableCopy]] mutableCopy];
    }
}

@end
