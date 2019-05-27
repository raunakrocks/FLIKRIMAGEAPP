//
//  ImageStorageHelper.h
//  FlikrImageApp
//
//  Created by Raunak Talwar on 23/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageStorageHelper : NSObject
+ (void)saveImage:(UIImage *)image withName:(NSString *)name;
+ (UIImage *)loadImage:(NSString *)name;
@end
