//
//  FormSettingsViewController.m
//  formidable
//
//  Created by Chris Tucci on 2/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FormSettingsViewController.h"

@interface FormSettingsViewController ()

@end

@implementation FormSettingsViewController
@synthesize formTitleCell = _formTitleCell;
@synthesize delegate = _delegate;
@synthesize formTitleTextField = _formTitleTextField;
@synthesize formCreatorTextField = _formCreatorTextField;
@synthesize formCreatorURLTextField = _formCreatorURLTextField;
@synthesize destinationURLTextField = _destinationURLTextField;
@synthesize form = _form;


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

-(void)setInitialTextFieldValues
{
    _formTitleTextField.text =  [_form valueForKey:@"title"];
    _formCreatorTextField.text = [_form valueForKey:@"creator"];
    _formCreatorURLTextField.text = [_form valueForKey:@"creatorURL"];
    _destinationURLTextField.text = [_form valueForKey:@"destinationURL"];
}

- (void)viewDidUnload
{
    [self setFormTitleTextField:nil];
    [self setFormCreatorTextField:nil];
    [self setFormCreatorURLTextField:nil];
    [self setDestinationURLTextField:nil];
    [self setFormTitleCell:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


//MARK: Textfield Delegate methods

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    string = newString;
    if (textField == _formTitleTextField)
    {
        [_form setValue:string forKey:@"title"];
        [_delegate didModifyFormSettings:_form];
    } else if (textField == _formCreatorTextField) {
        [_form setValue:string forKey:@"creator"];
        [_delegate didModifyFormSettings:_form];
    } else if (textField == _formCreatorURLTextField) {
        [_form setValue:string forKey:@"creatorURL"];
        [_delegate didModifyFormSettings:_form];
    } else if (textField == _destinationURLTextField) {
        [_form setValue:string forKey:@"destinationURL"];
        [_delegate didModifyFormSettings:_form];
    }
    
    return YES;

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
