//
//  ImageCache.m
//  FlikrImageApp
//
//  Created by Raunak Talwar on 21/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import "ImageCache.h"

@interface ImageCache()
//The key is the image URL string and value is the file of image stored in temp directory;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSString *> *cache;
@end

@implementation ImageCache

+ (instancetype)shared {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype) init {
    self = [super init];
    if(self) {
        self.cache = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSString *)getImageFilePathForImageURLString:(NSString *)imageURLString {
    return [_cache objectForKey:imageURLString];
}

- (void)setImageFilePathForImageURLString:(NSString *)imageURLString imagePath:(NSString *)imagePath {
    [_cache setObject:imagePath forKey:imageURLString];
}

@end
