//
//  SelectRowTypeViewController.h
//  formidable
//
//  Created by Chris Tucci on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddRowProtocol <NSObject>

-(void)addRowToSection:(int)section withType:(NSString *)type;

@end

@interface SelectRowTypeViewController : UITableViewController
@property (nonatomic, strong) UIPopoverController *popoverController;
@property (nonatomic, strong) id <AddRowProtocol> delegate;
@property (nonatomic, assign) int theSection;

@end
