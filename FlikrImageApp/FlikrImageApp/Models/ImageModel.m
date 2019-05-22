//
//  ImageModel.m
//  FlikrImageApp
//
//  Created by Raunak Talwar on 21/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import "ImageModel.h"

@interface ImageModel()
@property(nonatomic, strong, readwrite) NSString *farm;
@property(nonatomic, strong, readwrite) NSString *server;
@property(nonatomic, strong, readwrite) NSString *imageID;
@property(nonatomic, strong, readwrite) NSString *secret;
@end

@implementation ImageModel

- (instancetype)initWithFarm:(NSString *)farm server:(NSString *)server imageID:(NSString *)imageID secret:(NSString *)secret {
    self = [super init];
    if(self) {
        self.farm = farm;
        self.server = server;
        self.imageID = imageID;
        self.secret = secret;
    }
    return self;
}

- (NSString *)imageURLString {
    return [NSString stringWithFormat:@"https://farm%@.static.flickr.com/%@/%@_%@.jpg", self.farm, self.server, self.imageID, self.secret];
}

@end
