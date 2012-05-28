//
//  EditListItemViewController.h
//  formidable
//
//  Created by Chris Tucci on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditListItemProtocol <NSObject>

-(void)didChangeListItemAtIndexPath:(NSIndexPath *)indexPath withValue:(NSString *)value forKey:(NSString *)key;

@end

@interface EditListItemViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, strong) NSMutableDictionary *theItem;
@property (nonatomic, strong) id <EditListItemProtocol> delegate;
@property (nonatomic, strong) NSIndexPath *itemIndexPath;
-(IBAction)deleteChoiceAtRow:(id)sender;

@end
