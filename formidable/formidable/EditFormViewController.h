//
//  EditFormViewController.h
//  formidable
//
//  Created by Chris Tucci on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddRowViewController.h"
@interface EditFormViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, AddRowProtocol>

@property (nonatomic, strong) NSMutableDictionary *theForm;
@property (weak, nonatomic) IBOutlet UITableView *theTableView;
@property (weak, nonatomic) IBOutlet UILabel *formTitle;

-(void)refreshFormTitle;
@end
