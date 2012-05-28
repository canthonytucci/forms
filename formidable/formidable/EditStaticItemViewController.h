//
//  EditStaticItemViewController.h
//  formidable
//
//  Created by Chris Tucci on 2/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditStaticItemProtocol<NSObject>

-(void)didChangeStaticItemAtIndexPath:(NSIndexPath *)indexPath withValue:(NSString *)value forKey:(NSString *)key;

@end

@interface EditStaticItemViewController : UITableViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *labelTextField;
@property (nonatomic, strong) NSMutableDictionary *theItem;
@property (nonatomic, strong) id <EditStaticItemProtocol> delegate;
@property (nonatomic, strong) NSIndexPath *indexPathForTheItem;

-(void)initalizeValue;


@end
