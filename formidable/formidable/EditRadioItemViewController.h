//
//  EditRadioItemViewController.h
//  formidable
//
//  Created by Chris Tucci on 2/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditRadioItemProtocol<NSObject>

-(void)didChangeRadioItemAtIndexPath:(NSIndexPath *)indexPath withValue:(NSString *)value forKey:(NSString *)key;

@end

@interface EditRadioItemViewController : UITableViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *labelTextField;
@property (weak, nonatomic) IBOutlet UITextField *optionATextField;
@property (weak, nonatomic) IBOutlet UITextField *optionBTextField;
@property (nonatomic, strong) NSMutableDictionary *theItem;
@property (nonatomic, strong) id <EditRadioItemProtocol> delegate;
@property (nonatomic, strong) NSIndexPath *indexPathForTheItem;
- (void)initializeValues;

@end
