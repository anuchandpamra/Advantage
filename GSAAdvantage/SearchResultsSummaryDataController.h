//
//  SearchResultsSummaryDataController.h
//  GSAAdvantage
//
//  Created by Anupam Chandra on 2/27/12.
//  Copyright (c) 2012 SoftExcel Technologies Inc.,. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SearchResultsSummaryItem;

@interface SearchResultsSummaryDataController : NSObject <NSXMLParserDelegate>

@property (nonatomic, strong) SearchResultsSummaryItem *currentItem;
@property (nonatomic, copy) NSString *currentString;
@property (nonatomic, copy) NSMutableArray *summarySearchResults;
@property (nonatomic, copy) NSString *queryString;

- (unsigned) countOfSummarySearchResults;
- (SearchResultsSummaryItem *)objectInSummarySearchResultsAtIndex:(NSUInteger)index;
- (void) addSearchResultsSummaryItemWithDescription:(NSString *)description
                                       manufacturer:(NSString *)manufacturer price:(NSString *)price;
- (void) addSearchResultsSummaryItem:(SearchResultsSummaryItem *)summaryItem;

@end
