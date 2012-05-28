 //
//  EditFormViewController.m
//  formidable
//
//  Created by Chris Tucci on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditFormViewController.h"
#import "AddRowViewController.h"
#import "AddSectionViewController.h"

@interface EditFormViewController ()

@end

@implementation EditFormViewController
@synthesize theForm;
@synthesize theTableView;
@synthesize formTitle;
@synthesize pathToForm;
@synthesize popoverPresenterView;

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
    self.navigationController.navigationBar.hidden = YES;
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
    [self setPopoverPresenterView:nil];
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
    
    if ([itemType isEqualToString:@"text_item"]) {
        CellIdentifier = @"TextCell";
    } else if ([itemType isEqualToString:@"numeric_item"]) {
        CellIdentifier = @"NumericCell";
    } else if ([itemType isEqualToString:@"static_item"]) {
        CellIdentifier = @"StaticCell";
    } else if ([itemType isEqualToString:@"radio_item"]) {
        CellIdentifier  = @"RadioCell";
    } else if ([itemType isEqualToString:@"incremental_item"]) {
        CellIdentifier = @"IncrementalCell";
    } else if ([itemType isEqualToString:@"list_item"]) {
        CellIdentifier = @"ListCell";
    }
    else {
        CellIdentifier = @"NewCell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if ([itemType isEqualToString:@"text_item"]) {
        UILabel *textCellLabel = (UILabel *)[cell viewWithTag:101];
        textCellLabel.text = [itemForCell valueForKey:@"label"];
        UITextField *textCellTextField = (UITextField *)[cell viewWithTag:102];
        textCellTextField.placeholder = [itemForCell valueForKey:@"placeholder"];
        
    } else if ([itemType isEqualToString:@"numeric_item"]) {
        UILabel *numericCellLabel = (UILabel *)[cell viewWithTag:101];
        numericCellLabel.text = [itemForCell valueForKey:@"label"];
        UITextField *numericCellTextField = (UITextField *)[cell viewWithTag:102];
        numericCellTextField.placeholder = [itemForCell valueForKey:@"placeholder"];
        
    } else if ([itemType isEqualToString:@"static_item"]) {
        UILabel *staticCellLabel = (UILabel *)[cell viewWithTag:101];
        staticCellLabel.text = [itemForCell valueForKey:@"label"];
        
    } else if ([itemType isEqualToString:@"radio_item"]) {
        UILabel *radioLabel = (UILabel *)[cell viewWithTag:101];
        radioLabel.text = [itemForCell valueForKey:@"label"];
        UISegmentedControl *segmentedControl = (UISegmentedControl *)[cell viewWithTag:102];
        [segmentedControl setTitle:[itemForCell valueForKey:@"optiona"] forSegmentAtIndex:0];
        [segmentedControl setTitle:[itemForCell valueForKey:@"optionb"] forSegmentAtIndex:1];
        [segmentedControl addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
        
    } else if ([itemType isEqualToString:@"incremental_item"]) {
        UILabel *incrementalLabel = (UILabel *)[cell viewWithTag:101];
        incrementalLabel.text = [itemForCell valueForKey:@"label"];
        
        UITextView *textField = (UITextView *)[cell viewWithTag:102];
        textField.text = [itemForCell valueForKey:@"value"];
        
        UIStepper *stepper = (UIStepper *)[cell viewWithTag:103];
        stepper.value = [[itemForCell valueForKey:@"value"]doubleValue];
        [stepper addTarget:self action:@selector(stepperValueDidChange:) forControlEvents:UIControlEventValueChanged];
        
        
    } else if ([itemType isEqualToString:@"list_item"]) {
        UILabel *listLabel = (UILabel *)[cell viewWithTag:101];
        listLabel.text = [itemForCell valueForKey:@"label"];
        
    } else {
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
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *titleForHeader = @"";
    
    titleForHeader = [[[theForm valueForKey:@"sections"]objectAtIndex:section]valueForKey:@"title"];
    
    return titleForHeader;
    
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    float height = 88;
    return height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *container = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 88)];
    UIView *sectionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 77)];
    sectionHeaderView.backgroundColor = [UIColor lightGrayColor];
    NSString *titleForHeader = @"";
    titleForHeader = [[[theForm valueForKey:@"sections"]objectAtIndex:section]valueForKey:@"title"];
    NSString *descriptionForHeader = @"";
    descriptionForHeader = [[[theForm valueForKey:@"sections"]objectAtIndex:section]valueForKey:@"header"];
    UILabel *sectionHeaderLabel = [[UILabel alloc]initWithFrame:CGRectMake(22, 11, tableView.bounds.size.width -22, 22)];
    sectionHeaderLabel.font = [UIFont fontWithName:@"Georgia-Bold" size:22]; 
    sectionHeaderLabel.text = titleForHeader;
    sectionHeaderLabel.backgroundColor  = [UIColor clearColor];
    UILabel *sectionHeaderDescription = [[UILabel alloc]initWithFrame:CGRectMake(22,33, tableView.bounds.size.width - 22, 44)];
    sectionHeaderDescription.font = [UIFont fontWithName:@"Georgia" size:12];
    sectionHeaderDescription.text = descriptionForHeader;
    sectionHeaderDescription.numberOfLines = 2;
    sectionHeaderDescription.backgroundColor = [UIColor clearColor];
    
    [container addSubview:sectionHeaderView];
    [sectionHeaderView addSubview:sectionHeaderDescription];
    [sectionHeaderView addSubview:sectionHeaderLabel];
    
    return container;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"addRow"]) {

        AddRowViewController *detailViewController = (AddRowViewController *)[[segue destinationViewController]topViewController];
        detailViewController.theSections = [theForm valueForKey:@"sections"];
        detailViewController.delegate = self;
        UIStoryboardPopoverSegue* popoverSegue = (UIStoryboardPopoverSegue*)segue;
        [detailViewController setPopoverController:[popoverSegue popoverController]];

    } else if ([[segue identifier] isEqualToString:@"addSection"]) {
        
        AddSectionViewController *addSectionViewController = [segue destinationViewController];
        addSectionViewController.theSections = [NSArray arrayWithArray:[theForm valueForKey:@"sections"]];
        addSectionViewController.delegate = self;
        UIStoryboardPopoverSegue* popoverSegue = (UIStoryboardPopoverSegue*)segue;
        [addSectionViewController setPopoverController:[popoverSegue popoverController]];
        
    } else if ([[segue identifier] isEqualToString:@"formSettings"]) {
        
        FormSettingsViewController *formSettingsViewController = [segue destinationViewController];
        formSettingsViewController.form = theForm;
        [formSettingsViewController setInitialTextFieldValues];
        formSettingsViewController.delegate = self;
        
    } else if ([[segue identifier] isEqualToString:@"editTextItem"])  {       


        EditTextItemViewController *editTextItemViewController = [segue destinationViewController];
        editTextItemViewController.indexPathForTheItem = [theTableView indexPathForSelectedRow];
        int section = [theTableView indexPathForSelectedRow].section;
        int row = [theTableView indexPathForSelectedRow].row;
        id item = [[[[theForm valueForKey:@"sections"] objectAtIndex:section] valueForKey:@"items"] objectAtIndex:row];

        editTextItemViewController.theItem = item;
        editTextItemViewController.delegate = self;
               [editTextItemViewController initializeTextFieldValues];
        CGRect cellFrame = [theTableView rectForRowAtIndexPath:[theTableView indexPathForSelectedRow]];
        popoverPresenterView.frame = CGRectMake(cellFrame.origin.x, cellFrame.origin.y + 73, cellFrame.size.width, cellFrame.size.height);
        
    } else if ([[segue identifier] isEqualToString:@"editStaticItem"]) {
        
        EditStaticItemViewController *editStaticItemViewController = [segue destinationViewController];
        editStaticItemViewController.indexPathForTheItem = [theTableView indexPathForSelectedRow];
        int section = [theTableView indexPathForSelectedRow].section;
        int row = [theTableView indexPathForSelectedRow].row;
        id item = [[[[theForm valueForKey:@"sections"] objectAtIndex:section] valueForKey:@"items"] objectAtIndex:row];
        editStaticItemViewController.theItem = [[NSMutableDictionary alloc]initWithDictionary:item];
        editStaticItemViewController.delegate = self;
        [editStaticItemViewController initalizeValue];
        CGRect cellFrame = [theTableView rectForRowAtIndexPath:[theTableView indexPathForSelectedRow]];
        popoverPresenterView.frame = CGRectMake(cellFrame.origin.x, cellFrame.origin.y + 73, cellFrame.size.width, cellFrame.size.height);

        
    } else if ([[segue identifier] isEqualToString:@"editNumericItem"]) {
        
        EditNumericItemViewController *editNumericItemViewController = [segue destinationViewController];
        editNumericItemViewController.indexPathForTheItem = [theTableView indexPathForSelectedRow];
        int section = [theTableView indexPathForSelectedRow].section;
        int row = [theTableView indexPathForSelectedRow].row;
        id item = [[[[theForm valueForKey:@"sections"] objectAtIndex:section] valueForKey:@"items"] objectAtIndex:row];
        editNumericItemViewController.theItem = item;
        editNumericItemViewController.delegate = self;
        [editNumericItemViewController initializeValues];
        CGRect cellFrame = [theTableView rectForRowAtIndexPath:[theTableView indexPathForSelectedRow]];
        popoverPresenterView.frame = CGRectMake(cellFrame.origin.x, cellFrame.origin.y + 73, cellFrame.size.width, cellFrame.size.height);

        
    } else if ([[segue identifier] isEqualToString:@"editRadioItem"]) {
        
        EditRadioItemViewController *detailViewController = [segue destinationViewController];
        detailViewController.indexPathForTheItem = [theTableView indexPathForSelectedRow];
        int section = [theTableView indexPathForSelectedRow].section;
        int row = [theTableView indexPathForSelectedRow].row;
        id item = [[[[theForm valueForKey:@"sections"] objectAtIndex:section] valueForKey:@"items"] objectAtIndex:row];
        detailViewController.theItem = item;
        detailViewController.delegate = self;
        [detailViewController initializeValues];
        CGRect cellFrame = [theTableView rectForRowAtIndexPath:[theTableView indexPathForSelectedRow]];
        popoverPresenterView.frame = CGRectMake(cellFrame.origin.x, cellFrame.origin.y + 22, cellFrame.size.width, cellFrame.size.height);
        

        
    } else if ([[segue identifier] isEqualToString:@"editIncrementalItem"]) {
        
        EditIncrementalItemViewController *detailViewController = [segue destinationViewController];
        detailViewController.indexPathForTheItem = [theTableView indexPathForSelectedRow];
        int section = [theTableView indexPathForSelectedRow].section;
        int row = [theTableView indexPathForSelectedRow].row;
        id item = [[[[theForm valueForKey:@"sections"] objectAtIndex:section] valueForKey:@"items"] objectAtIndex:row];
        detailViewController.theItem = item;
        detailViewController.delegate = self;
        [detailViewController initializeValues];
        CGRect cellFrame = [theTableView rectForRowAtIndexPath:[theTableView indexPathForSelectedRow]];
        popoverPresenterView.frame = CGRectMake(cellFrame.origin.x, cellFrame.origin.y + 73, cellFrame.size.width, cellFrame.size.height);

    } else if ([[segue identifier] isEqualToString:@"editListItem"]) {
        
        EditListItemViewController *detailViewController = [segue destinationViewController];
        detailViewController.itemIndexPath = [theTableView indexPathForSelectedRow];
        int section = [theTableView indexPathForSelectedRow].section;
        int row = [theTableView indexPathForSelectedRow].row;
        id item = [[[[theForm valueForKey:@"sections"] objectAtIndex:section] valueForKey:@"items"] objectAtIndex:row];
        detailViewController.theItem = item;
        detailViewController.delegate = self;
//        [detailViewController initializeValues];
        CGRect cellFrame = [theTableView rectForRowAtIndexPath:[theTableView indexPathForSelectedRow]];
        popoverPresenterView.frame = CGRectMake(cellFrame.origin.x, cellFrame.origin.y + 73, cellFrame.size.width, cellFrame.size.height);
    }

}
//MARK: Edit Text Item Delegate Methods

-(void)didChangeNumericItemAtIndexPath:(NSIndexPath *)indexPath withValue:(NSString *)value forKey:(NSString *)key {
    id itemToChange = [[[[theForm valueForKey:@"sections"] objectAtIndex:indexPath.section] valueForKey:@"items"] objectAtIndex:indexPath.row];
    [itemToChange setValue:value forKey: key];
    [theTableView reloadData];

}

-(void)didChangeIncrementalItemAtIndexPath:(NSIndexPath *)indexPath withValue:(NSString *)value forKey:(NSString *)key {
    id itemToChange = [[[[theForm valueForKey:@"sections"] objectAtIndex:indexPath.section] valueForKey:@"items"] objectAtIndex:indexPath.row];
    [itemToChange setValue:value forKey: key];
    [theTableView reloadData];
    
}

-(void)didChangeStaticItemAtIndexPath:(NSIndexPath *)indexPath withValue:(NSString *)value forKey:(NSString *)key {
    id itemToChange = [[[[theForm valueForKey:@"sections"] objectAtIndex:indexPath.section] valueForKey:@"items"] objectAtIndex:indexPath.row];
    [itemToChange setValue:value forKey: key];
    [theTableView reloadData];
    
}

-(void)didChangeRadioItemAtIndexPath:(NSIndexPath *)indexPath withValue:(NSString *)value forKey:(NSString *)key {
    id itemToChange = [[[[theForm valueForKey:@"sections"] objectAtIndex:indexPath.section] valueForKey:@"items"] objectAtIndex:indexPath.row];
    [itemToChange setValue:value forKey: key];
    [theTableView reloadData];
    
}

-(void)didChangeTextItemAtIndexPath:(NSIndexPath *)indexPath withValue:(NSString *)value forKey:(NSString *)key {
    id itemToChange = [[[[theForm valueForKey:@"sections"] objectAtIndex:indexPath.section] valueForKey:@"items"] objectAtIndex:indexPath.row];
    [itemToChange setValue:value forKey: key];
    [theTableView reloadData];
    
}

-(void)didChangeListItemAtIndexPath:(NSIndexPath *)indexPath withValue:(NSString *)value forKey:(NSString *)key {
    id itemToChange = [[[[theForm valueForKey:@"sections"] objectAtIndex:indexPath.section] valueForKey:@"items"] objectAtIndex:indexPath.row];
    [itemToChange setValue:value forKey: key];
    [theTableView reloadData];
}


//MARK: Add Row Delegate Delegate Methods
-(void)addRowToSection:(int)section  withType:(NSString *)type
{
    NSMutableDictionary *aNewItem = [[NSMutableDictionary alloc]init];
    [aNewItem setValue:@"New Item" forKey:@"label"];
    [aNewItem setValue:type forKey:@"type"];
    [[[[theForm valueForKey:@"sections"]objectAtIndex:section]valueForKey:@"items"]addObject:aNewItem];
    [theTableView reloadData];
}

//MARK: Add Section delegate methods
-(void)addSectionAtIndex:(int)section
{
    NSMutableDictionary *aNewSection = [[NSMutableDictionary alloc]init];
    [aNewSection setValue:@"New Section" forKey:@"title"];
    NSMutableArray *itemsForNewSection = [[NSMutableArray alloc]init];
//    NSMutableDictionary *aNewItem = [[NSMutableDictionary alloc]init];
//    [aNewItem setValue:@"New Item" forKey:@"label"];
//    [aNewItem setValue:type forKey:@"type"];
//    [itemsForNewSection addObject:aNewItem];
    [aNewSection setValue:itemsForNewSection forKey:@"items"];
    [[theForm valueForKey:@"sections"]insertObject:aNewSection atIndex:section];
    [theTableView reloadData];
    
}

//MARK: Form Settings Delegate Methods
-(void)didModifyFormSettings:(id)form {
    theForm = form;
    [theTableView reloadData];
    [self refreshFormTitle];
}

//MARK: Save Button Methods
-(IBAction)saveButtonPressed {
    NSString *formName = [theForm valueForKey:@"title"];
    
    BOOL formExists = NO;//[self formExistsWithName:formName];
    
    if (formExists) {
        //rename the form
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Uh Oh!" message:@"There's already a form with the same name, please rename the form and try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    } else {
        NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *templatePath = [documentsDirectoryPath stringByAppendingPathComponent:@"/templates"];
        templatePath = [templatePath stringByAppendingPathComponent:formName];
        [theForm writeToFile:templatePath atomically:YES];
    }

}

-(BOOL)formExistsWithName:(NSString *)name
{
    BOOL formAlreadyExists = NO;
    
    NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *templates_directory = [documentsDirectoryPath stringByAppendingPathComponent:@"/templates"];
    NSError *error;
    NSArray *templatesDirectoryContents = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:templates_directory error:&error];
    
    NSArray *allForms = [[NSArray alloc]initWithArray:templatesDirectoryContents];
    
    NSLog(@"ALL FORMS: %@", allForms);
    if ([allForms containsObject:name]) {
        formAlreadyExists = YES;
    }
    
    return formAlreadyExists;
}

-(IBAction)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - exports

- (IBAction)exportButtonPressed {

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
