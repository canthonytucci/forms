//
//  PickerSelectionViewController.h
//  formidable
//
//  Created by Chris Tucci on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickerViewDelegate <NSObject>

-(void)pickerValueDidChange;

@end

@interface PickerSelectionViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (nonatomic, strong) id theItem;
@property (nonatomic, strong) id <PickerViewDelegate> delegate;

-(void)initalizeList;



@end
