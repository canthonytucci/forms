//
//  AddRowViewController.h
//  formidable
//
//  Created by Chris Tucci on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface AddRowViewController : UITableViewController


@property (nonatomic, strong) UIPopoverController *popoverController;
@property (nonatomic, strong) NSArray *theSections;
@property (nonatomic, strong) id  delegate;

@end
