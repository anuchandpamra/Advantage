//
//  SearchResultsSummaryItemViewController.h
//  GSAAdvantage
//
//  Created by Anupam Chandra on 2/27/12.
//  Copyright (c) 2012 SoftExcel Technologies Inc.,. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchResultsSummaryDataController;
@class ItemDetailsDataController;

@interface SearchResultsSummaryItemViewController : UITableViewController

@property (nonatomic, strong) SearchResultsSummaryDataController *searchResultsSummaryDataController;
@property (nonatomic, strong) ItemDetailsDataController *itemDetailDataController;

@end
