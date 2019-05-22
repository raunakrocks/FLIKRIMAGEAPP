//
//  ImageService.m
//  FlikrImageApp
//
//  Created by Raunak Talwar on 21/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import "ImageServiceImpl.h"
#import "Parser.h"

@implementation ImageServiceImpl

static NSString const *baseURL = @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=9945b6b6c0746ab326edd066f793228b&%20format=json&nojsoncallback=1&safe_search=1&per_page=40&text=";

- (void)searchImagesWithText:(NSString *)text
                  pageNumber: (NSInteger)pageNumber
          completionHandler:(void (^)(NSArray<ImageModel *> *data, NSError *error))completionHandler {
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@&page=%li", baseURL, text, (long)pageNumber];
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:url
            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if(data!=nil) {
                    NSLog(@"DATA = %@", data);
                    NSError *error=nil;
                    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                    if(error==nil) {
                        NSArray<ImageModel *> *result = [Parser parseDataIntoImageModels:json];
                        completionHandler(result, nil);
                    } else {
                        completionHandler(nil, error);
                    }
                }
            }] resume];
}

@end
