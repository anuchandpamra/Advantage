//
//  GSAViewController.m
//  GSAAdvantage
//
//  Created by Anupam Chandra on 2/15/12.
//  Copyright (c) 2012 SoftExcel Technologies Inc.,. All rights reserved.
//

#import "GSAViewController.h"
#import "SearchResultsSummaryItemViewController.h"
#import "SearchResultsSummaryDataController.h"

@implementation GSAViewController;
@synthesize searchField;

@synthesize searchResultDataController = _searchResultDataController, currentSearchQuery = _currentSearchQuery;

NSString * const hostDNS = @"www.gsaadvantage.gov/advantage/s/search.do?q=0:0";
NSString * const wsPath = @"&q=1:4ADV.OFF*&db=0&searchType=1&c=30&z=r";



-(id) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        _searchResultDataController = [[SearchResultsSummaryDataController alloc] init];
        return self;
    }
    
    return nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.searchField resignFirstResponder];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setSearchField:nil];
    [super viewDidUnload];
    [self.searchField resignFirstResponder];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.searchField resignFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.searchField resignFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowSearchSummaryResults"]) {
        SearchResultsSummaryItemViewController *searchResultsSummaryViewController = [segue
                                                           destinationViewController];
        //NSLog(@">>>>>>>>>>>>>===========>>>>>>>>>>>>>>> Ready to Segue");
        searchResultsSummaryViewController.searchResultsSummaryDataController = self.searchResultDataController;
        //NSLog(@">>>>>>>>>>>>>===========>>>>>>>>>>>>>>> Segueing");
    } 
}


////////////////////////////////////////////////////////////////////////////////////////////////
///////////////// All XML Parser related functions - Just jamming them right here //////////////
////////////////////////////////////////////////////////////////////////////////////////////////

- (void) parserDidStartDocument:(NSXMLParser *)parser{ 

    NSString *currSearch = self.currentSearchQuery;
    
    self.searchResultDataController.queryString = currSearch;
    
    
    [self.searchResultDataController parserDidStartDocument:parser];
}

- (void) parserDidEndDocument:(NSXMLParser *)parser{
    [self.searchResultDataController parserDidEndDocument:parser];
    [self performSegueWithIdentifier:@"ShowSearchSummaryResults" sender:searchField];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    [self.searchResultDataController parser:parser didStartElement:elementName namespaceURI:namespaceURI qualifiedName:qName attributes:attributeDict];
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.searchResultDataController parser: parser foundCharacters:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    [self.searchResultDataController parser: parser didEndElement:elementName namespaceURI:namespaceURI qualifiedName:qName];
}

#pragma mark - UISearchBarDelegate

- (void)startSearch:(NSString *)searchText {
    
    if ([searchText length] == 0) {
        return;
    }
    
    self.currentSearchQuery = searchText;
    
    
    NSXMLParser *queryResultsXMLParser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@%@%@", hostDNS,self.currentSearchQuery, wsPath]]];
    [queryResultsXMLParser setDelegate:self];
    [queryResultsXMLParser setShouldResolveExternalEntities:YES];
    [queryResultsXMLParser parse];
    
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self startSearch: searchBar.text];
    [searchBar resignFirstResponder];
    
}


@end
