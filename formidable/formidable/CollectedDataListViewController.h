//
//  CollectedDataListViewController.h
//  formidable
//
//  Created by Chris Tucci on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectedDataListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *theTableView;
@property (nonatomic, strong) NSArray *theForms;
@end
