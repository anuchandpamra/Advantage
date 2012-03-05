//
//  SearchResultsSummaryDataController.m
//  GSAAdvantage
//
//  Created by Anupam Chandra on 2/27/12.
//  Copyright (c) 2012 SoftExcel Technologies Inc.,. All rights reserved.
//

#import "SearchResultsSummaryDataController.h"
#import "SearchResultsSummaryItem.h"


@implementation SearchResultsSummaryDataController

@synthesize summarySearchResults = _summarySearchResults, currentItem = _currentItem, currentString = _currentString;
@synthesize queryString = _queryString;

- (id) init {
    if (self = [super init]) {
        self.summarySearchResults = [[NSMutableArray alloc] init];
        return self;
    }
    return nil;
}

- (void) setSummarySearchResults:(NSMutableArray *)summarySearchResults{
    if (summarySearchResults != _summarySearchResults) {
        _summarySearchResults = [summarySearchResults mutableCopy];
    }
}

- (unsigned) countOfSummarySearchResults{
    return [self.summarySearchResults count];
}

- (SearchResultsSummaryItem *) objectInSummarySearchResultsAtIndex:(NSUInteger)index{
    return [self.summarySearchResults objectAtIndex:index];
}

- (void) addSearchResultsSummaryItemWithDescription:(NSString *)description manufacturer:(NSString *)manufacturer price:(NSString *)price{
    SearchResultsSummaryItem *summaryItem = [[SearchResultsSummaryItem alloc] initWithDescription:description manufacturer:manufacturer price:price];
    [self.summarySearchResults addObject:summaryItem];
}

- (void) addSearchResultsSummaryItem:(SearchResultsSummaryItem *)summaryItem{
    [self.summarySearchResults addObject:summaryItem];
}


////////////////////////////////////////////////////////////////////////////////////////////////
///////////////// All XML Parser related functions - Just jamming them right here //////////////
////////////////////////////////////////////////////////////////////////////////////////////////

- (void) parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"Starting Document processing");
    self.summarySearchResults = [[NSMutableArray alloc] init];
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
    if ([elementName isEqualToString:@"autn:hit"]){
        self.currentItem = [[SearchResultsSummaryItem alloc] init];
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSLog(@"Found raw characters: %@", string);
    self.currentString = string;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    NSLog(@"Element is closing: %@", elementName);
    if ([elementName isEqualToString:@"autn:hit"]){
        NSLog(@"Search item Will be added to the collection");
        [self addSearchResultsSummaryItem:self.currentItem];
    }
    
    if ([elementName isEqualToString:@"DESC"]) {
        self.currentItem.description = self.currentString;
    }
    
    if ([elementName isEqualToString:@"autn:title"]) {
        self.currentItem.title = self.currentString;
    }

    if ([elementName isEqualToString:@"MPNO"]) {
        self.currentItem.mfrPartNum = self.currentString;
    }

    if ([elementName isEqualToString:@"PR"]) {
        self.currentItem.price = [NSString stringWithFormat:@"$%@", self.currentString];
    }
    
    if ([elementName isEqualToString:@"MFR"]) {
        if ([self.currentString isEqualToString:@"N/A"]) {
            self.currentItem.manufacturer = @"GSA";
        }
        else {
            self.currentItem.manufacturer = self.currentString;
        }
    }

    if ([elementName isEqualToString:@"VND"]) {
        self.currentItem.vendor = self.currentString;
    }

}

@end
