//
//  DownloadFormViewController.m
//  formidable
//
//  Created by Chris Tucci on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DownloadFormViewController.h"

@interface DownloadFormViewController ()

@end

@implementation DownloadFormViewController
@synthesize urlTextField;
@synthesize usernameTextField;
@synthesize passwordTextField;
@synthesize downloadButton;
@synthesize delegate;

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
    [self setUrlTextField:nil];
    [self setUsernameTextField:nil];
    [self setPasswordTextField:nil];
    [self setDownloadButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    // Configure the cell...
//    
//    return cell;
//}

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
//MARK: Button Pressed

- (void)downloadButtonPressed:(id)sender {
    if([self sendMessageWithUsername:usernameTextField.text andPassword:passwordTextField.text andURL:urlTextField.text]) {
        [delegate connectionDidFinishSuccessfully];
    } else {
        [delegate connectionDidFinishWithError];
    }
}

-(BOOL)sendMessageWithUsername:(id)username andPassword:(id)password andURL:(id)url
{
    BOOL gotResponse = NO;
    NSString *theURLString;
    if (([username length] == 0) && ([password length] == 0)) {
        theURLString = [NSString stringWithFormat:@"http://%@",url];

    } else {
        theURLString = [NSString stringWithFormat:@"https://%@:%@@%@",username, password, url];

    }
    
    
    NSURL *theURL = [[NSURL alloc]initWithString:theURLString];
    
    NSData *theResponse = [NSData dataWithContentsOfURL:theURL];
    
        if(theResponse) {
            NSString *formName = @"downloaded-form";
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat: @"yyyy-MM-dd-HH:mm:ss"]; 
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            formName = [NSString stringWithFormat:@"%@_%@.plist",formName,dateString];
            NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *templates_directory = [documentsDirectoryPath stringByAppendingPathComponent:@"/templates"];
            NSString *fileNameWithPath = [templates_directory stringByAppendingPathComponent:formName];
            [theResponse writeToFile:fileNameWithPath atomically:YES];
            gotResponse = YES;
        } else {
            gotResponse = NO;
        }
//    
//    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc]initWithURL:theURL];
//    
//    [theRequest setHTTPMethod:@"GET"];
//    NSURLConnection *theConnection = [[NSURLConnection alloc]initWithRequest:theRequest delegate:self];
//    if (theConnection) {
//        // Create the NSMutableData to hold the received data.
//        // receivedData is an instance variable declared elsewhere.
//        NSLog(@"We have a conenction");
//    } else {
//        // Inform the user that the connection failed.
//    }
//    
    
    return gotResponse;
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
            
}


@end
