//
//  SearchResultsSummaryItemViewController.m
//  GSAAdvantage
//
//  Created by Anupam Chandra on 2/27/12.
//  Copyright (c) 2012 SoftExcel Technologies Inc.,. All rights reserved.
//

#import "SearchResultsSummaryItemViewController.h"
#import "SearchResultsSummaryDataController.h"
#import "SearchResultsSummaryItem.h"
#import "DetailViewController.h"
#import "ItemDetailsDataController.h"

#define TITLELABEL_TAG 1
#define PRICELABEL_TAG 2
#define MPNOLABEL_TAG 3
#define DESCLABEL_TAG 4
#define MFRLABEL_TAG 5
#define VENDORLABEL_TAG 6

@interface SearchResultsSummaryItemViewController ()

@end


@implementation SearchResultsSummaryItemViewController

@synthesize searchResultsSummaryDataController = _searchResultsSummaryDataController;
@synthesize itemDetailDataController = _itemDetailDataController;

bool iPad = false;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(id) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        _itemDetailDataController = [[ItemDetailsDataController alloc] init];
#ifdef UI_USER_INTERFACE_IDIOM
        iPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#endif
        return self;
    }
    
    return nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (iPad) {
        self.tableView.rowHeight = 200.f;
    }
    else {
        self.tableView.rowHeight = 100.f;
    }

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *cell = sender;
    
    // Find the index path for this cell
    NSIndexPath *indexPath = [(UITableView *)cell.superview indexPathForCell: cell];
    SearchResultsSummaryItem *searchItem = [self.searchResultsSummaryDataController objectInSummarySearchResultsAtIndex:indexPath.row];
        
    
    if ([[segue identifier] isEqualToString:@"ShowItemDetails"]) {
        DetailViewController *detailViewController = [segue destinationViewController];
        //NSLog(@">>>>>>>>>>>>>===========>>>>>>>>>>>>>>> Ready to Segue ShowItemDetails");
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSString *myFile = [mainBundle pathForResource: @"ProductDetail" ofType: @"xml"];
        NSInputStream *iStream = [[NSInputStream alloc] initWithFileAtPath:myFile];
        
        NSXMLParser *queryResultsXMLParser = [[NSXMLParser alloc] initWithStream:iStream];
        [queryResultsXMLParser setDelegate:self.itemDetailDataController];
        [queryResultsXMLParser setShouldResolveExternalEntities:YES];
        [queryResultsXMLParser parse];
        detailViewController.itemDetailDataController = self.itemDetailDataController;
        //NSLog(@">>>>>>>>>>>>>===========>>>>>>>>>>>>>>> File Path is %@",myFile);
    } 
}

#pragma mark - Table view data source

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [@"Search Results for: " stringByAppendingFormat: self.searchResultsSummaryDataController.queryString];
}


//This will change color for alternate rows
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row%2 == 0) {
        UIColor *altCellColor = [UIColor lightGrayColor];
        cell.backgroundColor = altCellColor;
    } 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.searchResultsSummaryDataController countOfSummarySearchResults];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SearchResultsSummaryItemCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    SearchResultsSummaryItem *searchItem = [self.searchResultsSummaryDataController objectInSummarySearchResultsAtIndex:indexPath.row];
    
    UILabel *titleLabel;
    UILabel *priceLabel;
    UILabel *mpnoLabel;
    UILabel *mfrLabel;
    UILabel *vendorLabel;
    UILabel *descLabel;
    
    
    titleLabel = (UILabel *)[cell.contentView viewWithTag:TITLELABEL_TAG];
    
    priceLabel = (UILabel *)[cell.contentView viewWithTag:PRICELABEL_TAG];
    
    mpnoLabel = (UILabel *)[cell.contentView viewWithTag:MPNOLABEL_TAG];
    
    descLabel = (UILabel *)[cell.contentView viewWithTag:DESCLABEL_TAG];
    
    mfrLabel = (UILabel *)[cell.contentView viewWithTag:MFRLABEL_TAG];
    
    vendorLabel = (UILabel *)[cell.contentView viewWithTag:VENDORLABEL_TAG];
    
    titleLabel.text = searchItem.title;
    priceLabel.text = searchItem.price;
    mpnoLabel.text = searchItem.mfrPartNum;
    mfrLabel.text = searchItem.manufacturer;
    descLabel.text = searchItem.description;
    vendorLabel.text = searchItem.vendor;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
