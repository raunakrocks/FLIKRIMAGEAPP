//
//  Parser.m
//  FlikrImageApp
//
//  Created by Raunak Talwar on 21/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import "Parser.h"

@implementation Parser
+ (NSArray<ImageModel *> *)parseDataIntoImageModels:(NSDictionary *)json {
    NSMutableArray<ImageModel *> *result = [NSMutableArray array];
    NSDictionary *photosData = json[@"photos"];
    NSArray *photosDataArray = photosData[@"photo"];
    for (NSDictionary *photoDict in photosDataArray) {
        NSString *farm = photoDict[@"farm"];
        NSString *server = photoDict[@"server"];
        NSString *imageID = photoDict[@"id"];
        NSString *secret = photoDict[@"secret"];
        ImageModel *model = [[ImageModel alloc] initWithFarm:farm
                                                      server:server
                                                     imageID:imageID
                                                      secret:secret];
        [result addObject:model];
    }
    return result;
}
@end
