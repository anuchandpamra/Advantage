//
//  ItemDetailsDataController.m
//  GSAAdvantage
//
//  Created by Anupam Chandra on 3/6/12.
//  Copyright (c) 2012 SoftExcel Technologies Inc.,. All rights reserved.
//

#import "ItemDetailsDataController.h"
#import "ItemDetails.h"
#import "VendorForItem.h"


@implementation ItemDetailsDataController

bool addingAVendor;
NSMutableString *socioInds;
bool socioIndIsEmpty;

@synthesize itemDetails = _itemDetails, vendor = _vendor, currentString = _currentString;



- (unsigned) countOfVendors{
    return [self.itemDetails.vendorList count];
}

- (VendorForItem *) vendorForItemAtIndex:(NSUInteger)index{
    return [self.itemDetails.vendorList objectAtIndex:index];
}

////////////////////////////////////////////////////////////////////////////////////////////////
///////////////// All XML Parser related functions - Just jamming them right here //////////////
////////////////////////////////////////////////////////////////////////////////////////////////

- (void) parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"Starting Document processing");
    self.itemDetails = [[ItemDetails alloc] init];
    addingAVendor = false;
}

- (void) parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"Ending Document processing");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    NSLog(@"Found an element :%@",elementName);
    if (attributeDict && [attributeDict count] > 0) {
        NSLog(@"Element %@ has Attributes: %@",elementName, attributeDict);
    }
    
    //A new search element is found when the parser discovers a tag autn:hit
    if ([elementName isEqualToString:@"vndr_list"]){
        self.itemDetails.vendorList = [[NSMutableArray alloc] init];
    }
    
    if ([elementName isEqualToString:@"vndr"]){
        addingAVendor = true;
        self.vendor = [[VendorForItem alloc] init];
    }

    if ([elementName isEqualToString:@"socio_inds"]) {
        socioIndIsEmpty = true;
        socioInds = [[NSMutableString alloc] init];
    }
    
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSLog(@"Found raw characters: %@", string);
    self.currentString = string;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    NSLog(@"Element is closing: %@", elementName);
    if ([elementName isEqualToString:@"title"]){
        self.itemDetails.itemName = self.currentString;
        self.currentString = nil;
    }
    
    if ([elementName isEqualToString:@"mpno"]) {
        self.itemDetails.mfrPartNum = self.currentString;
        self.currentString = nil;
    }
    
    if ([elementName isEqualToString:@"cpno"]) {
        self.itemDetails.ctrPartNum = self.currentString;
        self.currentString = nil;
    }
    
    if ([elementName isEqualToString:@"mfr"]) {
        self.itemDetails.mfr = self.currentString;
        self.currentString = nil;
    }
    
    if ([elementName isEqualToString:@"cntrct_num"]) {
        self.itemDetails.ctrNumber = self.currentString;
        self.currentString = nil;
    }
    
    if ([elementName isEqualToString:@"MAS"]) {
        self.itemDetails.masSINNumber = self.currentString;
        self.currentString = nil;
    }
    
    if ([elementName isEqualToString:@"SIN"]) {
        self.itemDetails.masSINNumber = self.currentString;
        self.currentString = nil;
    }
    
    if ([elementName isEqualToString:@"photo_url"]) {
        self.itemDetails.imageURL = self.currentString;
        self.currentString = nil;
    }
    
    if ([elementName isEqualToString:@"price"]) {
        if (addingAVendor) {
            self.vendor.itemPrice = self.currentString;
            self.currentString = nil;
        }
        else {
            self.itemDetails.price = self.currentString;
            self.currentString = nil;
        }
    }
    
    if ([elementName isEqualToString:@"vndr_name"]) {
        if (addingAVendor) {
            self.vendor.contractorName = self.currentString;
            self.currentString = nil;
        }
        else {
            self.itemDetails.contractorName = self.currentString;
            self.currentString = nil;
        }
    }
    
    if ([elementName isEqualToString:@"socio_inds"]) {
        self.vendor.socioIndicators = socioInds;
        socioInds = nil;
    }
    
    if ([elementName isEqualToString:@"ind"]) {
        if (self.currentString) {
            if (socioIndIsEmpty) {
                [socioInds appendString:self.currentString];
                 socioIndIsEmpty = false;
            }
            else {
                [socioInds appendFormat:@",%@", self.currentString];
            }
            self.currentString = nil;
        }
    }
    
    if ([elementName isEqualToString:@"delivery_dt"]) {
        if (addingAVendor) {
            self.vendor.deliveryDays = self.currentString;
        }
    }
    
    
    if ([elementName isEqualToString:@"vndr"]) {
        if (self.itemDetails != nil) {
            [self.itemDetails addVendorToList:self.vendor];
        }
        addingAVendor = false;      
    }
    
}


@end
