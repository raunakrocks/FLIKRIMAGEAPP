//
//  ImageFetcherService.m
//  FlikrImageApp
//
//  Created by Raunak Talwar on 21/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import "ImageFetcherService.h"

@implementation ImageFetcherService
+ (UIImage *)imageForImageURLString:(NSString *)imageURLString {
    NSURL *url=[NSURL URLWithString: imageURLString];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
    return [UIImage imageWithData: imageData];
}
@end
