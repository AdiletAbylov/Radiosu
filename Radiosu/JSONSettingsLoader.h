//
//  JSONSettingsLoader.h
//  Radiosu
//
//  Created by Ivan Yuriev on 7/23/13.
//  Copyright (c) 2013 Ivan Yuriev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HttpDataLoader <NSObject>

-(void)dataLoadComplete: (NSString*)jsonString;

@end


@interface JSONSettingsLoader : NSObject

-(void)start;
@property (strong) id<HttpDataLoader> delegate;

@end
