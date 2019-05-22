//
//  ImageModel.h
//  FlikrImageApp
//
//  Created by Raunak Talwar on 21/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject
@property(nonatomic, strong, readonly) NSString *farm;
@property(nonatomic, strong, readonly) NSString *server;
@property(nonatomic, strong, readonly) NSString *imageID;
@property(nonatomic, strong, readonly) NSString *secret;
@property(nonatomic, strong, readonly) NSString *imageURLString;

- (instancetype)initWithFarm:(NSString *)farm server:(NSString *)server imageID:(NSString *)imageID secret:(NSString *)secret;
@end

