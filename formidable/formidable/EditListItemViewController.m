//
//  EditListItemViewController.m
//  formidable
//
//  Created by Chris Tucci on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditListItemViewController.h"

@interface EditListItemViewController ()

@end

@implementation EditListItemViewController
@synthesize theItem;
@synthesize delegate;
@synthesize itemIndexPath;

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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    int numrows = 0;
    
    switch (section) {
        case 0:
            numrows = 1;
            break;
        case 1:
        {
            NSString *theOptionsAsString = [theItem valueForKey:@"options"];
            NSArray *optionsArray = [theOptionsAsString componentsSeparatedByString:@","];
            numrows = [optionsArray count];
            break;
        }
        case 2:
            numrows = 1;
            break;
        default:
            break;
    }
    return numrows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    switch (indexPath.section) {
        case 0:
            CellIdentifier = @"labelCell";
            break;
        case 1:
            CellIdentifier = @"optionCell";
            break;
        case 2:
            CellIdentifier = @"deleteCell";
            break;
            
        default:
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    switch (indexPath.section) {
        case 0:
        {
            UILabel *label = (UILabel *)[cell viewWithTag:101];
            label.text = @"Label";
            UITextField *textField = (UITextField *)[cell viewWithTag:102];
            textField.text = [theItem valueForKey:@"label"];
            textField.delegate = self;
            break;
        }
        case 1:
        {
            NSString *theOptionsAsString = [theItem valueForKey:@"options"];
            NSArray *optionsArray = [theOptionsAsString componentsSeparatedByString:@","];
            UILabel *label = (UILabel *)[cell viewWithTag:101];
            label.text = [[NSNumber numberWithInt:indexPath.row + 1]stringValue];
            UITextField *textField = (UITextField *)[cell viewWithTag:102];
            textField.text = [optionsArray objectAtIndex:indexPath.row];
            textField.delegate = self;
            UIButton *deleteButton = (UIButton *)[cell viewWithTag:103];
            deleteButton.backgroundColor = [UIColor redColor];
            break;
        }
        case 2:
        {
            UILabel *label = (UILabel *)[cell viewWithTag:101];
            label.text = @"Add a choice";
            
        }
            break;
            
        default:
            break;
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
    switch (indexPath.section) {
        case 2:
        {
            //push new VC to add a new choice
            NSString *oldString = [theItem valueForKey:@"options"];
            if ([oldString length] > 0) {
            oldString = [NSString stringWithFormat:@"%@,New Choice",oldString];
            } else {
                oldString = [NSString stringWithFormat:@"New Choice",oldString];

            }
            [theItem setValue:oldString forKey:@"options"];
            [tableView reloadData];
            break;
        }
            
        default:
            break;
    }
}

-(void)deleteChoiceAtRow:(id)sender {
    NSIndexPath *indexPathForDelete = [self.tableView indexPathForCell:(UITableViewCell *)[[sender superview]superview]];
    
    NSString *theOptionsAsString = [theItem valueForKey:@"options"];
    NSMutableArray *optionsArray = [[theOptionsAsString componentsSeparatedByString:@","]mutableCopy];
    
    [optionsArray removeObjectAtIndex:indexPathForDelete.row];
    
    NSString *newValue = @"";
    for (id option in optionsArray) {
        newValue = [NSString stringWithFormat:@"%@%@,",newValue,option];
    }
    
    
    if ( [newValue length] > 0) {
        newValue = [newValue substringToIndex:[newValue length] - 1];
    } else {
        newValue = nil;
    }

    [theItem setValue:newValue forKey:@"options"];
    [self.tableView reloadData];
    
}

#pragma mark - TextView Delegate

//MARK: TextView Delegate Stuff

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    string = newString;
    
    NSIndexPath *indexPathForTextField = [self.tableView indexPathForCell:(UITableViewCell *)[[textField superview]superview]];
    
    
    if (indexPathForTextField.section == 0) {
        NSString *newValue = @"";
        if ( [newValue length] > 0) {
            newValue = [newValue substringToIndex:[newValue length] - 1];
        } else {
            newValue = nil;
        }
        [theItem setValue:newString forKey:@"label"];
        [delegate didChangeListItemAtIndexPath:itemIndexPath withValue:newString forKey:@"label"];
    } else {
        NSString *theOptionsAsString = [theItem valueForKey:@"options"];
        NSMutableArray *optionsArray = [[theOptionsAsString componentsSeparatedByString:@","]mutableCopy];

        [optionsArray replaceObjectAtIndex:indexPathForTextField.row withObject:string];
        
        NSString *newValue = @"";
        for (id option in optionsArray) {
            newValue = [NSString stringWithFormat:@"%@%@,",newValue,option];
        }
        
        
        if ( [newValue length] > 0) {
            newValue = [newValue substringToIndex:[newValue length] - 1];
        } else {
            newValue = nil;
        }
        
        [theItem setValue:newValue forKey:@"options"]; 
    }
    return YES;    
}


@end
