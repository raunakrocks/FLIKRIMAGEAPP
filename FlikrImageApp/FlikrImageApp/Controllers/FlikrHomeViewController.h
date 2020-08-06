//
//  ViewController.h
//  FlikrImageApp
//
//  Created by Raunak Talwar on 20/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlikrHomeViewModel.h"

@interface FlikrHomeViewController : UIViewController
-(instancetype)initWithViewModel: (FlikrHomeViewModel *)viewModel andPageNumber: (NSInteger) pageNumber;
@end

