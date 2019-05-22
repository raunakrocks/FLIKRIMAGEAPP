//
//  ImageStorageHelperTests.m
//  FlikrImageAppTests
//
//  Created by Raunak Talwar on 23/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ImageStorageHelper.h"

@interface ImageStorageHelperTests : XCTestCase

@end

@implementation ImageStorageHelperTests

- (void)testImageStorageHelper {
    UIImage *image = [[UIImage alloc] init];
    [ImageStorageHelper saveImage:image withName:@"testImage.png"];
    XCTAssertNil([ImageStorageHelper loadImage:@"randomImage.png"]);
    XCTAssertNotNil([ImageStorageHelper loadImage:@"testImage.png"]);
}

@end
