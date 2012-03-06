//
//  ItemDetailsDataController.h
//  GSAAdvantage
//
//  Created by Anupam Chandra on 3/6/12.
//  Copyright (c) 2012 SoftExcel Technologies Inc.,. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ItemDetails;
@class VendorForItem;

@interface ItemDetailsDataController : NSObject <NSXMLParserDelegate>

@property (nonatomic, strong) ItemDetails *itemDetails;
@property (nonatomic, strong) VendorForItem *vendor;
@property (nonatomic, copy) NSString *currentString;

- (unsigned) countOfVendors;
- (VendorForItem *)vendorForItemAtIndex:(NSUInteger)index;

@end
