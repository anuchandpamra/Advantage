//
//  SearchResultsSummaryItem.m
//  GSAAdvantage
//
//  Created by Anupam Chandra on 2/27/12.
//  Copyright (c) 2012 SoftExcel Technologies Inc.,. All rights reserved.
//

#import "SearchResultsSummaryItem.h"

@implementation SearchResultsSummaryItem

@synthesize title = _title, vendor = _vendor, mfrPartNum = _mfrPartNum;
@synthesize description = _description, manufacturer = _manufacturer, price = _price;

- (id) initWithDescription:(NSString *)description manufacturer:(NSString *)manufacturer price:(NSString *)price   {
    self = [super init];
    
    if (self) {
        _description = description;
        _manufacturer = manufacturer;
        _price = price ;
        return self;
    }
    return nil;
}

@end
