//
//  EditTextItemViewController.m
//  formidable
//
//  Created by Chris Tucci on 2/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditTextItemViewController.h"

@interface EditTextItemViewController ()

@end

@implementation EditTextItemViewController
@synthesize theItem = _theItem;
@synthesize delegate = _delegate;
@synthesize labelTextField = _labelTextField;
@synthesize placeholderTextField = _placeholderTextField;
@synthesize initialValueTextField = _initialValueTextField;
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



-(void)initializeTextFieldValues
{
    _labelTextField.text = [_theItem valueForKey:@"label"];
    _placeholderTextField.text = [_theItem valueForKey:@"placeholder"];
    _initialValueTextField.text = [_theItem valueForKey:@"value"];
}

//MARK: TextView Delegate Stuff

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    string = newString;
    if (textField == _labelTextField) {
        [_theItem setValue:newString forKey:@"label"];
        [_delegate didChangeTextItemAtIndexPath:_indexPathForTheItem withValue:newString forKey:@"label"];
    } else if (textField == _placeholderTextField) {
        [_theItem setValue:newString forKey:@"placeholder"];
        [_delegate didChangeTextItemAtIndexPath:_indexPathForTheItem withValue:newString forKey:@"placeholder"];
    } else if (textField == _initialValueTextField) {
        [_theItem setValue:newString forKey:@"value"];
        [_delegate didChangeTextItemAtIndexPath:_indexPathForTheItem withValue:newString forKey:@"value"];
    }
    return YES;

}

@end
