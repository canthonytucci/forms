//
//  AddSectionViewController.h
//  formidable
//
//  Created by Chris Tucci on 2/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddSectionProtocol <NSObject>

-(void)addSectionAtIndex:(int)section;

@end

@interface AddSectionViewController : UITableViewController

@property (nonatomic, strong) NSArray *theSections;
@property (nonatomic, strong) id <AddSectionProtocol> delegate;
@property (nonatomic, strong) UIPopoverController   *popoverController;


@end
