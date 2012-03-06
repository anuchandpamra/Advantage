//
//  DetailViewController.m
//  GSAAdvantage
//
//  Created by Anupam Chandra on 3/4/12.
//  Copyright (c) 2012 SoftExcel Technologies Inc.,. All rights reserved.
//

#import "DetailViewController.h"
#import "ItemDetailsDataController.h"
#import "ItemDetails.h"

// Tags for the item general information
#define IMAGEVIEW_TAG 1
#define TITLELABEL_TAG 2
#define MPNOLABEL_TAG 3
#define CPNOLABEL_TAG 4
#define CTRNUMLABEL_TAG 5
#define MASSINLABEL_TAG 6
#define PRICELABEL_TAG 7
#define DESCLABEL_TAG 8

// Tags for the vendor list
#define VNDRPRICELABEL_TAG 1
#define VENDORNAMELABEL_TAG 2
#define SOCIOLABEL_TAG 3
#define DLVRYDAYSLABEL_TAG 4

@interface DetailViewController ()

@property NSInteger selectedRowIndex;

@end

@implementation DetailViewController

@synthesize selectedRowIndex = _selectedRowIndex, itemDetailDataController = _itemDetailDataController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.itemDetailDataController countOfVendors] + 3;
}


- (void) displayImageIn:(UITableViewCell *)cell withImageURL:(NSString *)imageURLStr {
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:IMAGEVIEW_TAG];
    
    NSURL * imageURL = [NSURL URLWithString:imageURLStr];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    
    imageView.image = image;
    
}


- (void) displayGenericItemInfo:(UITableViewCell *)cell{
    
    
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:TITLELABEL_TAG];
    UILabel *mpnoLabel = (UILabel *)[cell.contentView viewWithTag:MPNOLABEL_TAG];
    UILabel *cpnoLabel = (UILabel *)[cell.contentView viewWithTag:CPNOLABEL_TAG];
    UILabel *ctrNumLabel = (UILabel *)[cell.contentView viewWithTag:CTRNUMLABEL_TAG];
    UILabel *masSINLabel = (UILabel *)[cell.contentView viewWithTag:MASSINLABEL_TAG];
    UILabel *priceabel = (UILabel *)[cell.contentView viewWithTag:PRICELABEL_TAG];
    UILabel *descLabel = (UILabel *)[cell.contentView viewWithTag:DESCLABEL_TAG];
    

    ItemDetails *itemDetails = self.itemDetailDataController.itemDetails;       
    
    titleLabel.text = itemDetails.itemName;
    mpnoLabel.text = itemDetails.mfrPartNum;
    cpnoLabel.text = itemDetails.ctrPartNum;
    ctrNumLabel.text = itemDetails.ctrNumber;
    masSINLabel.text = itemDetails.masSINNumber;
    priceabel.text = itemDetails.price;
    descLabel.text = itemDetails.description;
    
    [self displayImageIn:cell withImageURL:itemDetails.imageURL];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    static NSString *genericInfoCellId = @"SearchItemGenericInfo";
    static NSString *headerCellId = @"Header1";
    static NSString *vndrItemHdrCellId = @"VendorItemHeader";
    static NSString *vendorsCellId = @"SearchItemVendors";
    
    
    UITableViewCell *cell;
    
    switch (indexPath.row) {
        case 0:
            cell = [tableView dequeueReusableCellWithIdentifier:genericInfoCellId];
            [self displayGenericItemInfo:cell];
            break;
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:headerCellId];
            break;
        case 2:
            cell = [tableView dequeueReusableCellWithIdentifier:vndrItemHdrCellId];
            break;
        default:
            cell = [tableView dequeueReusableCellWithIdentifier:vendorsCellId];
            break;
    }
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat result;
    switch ([indexPath row])
    {
        case 0:
            result = 160.0f;
            break;
        case 1:
            result = 20.f;
            break;
        case 2:
            result = 20.0f;
            break;
        default:
            result = 50.0f;
            break;
    }
    return result;
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
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.selectedRowIndex == indexPath.row) {
        return; 
    }
    
    NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:self.selectedRowIndex inSection:0];
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    if (newCell.accessoryType == UITableViewCellAccessoryNone) {
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.selectedRowIndex = indexPath.row;
    }
    
    UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
    if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        oldCell.accessoryType = UITableViewCellAccessoryNone;
    }
}

@end
