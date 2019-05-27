//
//  ImageServiceImpl.m
//  FlikrImageApp
//
//  Created by Raunak Talwar on 23/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import "ImageServiceImpl.h"

@interface ImageServiceImpl()
@property (nonatomic, strong) id<ImageAPI> imageAPI;
@property (nonatomic, strong) id<ImageStorageService> storageService;
@end

@implementation ImageServiceImpl

- (instancetype)initWithImageAPI:(id<ImageAPI> )imageAPI imageStorageService:(id<ImageStorageService> )storageService {
    self = [super init];
    if(self) {
        self.imageAPI = imageAPI;
        self.storageService = storageService;
    }
    return self;
}

- (void)getImageModelsWithText:(NSString *)text
                    pageNumber: (NSInteger)pageNumber
             completionHandler:(void (^)(NSArray<ImageModel *> *data, NSError *error))completionHandler {
    [self.imageAPI getImageModelsWithText:text pageNumber:pageNumber completionHandler:^(NSArray<ImageModel *> *imageModels, NSError *error) {
        completionHandler(imageModels, error);
    }];
}

- (void)getImageForImageModel:(ImageModel *)imageModel
                completionHandler:(void (^)(UIImage *image, NSError *error))completionHandler {
    UIImage *image = [self.storageService getImageForImageModel:imageModel];
    if(image != NULL) {
        completionHandler(image, NULL);
    } else {
        [self.imageAPI getImageForImageModel:imageModel completionHandler:^(UIImage *image, NSError *error) {
            if(error == NULL) {
                [self.storageService saveImage:image forImageModel:imageModel];
            }
            completionHandler(image, error);
        }];
    }
}
@end
