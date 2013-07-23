//
//  JSONParser_Tests.m
//  Radiosu
//
//  Created by Ivan Yuriev on 7/23/13.
//  Copyright (c) 2013 Ivan Yuriev. All rights reserved.
//

#import "JSONParser_Tests.h"
#import "JSONSettingsParser.h"
#import "Radio.h"

@implementation JSONParser_Tests
{
    JSONSettingsParser *_parser;
    NSString *_testJsonString;
}

- (void)setUp
{
    [super setUp];
    _parser = [[JSONSettingsParser alloc] init];
    _testJsonString = [[NSString alloc] initWithFormat:@"{ \"radiolist\": [ {\"title\": \"radio1\"}, { \"title\": \"radio2\" } ] }"];
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    NSArray *array = [_parser parseJSON:_testJsonString];
    
    STAssertEquals([array count], (NSUInteger)2, [NSString stringWithFormat:@"array count %i equals 2", [array count]]);
    
    Radio* item = (Radio*)[array objectAtIndex:0];
    STAssertTrue([item.title isEqualToString: @"radio1"], [NSString stringWithFormat:@"first radio title is 'radio1'"]);
    
    item = (Radio*)[array objectAtIndex:1];
    STAssertTrue([item.title isEqualToString: @"radio2"], [NSString stringWithFormat:@"first radio title is 'radio2'"]);
}

@end
