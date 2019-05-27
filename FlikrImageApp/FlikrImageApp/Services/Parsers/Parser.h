//
//  Parser.h
//  FlikrImageApp
//
//  Created by Raunak Talwar on 21/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageModel.h"

@interface Parser : NSObject
+ (NSArray<ImageModel *> *)parseDataIntoImageModels:(NSDictionary *)json;
@end

