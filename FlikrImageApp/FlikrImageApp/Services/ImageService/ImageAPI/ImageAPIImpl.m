//
//  ImageAPIImpl.m
//  FlikrImageApp
//
//  Created by Raunak Talwar on 23/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import "ImageAPIImpl.h"
#import "Parser.h"

@implementation ImageAPIImpl

static NSString const *baseURL = @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=9945b6b6c0746ab326edd066f793228b&%20format=json&nojsoncallback=1&safe_search=1&per_page=40&text=";

- (void)getImageModelsWithText:(NSString *)text
                    pageNumber: (NSInteger)pageNumber
             completionHandler:(void (^)(NSArray<ImageModel *> *data, NSError *error))completionHandler {
    NSString *escapedText = [text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *urlString = [NSString stringWithFormat:@"%@%@&page=%li", baseURL, escapedText , (long)pageNumber];
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url
            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if(data!=nil) {
                    NSError *error=NULL;
                    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                    NSArray<ImageModel *> *result = [Parser parseDataIntoImageModels:json];
                    if(error==NULL && result.count > 0) {
                        completionHandler(result, NULL);
                    } else {
                        completionHandler(NULL, [NSError errorWithDomain:@"SOMETHING WENT WRONG, TRY AGAIN LATER" code:200 userInfo:NULL]);
                    }
                } else {
                    NSError *error = [NSError errorWithDomain:@"SOMETHING WENT WRONG, TRY AGAIN LATER" code:200 userInfo:NULL];
                    completionHandler(NULL, error);
                }
            }] resume];
}

- (void)getImageForImageModel:(ImageModel *)imageModel
            completionHandler:(void (^)(UIImage *image, NSError *error))completionHandler {
    NSURL *url=[NSURL URLWithString: imageModel.imageURLString];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData: imageData];
    if(image!=NULL)
        completionHandler(image, NULL);
    else {
        NSError *error = [NSError errorWithDomain:@"NULL IMAGE" code:200 userInfo:NULL];
        completionHandler(NULL, error);
    }
}

@end
