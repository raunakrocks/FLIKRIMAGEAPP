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
- (void)searchImagesWithText:(NSString *)text
                  pageNumber: (NSInteger)pageNumber
           completionHandler:(void (^)(NSArray<ImageModel *> *data, NSError *error))completionHandler;
@end

@implementation FlikrHomeViewModelTests

- (void)testSearchImagesWithTextAndPageNumber {
    MockServiceImpl *service = [[MockServiceImpl alloc] init];
    FlikrHomeViewModel *viewModel = [[FlikrHomeViewModel alloc] initWithImageService:service];
    [viewModel searchImagesWithText:@"hello" pageNumber:5 completionHandler:^{ }];
    XCTAssertEqual(service.text, @"hello");
    XCTAssertEqual(service.pageNumber, 5);
}

@end

@implementation MockServiceImpl
- (void)searchImagesWithText:(NSString *)text
                  pageNumber: (NSInteger)pageNumber
           completionHandler:(void (^)(NSArray<ImageModel *> *data, NSError *error))completionHandler {
    self.text = text;
    self.pageNumber = pageNumber;
}
@end
