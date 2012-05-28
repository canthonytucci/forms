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
@synthesize formTitle;
@synthesize currentTextField;



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
    
//    UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 70)];
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:tableHeaderView.frame];
//    titleLabel.textAlignment = UITextAlignmentCenter;
//    titleLabel.font = [UIFont boldSystemFontOfSize:32];
    formTitle.text = [theForm valueForKey:@"title"];


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{

    [self setFormTitle:nil];
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if ([itemType isEqualToString:@"text_item"]) {
        UILabel *textCellLabel = (UILabel *)[cell viewWithTag:101];
        textCellLabel.text = [itemForCell valueForKey:@"label"];
        UITextField *textCellTextField = (UITextField *)[cell viewWithTag:102];
        textCellTextField.placeholder = [itemForCell valueForKey:@"placeholder"];
        textCellTextField.delegate = self;   
    } else if ([itemType isEqualToString:@"numeric_item"]) {
        UILabel *numericCellLabel = (UILabel *)[cell viewWithTag:101];
        numericCellLabel.text = [itemForCell valueForKey:@"label"];
        UITextField *numericCellTextField = (UITextField *)[cell viewWithTag:102];
        numericCellTextField.placeholder = [itemForCell valueForKey:@"placeholder"];
        numericCellTextField.delegate = self;
        
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
        UILabel *label = (UILabel *)[cell viewWithTag:101];
        label.text = [itemForCell valueForKey:@"label"];
        UILabel *valueLabel = (UILabel *)[cell viewWithTag:102];
        valueLabel.text = [itemForCell valueForKey:@"value"];
    }
    
    
    
    return cell;
}

-(void)stepperValueDidChange:(id)sender
{
    int section =  [[self tableView]indexPathForCell:(UITableViewCell *)[[sender superview]superview]].section;
    int row =  [[self tableView]indexPathForCell:(UITableViewCell *)[[sender superview]superview]].row;
    UITextField *associatedTextField = (UITextField *)[[[self tableView]cellForRowAtIndexPath:[[self tableView]indexPathForCell:(UITableViewCell *)[[sender superview]superview]]]viewWithTag:102];
    NSString *newValue = [[NSNumber numberWithDouble:[(UIStepper *)sender value]]stringValue];
    
    associatedTextField.text = newValue;
    
    id item = [[[[theForm valueForKey:@"sections"]objectAtIndex:section]valueForKey:@"items"]objectAtIndex:row];
    
    [item setValue:newValue forKey:@"value"];
    
}

-(void)segmentedControlValueDidChange:(id)sender
{
    int section =  [[self tableView]indexPathForCell:(UITableViewCell *)[[sender superview]superview]].section;
    int row =  [[self tableView]indexPathForCell:(UITableViewCell *)[[sender superview]superview]].row;
    id item = [[[[theForm valueForKey:@"sections"]objectAtIndex:section]valueForKey:@"items"]objectAtIndex:row];
    id value;
    if ([(UISegmentedControl *)sender selectedSegmentIndex] == 0)
    {
        value = @"optiona";
    }
    else 
    {
        value = @"optionb";
    }
    
    [item setValue: value forKey:@"value"];

}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{

    currentTextField = textField;
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
        
    int section =  [[self tableView]indexPathForCell:(UITableViewCell *)[[textField superview]superview]].section;
    int row =  [[self tableView]indexPathForCell:(UITableViewCell *)[[textField superview]superview]].row;
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    string = newString;
    id item = [[[[theForm valueForKey:@"sections"]objectAtIndex:section]valueForKey:@"items"]objectAtIndex:row];
    [item setValue:string forKey:@"value"];

    return YES;
}

-(IBAction)saveButtonPressed:(id)sender
{
    NSString *formName = [theForm valueForKey:@"title"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"yyyy-MM-dd-HH:mm:ss"]; 
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    formName = [NSString stringWithFormat:@"%@_%@",formName,dateString];
        

        NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *templatePath = [documentsDirectoryPath stringByAppendingPathComponent:@"/collected"];
        templatePath = [templatePath stringByAppendingPathComponent:formName];
        [theForm writeToFile:templatePath atomically:YES];
    


    [[self navigationController]popViewControllerAnimated:YES];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [currentTextField resignFirstResponder];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
{
    if ([[segue identifier]isEqualToString:@"editPickerItem"]){
        PickerSelectionViewController *detailViewController = [segue destinationViewController];
        detailViewController.delegate = self;
        int section = [self.tableView indexPathForSelectedRow].section;
        int row = [self.tableView indexPathForSelectedRow].row;
        id item = [[[[theForm valueForKey:@"sections"] objectAtIndex:section] valueForKey:@"items"] objectAtIndex:row];
        detailViewController.theItem = item;
    }
}

#pragma mark - picker delegate

-(void)pickerValueDidChange {
    [self.tableView reloadData];
}
@end
