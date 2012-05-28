//
//  PickerSelectionViewController.m
//  formidable
//
//  Created by Chris Tucci on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PickerSelectionViewController.h"

@interface PickerSelectionViewController ()

@end

@implementation PickerSelectionViewController
@synthesize picker;
@synthesize theItem;
@synthesize delegate;

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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setPicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - picker delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    NSString *theOptionsAsString = [theItem valueForKey:@"options"];
    NSArray *optionsArray = [theOptionsAsString componentsSeparatedByString:@","];
    return [optionsArray count];

}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *theOptionsAsString = [theItem valueForKey:@"options"];
    NSArray *optionsArray = [theOptionsAsString componentsSeparatedByString:@","];
    return [optionsArray objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
 
    NSString *theOptionsAsString = [theItem valueForKey:@"options"];
    NSMutableArray *optionsArray = [[theOptionsAsString componentsSeparatedByString:@","]mutableCopy];
    [theItem setValue:[optionsArray objectAtIndex:row] forKey:@"value"];
    [delegate pickerValueDidChange];
}

-(void)initalizeList {

}

@end
