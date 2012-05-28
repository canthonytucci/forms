//
//  FormSettingsViewController.h
//  formidable
//
//  Created by Chris Tucci on 2/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FormSettingsProtocol <NSObject>
    -(void)didModifyFormSettings:(id)form;

@end

@interface FormSettingsViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, strong) NSMutableDictionary *form;
@property (nonatomic, strong) id <FormSettingsProtocol> delegate;
@property (weak, nonatomic) IBOutlet UITextField *formTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *formCreatorTextField;
@property (weak, nonatomic) IBOutlet UITextField *formCreatorURLTextField;
@property (weak, nonatomic) IBOutlet UITextField *destinationURLTextField;
-(void)setInitialTextFieldValues;
@property (weak, nonatomic) IBOutlet UITableViewCell *formTitleCell;


@end
