//
//  ImageModelTests.m
//  FlikrImageAppTests
//
//  Created by Raunak Talwar on 23/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ImageModel.h"

@interface ImageModelTests : XCTestCase

@end

@implementation ImageModelTests

- (void)testInit {
    ImageModel *imageModel = [[ImageModel alloc] initWithFarm:@"testFarm"
                                                       server:@"testServer"
                                                      imageID:@"123"
                                                       secret:@"testSecret"];
    XCTAssertEqual(imageModel.farm, @"testFarm");
    XCTAssertEqual(imageModel.server, @"testServer");
    XCTAssertEqual(imageModel.imageID, @"123");
    XCTAssertEqual(imageModel.secret, @"testSecret");
}

- (void)testImageURLString {
    NSString *expectedImageURLString = @"https://farmtestFarm.static.flickr.com/testServer/123_testSecret.jpg";
    ImageModel *imageModel = [[ImageModel alloc] initWithFarm:@"testFarm"
                                                       server:@"testServer"
                                                      imageID:@"123"
                                                       secret:@"testSecret"];
    XCTAssertTrue([imageModel.imageURLString isEqualToString:expectedImageURLString]);
}

@end
