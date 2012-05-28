//
//  FormDetailViewController.h
//  formidable
//
//  Created by Chris Tucci on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerSelectionViewController.h"

@interface FormDetailViewController : UITableViewController <UITextFieldDelegate, PickerViewDelegate>

@property (nonatomic, strong) NSDictionary *theForm;
@property (weak, nonatomic) IBOutlet UILabel *formTitle;
@property (nonatomic, strong) UITextField *currentTextField;


-(void)segmentedControlValueDidChange:(id)sender;
-(void)stepperValueDidChange:(id)sender;
-(IBAction)saveButtonPressed:(id)sender;

@end
