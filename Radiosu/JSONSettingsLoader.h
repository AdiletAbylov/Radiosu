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
-(void)dataLoadError:(NSError *)error;
@end


@interface JSONSettingsLoader : NSObject

-(void)start;
@property (weak) id<HttpDataLoader> delegate;

@end
