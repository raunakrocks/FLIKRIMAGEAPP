//
//  ImageCacheTests.m
//  FlikrImageAppTests
//
//  Created by Raunak Talwar on 23/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ImageCache.h"

@interface ImageCacheTests : XCTestCase

@end

@implementation ImageCacheTests

- (void)testImageCache {
    XCTAssertNil([[ImageCache shared] getImageFilePathForImageURLString:@"testImageURLString"]);
    
    [[ImageCache shared] setImageFilePathForImageURLString:@"testImageURLString" imagePath:@"C://tmp/image.jpg"];
    
    NSString *actualImagePathForRandomKey = [[ImageCache shared] getImageFilePathForImageURLString:@"randomKey"];
    XCTAssertNil(actualImagePathForRandomKey);
    
    NSString *expectedImagePath = @"C://tmp/image.jpg";
    NSString *actualImagePathForExactKey = [[ImageCache shared] getImageFilePathForImageURLString:@"testImageURLString"];
    XCTAssertTrue([actualImagePathForExactKey isEqualToString: expectedImagePath]);
}


@end
