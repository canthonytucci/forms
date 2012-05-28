//
//  EditFormViewController.h
//  formidable
//
//  Created by Chris Tucci on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddRowViewController.h"
#import "AddSectionViewController.h"
#import "FormSettingsViewController.h"
#import "EditTextItemViewController.h"
#import "EditStaticItemViewController.h"
#import "EditIncrementalItemViewController.h"
#import "EditNumericItemViewController.h"
#import "EditRadioItemViewController.h"
#import "SelectRowTypeViewController.h"
#import "EditListItemViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>



@interface EditFormViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, AddRowProtocol, AddSectionProtocol, FormSettingsProtocol, EditTextItemProtocol, EditIncrementalItemProtocol, EditNumericItemProtocol, EditRadioItemProtocol, EditStaticItemProtocol, EditListItemProtocol, MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) NSMutableDictionary *theForm;
@property (weak, nonatomic) IBOutlet UITableView *theTableView;
@property (nonatomic, strong) NSString *pathToForm;
@property (weak, nonatomic) IBOutlet UILabel *formTitle;
@property (weak, nonatomic) IBOutlet UIView *popoverPresenterView;

-(void)refreshFormTitle;
-(IBAction)exportButtonPressed;
-(IBAction)saveButtonPressed;
-(IBAction)goBack;

@end
