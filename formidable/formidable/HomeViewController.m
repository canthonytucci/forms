//
//  ViewController.m
//  formidable
//
//  Created by Chris Tucci on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "FormsListViewController.h"
#import "FormParser.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"testForm" ofType:@"txt"];
    NSData *myData = [NSData dataWithContentsOfFile:filePath];
    
    if (myData) {
        FormParser *parser = [[FormParser alloc]init];
        NSDictionary *parsedData = [parser parseData:myData];
        NSLog(@"Parsed Data\n%@", parsedData);
    
    
        NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *templates_directory = [documentsDirectoryPath stringByAppendingPathComponent:@"/templates"];
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:templates_directory withIntermediateDirectories:NO attributes:nil error:&error]; 
        

        NSString *collected_directory = [documentsDirectoryPath stringByAppendingPathComponent:@"/collected"];
        [[NSFileManager defaultManager] createDirectoryAtPath:collected_directory withIntermediateDirectories:NO attributes:nil error:&error];
        
        //Create folder

        NSString *fileName = [NSString stringWithFormat:@"%@.plist", [parsedData valueForKey:@"title"]];
        NSString *fullPath = [templates_directory
                              stringByAppendingPathComponent:fileName];
        [parsedData writeToFile:fullPath atomically:NO];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

@end
