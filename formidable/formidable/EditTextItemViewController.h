//
//  EditTextItemViewController.h
//  formidable
//
//  Created by Chris Tucci on 2/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EditTextItemProtocol <NSObject>

-(void)didChangeTextItemAtIndexPath:(NSIndexPath *)indexPath withValue:(NSString *)value forKey:(NSString *)key;

@end

@interface EditTextItemViewController : UITableViewController <UITextFieldDelegate>
@property (nonatomic, strong) NSMutableDictionary *theItem;
@property (nonatomic, strong) id <EditTextItemProtocol> delegate;
@property (nonatomic, strong) NSIndexPath *indexPathForTheItem;
@property (nonatomic, strong) IBOutlet UITextField *labelTextField;
@property (nonatomic, strong) IBOutlet UITextField *placeholderTextField;
@property (nonatomic, strong) IBOutlet UITextField *initialValueTextField;

- (void)initializeTextFieldValues;

@end
