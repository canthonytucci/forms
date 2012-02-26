//
//  CreateEditListViewController.h
//  formidable
//
//  Created by Chris Tucci on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateEditListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *theForms;
@property (weak, nonatomic) IBOutlet UITableView *theTableView;

@end
