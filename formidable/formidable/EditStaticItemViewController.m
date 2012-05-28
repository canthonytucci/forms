//
//  EditStaticItemViewController.m
//  formidable
//
//  Created by Chris Tucci on 2/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditStaticItemViewController.h"

@interface EditStaticItemViewController ()

@end

@implementation EditStaticItemViewController
@synthesize labelTextField = _labelTextField;
@synthesize delegate = _delegate;
@synthesize theItem = _theItem;
@synthesize indexPathForTheItem = _indexPathForTheItem;



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
    [self setLabelTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)initalizeValue {
    //To change the template use AppCode | Preferences | File Templates.
    _labelTextField.text
    = [_theItem valueForKey:@"label"];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    string = newString;
    if (textField == _labelTextField) {
        [_theItem setValue:newString forKey:@"label"];
        [_delegate didChangeStaticItemAtIndexPath:_indexPathForTheItem withValue:newString forKey:@"label"];
    }

    return YES;
}

@end
