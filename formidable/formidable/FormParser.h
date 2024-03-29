//
//  FormParser.h
//  formidable
//
//  Created by Chris Tucci on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormParser : NSObject <NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableDictionary *theForm;
@property (nonatomic, strong) id lastObject;

- (NSDictionary *)parseData:(NSData *)theData;


@end
