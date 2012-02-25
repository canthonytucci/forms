//
//  FormDetailViewController.m
//  formidable
//
//  Created by Chris Tucci on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FormDetailViewController.h"

@interface FormDetailViewController ()

@end

@implementation FormDetailViewController

@synthesize theForm;



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
