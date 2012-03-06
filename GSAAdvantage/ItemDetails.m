//
//  ItemDetails.m
//  GSAAdvantage
//
//  Created by Anupam Chandra on 3/5/12.
//  Copyright (c) 2012 SoftExcel Technologies Inc.,. All rights reserved.
//

#import "ItemDetails.h"
#import "VendorForItem.h"

@implementation ItemDetails

@synthesize itemName = _itemName, imageURL = _imageURL, mfrPartNum = _mfrPartNum, mfr = _mfr;
@synthesize ctrPartNum = _ctrPartNum, ctrNumber = _ctrNumber, masSINNumber = _masSINNumber;
@synthesize price = _price, description = _description, vendorList = _vendorList;
@synthesize contractorName = _contractorName;


- (void) setVendorList:(NSMutableArray *)vendorList{
    if (vendorList != _vendorList) {
        _vendorList = [vendorList mutableCopy];
    }
}

- (void) addVendorToList:(VendorForItem *) vendor {
    [self.vendorList addObject:vendor];
}

@end
