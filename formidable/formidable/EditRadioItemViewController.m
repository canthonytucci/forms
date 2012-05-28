//
//  EditRadioItemViewController.m
//  formidable
//
//  Created by Chris Tucci on 2/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditRadioItemViewController.h"

@interface EditRadioItemViewController ()

@end

@implementation EditRadioItemViewController
@synthesize labelTextField = _labelTextField;
@synthesize optionATextField = _optionATextField;
@synthesize optionBTextField = _optionBTextField;
@synthesize theItem = _theItem;
@synthesize delegate = _delegate;
@synthesize indexPathForTheItem = _indexPathForTheItem;


- (void)initializeValues {
    //To change the template use AppCode | Preferences | File Templates.
   _labelTextField.text = [_theItem valueForKey:@"label"];
    _optionATextField.text = [_theItem valueForKey:@"optiona"];
    _optionBTextField.text = [_theItem valueForKey:@"optionb"];
}

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
    [self setOptionATextField:nil];
    [self setOptionBTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



//MARK: TextView Delegate Stuff

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    string = newString;
    if (textField == _labelTextField) {
        [_theItem setValue:newString forKey:@"label"];
        [_delegate didChangeRadioItemAtIndexPath:_indexPathForTheItem withValue:newString forKey:@"label"];
    } else if (textField == _optionATextField) {
        [_theItem setValue:newString forKey:@"optiona"];
        [_delegate didChangeRadioItemAtIndexPath:_indexPathForTheItem withValue:newString forKey:@"optiona"];
    } else if (textField == _optionBTextField) {
        [_theItem setValue:newString forKey:@"optionb"];
        [_delegate didChangeRadioItemAtIndexPath:_indexPathForTheItem withValue:newString forKey:@"optionb"];

    }

    return YES;

}

@end
