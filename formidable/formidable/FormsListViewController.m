    //
//  FormsListViewController.m
//  formidable
//
//  Created by Chris Tucci on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FormsListViewController.h"
#import "FormDetailViewController.h"

@interface FormsListViewController ()

@end

@implementation FormsListViewController
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

//- (void)loadView
//{
//    // If you create your views manually, you MUST override this method and use it to create your views.
//    // If you use Interface Builder to create your views, then you must NOT override this method.
//
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
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
    
    if ([[segue identifier] isEqualToString:@"PushFormDetailView"]) {
        FormDetailViewController *detailViewController = [segue destinationViewController];
        
        NSString *filename = [theForms objectAtIndex: [theTableView indexPathForSelectedRow].row];
        NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *templatePath = [documentsDirectoryPath stringByAppendingPathComponent:@"/templates"];
        templatePath = [templatePath stringByAppendingPathComponent:filename];
        NSDictionary *form = [[NSDictionary alloc]initWithContentsOfFile:templatePath];
        detailViewController.theForm = form;
        
        
    }

}


@end
