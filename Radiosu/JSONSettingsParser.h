//
//  JSONSettingsParser.h
//  Radiosu
//
//  Created by Ivan Yuriev on 7/23/13.
//  Copyright (c) 2013 Ivan Yuriev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONSettingsParser : NSObject

-(NSArray*)parseJSON:(NSString*)jsonString;

@end
