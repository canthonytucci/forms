//
//  EditNumericItemViewController.h
//  formidable
//
//  Created by Chris Tucci on 2/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditNumericItemProtocol<NSObject>

-(void)didChangeNumericItemAtIndexPath:(NSIndexPath *)indexPath withValue:(NSString *)value forKey:(NSString *)key;

@end

@interface EditNumericItemViewController : UITableViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *labelTextField;
@property (weak, nonatomic) IBOutlet UITextField *placeholderTextField;
@property (weak, nonatomic) IBOutlet UITextField *initialValueTextField;
@property (weak, nonatomic) IBOutlet UITextField *minimumValueTextField;
@property (weak, nonatomic) IBOutlet UITextField *maximumValueTextField;
@property (nonatomic, strong) NSMutableDictionary *theItem;
@property (nonatomic, strong) id <EditNumericItemProtocol> delegate;
@property (nonatomic, strong) NSIndexPath *indexPathForTheItem;

- (void)initializeValues;

@end

