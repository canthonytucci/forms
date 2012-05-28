//
//  DownloadFormViewController.h
//  formidable
//
//  Created by Chris Tucci on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DownloadFormProtocol <NSObject>

-(void)connectionDidFinishWithError;
-(void)connectionDidFinishSuccessfully;

@end

@interface DownloadFormViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (nonatomic, strong) id <DownloadFormProtocol> delegate;

- (IBAction)downloadButtonPressed:(id)sender;

@end
