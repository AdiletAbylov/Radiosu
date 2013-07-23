//
//  JSONSettingsParser.m
//  Radiosu
//
//  Created by Ivan Yuriev on 7/23/13.
//  Copyright (c) 2013 Ivan Yuriev. All rights reserved.
//

#import "JSONSettingsParser.h"
#import "Radio.h"

@implementation JSONSettingsParser

-(NSArray*)parseJSON:(NSString*)jsonString{
    
    NSMutableArray *_radios = [[NSMutableArray alloc] init];
    
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error;
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];

    if(error==nil)
    {
        for(NSDictionary *item in [jsonObjects objectForKey:@"radiolist"])
        {
            [_radios addObject:[Radio radioFromJSON:item]];
        }
    }
    else
    {
        NSLog(@"Error occured while parsing settings: %@", error.description);
    }
    
    return _radios;
}

@end
