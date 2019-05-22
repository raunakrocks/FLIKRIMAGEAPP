//
//  ImageFetcherService.h
//  FlikrImageApp
//
//  Created by Raunak Talwar on 21/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImageFetcherService : NSObject
+ (UIImage *)imageForImageURLString:(NSString *)imageURLString;
@end

