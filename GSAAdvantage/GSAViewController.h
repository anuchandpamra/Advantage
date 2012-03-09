//
//  GSAViewController.h
//  GSAAdvantage
//
//  Created by Anupam Chandra on 2/15/12.
//  Copyright (c) 2012 SoftExcel Technologies Inc.,. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchResultsSummaryDataController;

@interface GSAViewController : UIViewController <NSXMLParserDelegate, UISearchBarDelegate> {
    NSMutableData* myTokenBuffer;
}


@property (strong, nonatomic)SearchResultsSummaryDataController *searchResultDataController;
@property (strong, nonatomic)NSString *currentSearchQuery;
@property (weak, nonatomic) IBOutlet UISearchBar *searchField;
@end
