//
//  EditFormViewController.m
//  formidable
//
//  Created by Chris Tucci on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditFormViewController.h"
#import "AddRowViewController.h"

@interface EditFormViewController ()

@end

@implementation EditFormViewController
@synthesize theForm;
@synthesize theTableView;
@synthesize formTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (void)loadView
//{
//    // If you create your views manually, you MUST override this method and use it to create your views.
//    // If you use Interface Builder to create your views, then you must NOT override this method.
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self refreshFormTitle];

}

-(void)refreshFormTitle
{
    formTitle.text = [theForm valueForKey:@"title"];
}

- (void)viewDidUnload
{
    [self setTheTableView:nil];
    [self setFormTitle:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    int numsections = [[theForm valueForKey:@"sections"]count];
    return numsections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSArray * thisSection = [[[theForm valueForKey:@"sections"]objectAtIndex:section]valueForKey:@"items"];
    int numrows = [thisSection count];
    
    return numrows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"TextCell";
    NSDictionary *itemForCell = [[[[theForm valueForKey:@"sections"]objectAtIndex:indexPath.section]valueForKey:@"items"]objectAtIndex:indexPath.row];
    NSLog(@"Item For Cell: %@",itemForCell);
    NSString *itemType = [itemForCell valueForKey:@"type"];
    
    if ([itemType isEqualToString:@"text_item"])
    {
        CellIdentifier = @"TextCell";
    }
    else if ([itemType isEqualToString:@"numeric_item"])
    {
        CellIdentifier = @"NumericCell";
    }
    else if ([itemType isEqualToString:@"static_item"])
    {
        CellIdentifier = @"StaticCell";
    }
    else if ([itemType isEqualToString:@"radio_item"])
    {
        CellIdentifier  = @"RadioCell";
    }
    else if ([itemType isEqualToString:@"incremental_item"])
    {
        CellIdentifier = @"IncrementalCell";
    }
    else {
        CellIdentifier = @"NewCell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if ([itemType isEqualToString:@"text_item"])
    {
        UILabel *textCellLabel = (UILabel *)[cell viewWithTag:101];
        textCellLabel.text = [itemForCell valueForKey:@"label"];
        UITextField *textCellTextField = (UITextField *)[cell viewWithTag:102];
        textCellTextField.placeholder = [itemForCell valueForKey:@"placeholder"];
        
    }
    else if ([itemType isEqualToString:@"numeric_item"])
    {
        UILabel *numericCellLabel = (UILabel *)[cell viewWithTag:101];
        numericCellLabel.text = [itemForCell valueForKey:@"label"];
        UITextField *numericCellTextField = (UITextField *)[cell viewWithTag:102];
        numericCellTextField.placeholder = [itemForCell valueForKey:@"placeholder"];
        
    }
    else if ([itemType isEqualToString:@"static_item"])
    {
        UILabel *staticCellLabel = (UILabel *)[cell viewWithTag:101];
        staticCellLabel.text = [itemForCell valueForKey:@"label"];
        
    }
    else if ([itemType isEqualToString:@"radio_item"])
    {
        
    }
    else if ([itemType isEqualToString:@"incremental_item"])
    {
        
    }
    else {
        cell.textLabel.text = @"I am a new row";
    }
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"addRow"]) {

        AddRowViewController *detailViewController = [segue destinationViewController];
        detailViewController.theSections = [theForm valueForKey:@"sections"];
        detailViewController.delegate = self;
        UIStoryboardPopoverSegue* popoverSegue = (UIStoryboardPopoverSegue*)segue;
        [detailViewController setPopoverController:[popoverSegue popoverController]];

        }
} 


//MARK: Add Row Delegate Delegate Methods
-(void)addRowToSection:(int)section
{
    NSMutableDictionary *aNewItem = [[NSMutableDictionary alloc]init];
    [aNewItem setValue:@"New Item" forKey:@"label"];
    [[[[theForm valueForKey:@"sections"]objectAtIndex:section]valueForKey:@"items"]addObject:aNewItem];
    [theTableView reloadData];
}

@end
