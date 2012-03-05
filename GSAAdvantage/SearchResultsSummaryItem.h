//
//  SearchResultsSummaryItem.h
//  GSAAdvantage
//
//  Created by Anupam Chandra on 2/27/12.
//  Copyright (c) 2012 SoftExcel Technologies Inc.,. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResultsSummaryItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *mfrPartNum;
@property (nonatomic, copy) NSString *vendor;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *manufacturer;
@property (nonatomic, copy) NSString *price;

- (id) initWithDescription:(NSString *) description manufacturer:(NSString *) manufacturer price:(NSString *) price;
@end
