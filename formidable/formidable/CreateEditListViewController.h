//
//  CreateEditListViewController.h
//  formidable
//
//  Created by Chris Tucci on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadFormViewController.h"

@interface CreateEditListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, DownloadFormProtocol>
@property (nonatomic, strong) NSArray *theForms;
@property (weak, nonatomic) IBOutlet UITableView *theTableView;
@property (nonatomic, strong) id popoverController;

@end
