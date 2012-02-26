
//
//  CreateEditListViewController.m
//  formidable
//
//  Created by Chris Tucci on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CreateEditListViewController.h"
#import "EditFormViewController.h"
@interface CreateEditListViewController ()

@end

@implementation CreateEditListViewController
@synthesize theTableView;
@synthesize theForms;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTheTableView:nil];
    [self setTheTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//MARK: TableView Stuff


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *templates_directory = [documentsDirectoryPath stringByAppendingPathComponent:@"/templates"];
    NSError *error;
    NSArray *templatesDirectoryContents = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:templates_directory error:&error];
    
    theForms = [[NSArray alloc]initWithArray:templatesDirectoryContents];
    
    return [theForms count];
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FormsListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.textLabel.text = [theForms objectAtIndex:indexPath.row];
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    // Return NO if you do not want the specified item to be editable.
    
    return NO;
    
}

//pushFormDetailView

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"createForm"]) {
        EditFormViewController *detailViewController = [segue destinationViewController];
        
        NSMutableDictionary *form = [[NSMutableDictionary alloc]init ];
        [form setValue:@"New Form" forKey:@"title"];
        NSMutableArray *sections = [[NSMutableArray alloc]init];
        [form setValue:sections forKey:@"sections"];
        NSMutableDictionary *firstSection = [[NSMutableDictionary alloc]init];
        [firstSection setValue:@"First Section" forKey:@"title"];
        NSMutableArray *items = [[NSMutableArray alloc]init ];
        NSMutableDictionary *firstItem = [[NSMutableDictionary alloc]init ];
        [firstItem setValue:@"First Item" forKey:@"label"];
        [items addObject:firstItem];
        [firstSection setValue:items forKey:@"items"];
        [sections addObject:firstSection];
        
        detailViewController.theForm = form;
        
        
    } else if ([[segue identifier]isEqualToString:@"editExistingForm"]) {
        EditFormViewController *detailViewController = [segue destinationViewController];
        
        NSString *filename = [theForms objectAtIndex: [theTableView indexPathForSelectedRow].row];
        NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *templatePath = [documentsDirectoryPath stringByAppendingPathComponent:@"/templates"];
        templatePath = [templatePath stringByAppendingPathComponent:filename];
        NSMutableDictionary *form = [[NSMutableDictionary alloc]initWithContentsOfFile:templatePath];
        detailViewController.theForm = form;
        
    }
    
}



@end
