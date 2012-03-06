//
//  DetailViewController.h
//  GSAAdvantage
//
//  Created by Anupam Chandra on 3/4/12.
//  Copyright (c) 2012 SoftExcel Technologies Inc.,. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemDetailsDataController;

@interface DetailViewController : UITableViewController

@property (nonatomic, strong) ItemDetailsDataController *itemDetailDataController;

@end
