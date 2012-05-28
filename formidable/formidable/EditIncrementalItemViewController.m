//
//  EditIncrementalItemViewController.m
//  formidable
//
//  Created by Chris Tucci on 2/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditIncrementalItemViewController.h"

@interface EditIncrementalItemViewController ()

@end

@implementation EditIncrementalItemViewController
@synthesize labelTextField = _labelTextField;
@synthesize placeholderTextField = _placeholderTextField;
@synthesize initialValueTextField = _initialValueTextField;
@synthesize maximumValueTextField = _maximumValueTextField;
@synthesize minimumValueTextField = _minimumValueTextField;
@synthesize theItem = _theItem;
@synthesize delegate = _delegate;
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
    [self setPlaceholderTextField:nil];
    [self setInitialValueTextField:nil];
    [self setMaximumValueTextField:nil];
    [self setMinimumValueTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)initializeValues
{
    _labelTextField.text = [_theItem valueForKey:@"label"];
    _placeholderTextField.text = [_theItem valueForKey:@"placeholder"];
    _initialValueTextField.text = [_theItem valueForKey:@"value"];
    _maximumValueTextField.text = [_theItem valueForKey:@"max"];
    _minimumValueTextField.text = [_theItem valueForKey:@"min"];

}

//MARK: TextView Delegate Stuff

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    string = newString;
    if (textField == _labelTextField) {
        [_theItem setValue:newString forKey:@"label"];
        [_delegate didChangeIncrementalItemAtIndexPath:_indexPathForTheItem withValue:newString forKey:@"label"];
    } else if (textField == _placeholderTextField) {
        [_theItem setValue:newString forKey:@"placeholder"];
        [_delegate didChangeIncrementalItemAtIndexPath:_indexPathForTheItem withValue:newString forKey:@"placeholder"];
    } else if (textField == _initialValueTextField) {
        [_theItem setValue:newString forKey:@"value"];
        [_delegate didChangeIncrementalItemAtIndexPath:_indexPathForTheItem withValue:newString forKey:@"value"];
    } else if (textField == _maximumValueTextField) {
        [_theItem setValue:newString forKey:@"max"];
        [_delegate didChangeIncrementalItemAtIndexPath:_indexPathForTheItem withValue:newString forKey:@"max"];
    }
    return YES;

}

@end
