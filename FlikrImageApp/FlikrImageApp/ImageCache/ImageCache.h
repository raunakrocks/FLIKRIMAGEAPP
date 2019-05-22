//
//  ImageCache.h
//  FlikrImageApp
//
//  Created by Raunak Talwar on 21/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageCache : NSObject
-(instancetype) init __attribute__((unavailable("init not available for cache, use shared instance"))); 
+(id)shared;
- (NSString *)getImageFilePathForImageURLString:(NSString *)imageURLString;
- (void)setImageFilePathForImageURLString:(NSString *)imageURLString imagePath: (NSString *)imagePath;
@end

