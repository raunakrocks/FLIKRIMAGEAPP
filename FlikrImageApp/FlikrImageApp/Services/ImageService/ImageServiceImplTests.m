//
//  ImageServiceImplTests.m
//  FlikrImageAppTests
//
//  Created by Raunak Talwar on 27/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ImageAPI.h"
#import "ImageModel.h"
#import "ImageStorageService.h"
#import "ImageServiceImpl.h"

@interface ImageServiceImplTests : XCTestCase

@end

@interface MockImageAPI : NSObject<ImageAPI>

@property (assign) BOOL isCalled;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, strong) UIImage *image;

- (instancetype)initWithImage:(UIImage *)image;
- (void)getImageModelsWithText:(NSString *)text
                    pageNumber: (NSInteger)pageNumber
             completionHandler:(void (^)(NSArray<ImageModel *> *data, NSError *error))completionHandler;
- (void)getImageForImageModel:(ImageModel *)imageModel
            completionHandler:(void (^)(UIImage *image, NSError *error))completionHandler;
@end

@interface MockImageStorageService : NSObject<ImageStorageService>

@property (assign) BOOL isGetImageCalled;
@property (assign) BOOL isSetImageCalled;
@property (nonatomic, strong) UIImage *image;

- (instancetype)initWithImage:(UIImage *)image;
- (UIImage *)getImageForImageModel:(ImageModel *)imageModel;
- (void)saveImage:(UIImage *)image forImageModel:(ImageModel *)imageModel;
@end

@implementation ImageServiceImplTests

- (void)testGetImageModelsWithText {
    MockImageAPI *imageAPI = [[MockImageAPI alloc] init];
    MockImageStorageService *storageService = [[MockImageStorageService alloc] init];
    ImageServiceImpl *imageServiveImpl = [[ImageServiceImpl alloc] initWithImageAPI:imageAPI
                                                                imageStorageService:storageService];
    __block NSArray<ImageModel *> *actualImageModels;
    __block NSError *actualError;
    [imageServiveImpl getImageModelsWithText:@"hello" pageNumber:10 completionHandler:^(NSArray<ImageModel *> *imageModels, NSError *error) {
        actualImageModels =imageModels;
        actualError = error;
    }];
    XCTAssertEqual(actualImageModels.count, 1);
    XCTAssertNil(actualError);
    XCTAssertEqual(imageAPI.text, @"hello");
    XCTAssertEqual(imageAPI.pageNumber, 10);
}

- (void)testGetImageForImageModelWhenImageIsNotPresentInStorageCache {
    MockImageAPI *imageAPI = [[MockImageAPI alloc] initWithImage:[[UIImage alloc] init]];
    MockImageStorageService *storageService = [[MockImageStorageService alloc] init];
    ImageServiceImpl *imageServiveImpl = [[ImageServiceImpl alloc] initWithImageAPI:imageAPI
                                                                imageStorageService:storageService];
    ImageModel *imageModel = [[ImageModel alloc] init];
    __block UIImage *actualImage;
    __block NSError *actualError;
    [imageServiveImpl getImageForImageModel:imageModel completionHandler:^(UIImage *image, NSError *error) {
        actualImage = image;
        actualError = error;
    }];
    XCTAssertTrue(imageAPI.isCalled);
    XCTAssertTrue(storageService.isGetImageCalled);
    XCTAssertTrue(storageService.isSetImageCalled);
    XCTAssertNotNil(actualImage);
    XCTAssertNil(actualError);
}

- (void)testGetImageForImageModelWhenImageIsAlreadyPresentInStorageCache {
    MockImageAPI *imageAPI = [[MockImageAPI alloc] init];
    MockImageStorageService *storageService = [[MockImageStorageService alloc] initWithImage:[[UIImage alloc] init]];
    ImageServiceImpl *imageServiveImpl = [[ImageServiceImpl alloc] initWithImageAPI:imageAPI
                                                                imageStorageService:storageService];
    ImageModel *imageModel = [[ImageModel alloc] init];
    __block UIImage *actualImage;
    __block NSError *actualError;
    [imageServiveImpl getImageForImageModel:imageModel completionHandler:^(UIImage *image, NSError *error) {
        actualImage = image;
        actualError = error;
    }];
    XCTAssertFalse(imageAPI.isCalled);
    XCTAssertTrue(storageService.isGetImageCalled);
    XCTAssertFalse(storageService.isSetImageCalled);
    XCTAssertNotNil(actualImage);
    XCTAssertNil(actualError);
}

@end

#pragma Mock classes implementation

@implementation MockImageAPI

- (instancetype)initWithImage:(UIImage *)image {
    self = [super init];
    if(self) {
        self.image = image;
    }
    return self;
}

- (void)getImageModelsWithText:(NSString *)text
                    pageNumber: (NSInteger)pageNumber
             completionHandler:(void (^)(NSArray<ImageModel *> *data, NSError *error))completionHandler {
    self.text = text;
    self.pageNumber = pageNumber;
    ImageModel *model = [[ImageModel alloc] init];
    completionHandler([NSArray arrayWithObject:model], nil);
}

- (void)getImageForImageModel:(ImageModel *)imageModel
            completionHandler:(void (^)(UIImage *image, NSError *error))completionHandler {
    self.isCalled = true;
    completionHandler(self.image, NULL);
}
@end

@implementation MockImageStorageService

- (instancetype)initWithImage:(UIImage *)image {
    self = [super init];
    if(self) {
        self.image = image;
        self.isGetImageCalled = false;
        self.isSetImageCalled = false;
    }
    return self;
}

- (UIImage *)getImageForImageModel:(ImageModel *)imageModel {
    self.isGetImageCalled = true;
    return self.image;
}
- (void)saveImage:(UIImage *)image forImageModel:(ImageModel *)imageModel {
    self.isSetImageCalled = true;
    self.image = image;
}

@end
