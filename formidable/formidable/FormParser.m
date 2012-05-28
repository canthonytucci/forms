//
//  FormParser.m
//  formidable
//
//  Created by Chris Tucci on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FormParser.h"

@implementation FormParser
@synthesize theForm = _theForm;
@synthesize lastObject = _lastObject;


-(NSDictionary *)parseData:(NSData *)theData
{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:theData];
    parser.delegate = self;
    [parser parse];

    return _theForm;
}

-(void)parserDidStartDocument:(NSXMLParser *)parser {


    _theForm = [[NSMutableDictionary alloc]init];
    NSMutableArray *theSections = [[NSMutableArray alloc] init];
    [_theForm setValue:theSections forKey:@"sections"];
}


-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {

        
    id current;
    
        if ([elementName isEqualToString:@"form"]) {
            
            _lastObject = _theForm;
            current = _theForm;

        } else if ([elementName isEqualToString:@"section"]) {

            NSMutableDictionary *aSection = [[NSMutableDictionary alloc] init];
            NSMutableArray *theItems = [[NSMutableArray alloc] init];
            [aSection setValue:theItems forKey:@"items"];
            [[_theForm valueForKey:@"sections"]addObject:aSection];
            _lastObject = aSection;
            current = aSection;

        } else if ([elementName isEqualToString:@"text_item"]) {

            NSMutableDictionary *aTextItem = [[NSMutableDictionary alloc] init];
            [aTextItem setValue:@"text_item" forKey:@"type"];
            [[_lastObject valueForKey:@"items"] addObject:aTextItem];
            current = aTextItem;

        } else if ([elementName isEqualToString:@"static_item"]){

            NSMutableDictionary *aStaticItem = [[NSMutableDictionary alloc] init];
            [aStaticItem setValue:@"static_item" forKey:@"type"];
            [[_lastObject valueForKey:@"items"] addObject:aStaticItem];
            current = aStaticItem;

       } else if ([elementName isEqualToString:@"numeric_item"]) {

             NSMutableDictionary *aNumericItem = [[NSMutableDictionary alloc] init];
            [aNumericItem setValue:@"numeric_item" forKey:@"type"];
            [[_lastObject valueForKey:@"items"] addObject:aNumericItem];
            current = aNumericItem;

        } else if ([elementName isEqualToString:@"radio_item"]) {

             NSMutableDictionary *aRadioItem = [[NSMutableDictionary alloc] init];
            [aRadioItem setValue:@"radio_item" forKey:@"type"];
            [[_lastObject valueForKey:@"items"] addObject:aRadioItem];
            current = aRadioItem;

        } else if ([elementName isEqualToString:@"incremental_item"]){

             NSMutableDictionary *anIncrementalItem= [[NSMutableDictionary alloc] init];
            [anIncrementalItem setValue:@"incremental_item" forKey:@"type"];
            [[_lastObject valueForKey:@"items"] addObject:anIncrementalItem];
            current = anIncrementalItem;

        } else if ([elementName isEqualToString:@"list_item"])
        {
            NSMutableDictionary *aListItem = [[NSMutableDictionary  alloc]init];
            [aListItem  setValue:@"list_item" forKey:@"type"];
            [[_lastObject valueForKey:@"items"]addObject:aListItem];
            current = aListItem;
        }

        for(id key in [attributeDict allKeys]){

            [current setValue:[attributeDict valueForKey:key] forKey: key];

        }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {

}

-(void )parserDidEndDocument:(NSXMLParser *)parser {
    

}

@end
