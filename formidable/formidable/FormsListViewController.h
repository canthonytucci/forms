//
//  FormsListViewController.h
//  formidable
//
//  Created by Chris Tucci on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormsListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *theTableView;
@property (nonatomic, strong) NSArray *theForms;

@end
