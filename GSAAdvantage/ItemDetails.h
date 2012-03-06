//
//  ItemDetails.h
//  GSAAdvantage
//
//  Created by Anupam Chandra on 3/5/12.
//  Copyright (c) 2012 SoftExcel Technologies Inc.,. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VendorForItem;

@interface ItemDetails : NSObject


@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *mfrPartNum;
@property (nonatomic, copy) NSString *mfr;
@property (nonatomic, copy) NSString *ctrPartNum;
@property (nonatomic, copy) NSString *ctrNumber;
@property (nonatomic, copy) NSString *masSINNumber;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *contractorName;
@property (nonatomic, copy) NSMutableArray *vendorList;

- (void) setVendorList:(NSMutableArray *)vendorList;
- (void) addVendorToList:(VendorForItem *) vendor;

@end
