//
//  CollectedDataDetailViewController.h
//  formidable
//
//  Created by Chris Tucci on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface CollectedDataDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate>
@property (nonatomic, strong) NSDictionary *theForm;
@property (nonatomic, strong) NSString *pathToForm;
@property (nonatomic, strong) IBOutlet UITableView *theTableView;

- (IBAction)exportButtonPressed:(id)sender;


@end
