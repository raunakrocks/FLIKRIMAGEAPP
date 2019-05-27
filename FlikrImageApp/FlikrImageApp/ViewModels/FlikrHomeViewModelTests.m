//
//  FlikrHomeViewModelTests.m
//  FlikrImageAppTests
//
//  Created by Raunak Talwar on 23/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FlikrHomeViewModel.h"
#import "ImageModel.h"
#import "ImageService.h"

@interface FlikrHomeViewModelTests : XCTestCase
@end

@interface MockServiceImpl : NSObject<ImageService>
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, strong) ImageModel *imageModel;
- (void)getImageModelsWithText:(NSString *)text
                    pageNumber: (NSInteger)pageNumber
             completionHandler:(void (^)(NSArray<ImageModel *> *imageModels, NSError *error))completionHandler;
- (void)getImageForImageModel:(ImageModel *)imageModel
            completionHandler:(void (^)(UIImage *image, NSError *error))completionHandler;
@end

@implementation FlikrHomeViewModelTests

- (void)testgetImageModelsWithTextAndPageNumber {
    MockServiceImpl *service = [[MockServiceImpl alloc] init];
    FlikrHomeViewModel *viewModel = [[FlikrHomeViewModel alloc] initWithImageService:service];
    __block NSError *actualError;
    [viewModel searchImageModelsWithText:@"hello" pageNumber:5 completionHandler:^(NSError *error) {
        actualError = error;
    }];
    XCTAssertEqual(service.text, @"hello");
    XCTAssertEqual(service.pageNumber, 5);
    XCTAssertNil(actualError);
}

- (void)testGetImageForImageModel {
    MockServiceImpl *service = [[MockServiceImpl alloc] init];
    FlikrHomeViewModel *viewModel = [[FlikrHomeViewModel alloc] initWithImageService:service];
    ImageModel *imageModel = [[ImageModel alloc] initWithFarm:@"farm"
                                                       server:@"server"
                                                      imageID:@"imageID"
                                                       secret:@"secret"];
    __block UIImage *actualImage;
    __block NSError *actualError;
    [viewModel getImageForImageModel:imageModel completionHandler:^(UIImage *image, NSError *error) {
        actualImage = image;
        actualError = error;
    }];
    XCTAssertEqual(service.imageModel.imageID, @"imageID");
    XCTAssertNotNil(actualImage);
    XCTAssertNil(actualError);
}

@end

@implementation MockServiceImpl

- (void)getImageModelsWithText:(NSString *)text
                    pageNumber: (NSInteger)pageNumber
             completionHandler:(void (^)(NSArray<ImageModel *> *imageModels, NSError *error))completionHandler {
    self.text = text;
    self.pageNumber = pageNumber;
    ImageModel *imageModel = [[ImageModel alloc] initWithFarm:@"farm"
                                                       server:@"server"
                                                      imageID:@"imageID"
                                                       secret:@"secret"];
    completionHandler([NSArray arrayWithObject:imageModel], NULL);
}

- (void)getImageForImageModel:(ImageModel *)imageModel
            completionHandler:(void (^)(UIImage *image, NSError *error))completionHandler {
    self.imageModel = imageModel;
    UIImage *image = [[UIImage alloc] init];
    completionHandler(image, NULL);
}
@end
