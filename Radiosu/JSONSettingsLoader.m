//
//  JSONSettingsLoader.m
//  Radiosu
//
//  Created by Ivan Yuriev on 7/23/13.
//  Copyright (c) 2013 Ivan Yuriev. All rights reserved.
//

#import "JSONSettingsLoader.h"
#import "AFNetworking.h"

@implementation JSONSettingsLoader
NSString* const settingsUrl = @"https://dl.dropbox.com/sh/x2d7k9tvtywliio/DXTd4VjaMd/settings.strings";

-(void)start
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:settingsUrl]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            [delegate performSelector:@selector(dataLoadComplete:) withObject:operation.responseString ];
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            NSLog(@"%@", error.description);
            [delegate dataLoadError:error];
        }
     ];
    
    [operation start];
}

@synthesize delegate;

@end
