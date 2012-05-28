//
//  CollectedDataDetailViewController.m
//  formidable
//
//  Created by Chris Tucci on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CollectedDataDetailViewController.h"

@interface CollectedDataDetailViewController ()

@end

@implementation CollectedDataDetailViewController
@synthesize theForm;
@synthesize pathToForm;
@synthesize theTableView;




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

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *titleForHeader = @"";
    
    titleForHeader = [[[theForm valueForKey:@"sections"]objectAtIndex:section]valueForKey:@"title"];
    
    return titleForHeader;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CollectedDataDetailCell";
    NSDictionary *itemForCell = [[[[theForm valueForKey:@"sections"]objectAtIndex:indexPath.section]valueForKey:@"items"]objectAtIndex:indexPath.row];
    NSLog(@"Item For Cell: %@",itemForCell);
        
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UILabel *textCellLabel = (UILabel *)[cell viewWithTag:101];
    textCellLabel.text = [itemForCell valueForKey:@"label"];
    UILabel *textCellValue = (UILabel *)[cell viewWithTag:102];
    textCellValue.text = [itemForCell valueForKey:@"value"];

    
    
    
    return cell;
}


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

- (IBAction)exportButtonPressed:(id)sender {

    //*** Send email
	MFMailComposeViewController *emailpicker = [[MFMailComposeViewController alloc] init];
	
    emailpicker.mailComposeDelegate = self;
	
    [emailpicker setSubject:@"Form Data"];
	
	
    // Attach Plist XML to the email

    NSData *myData = [NSData dataWithContentsOfFile:pathToForm];
    [emailpicker addAttachmentData:myData mimeType:@"plist" fileName:@"formdata.plist"];
	
    // Fill out the email body text	
    NSString *emailBody = @"Attached form file";
    [emailpicker setMessageBody:emailBody isHTML:NO];
	
    [self presentModalViewController:emailpicker animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{   
    NSString *message;
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            message = @"Result: canceled";
            break;
        case MFMailComposeResultSaved:
            message = @"Result: saved";
            break;
        case MFMailComposeResultSent:
            message = @"Result: sent";
            break;
        case MFMailComposeResultFailed:
            message = @"Result: failed";
            break;
        default:
            message = @"Result: not sent";
            break;
    }
    NSLog(@"%@", message);
    [self dismissModalViewControllerAnimated:YES];
}

@end
