//
// Created by Adilet Abylov on 11.07.13.
// Copyright (c) 2013 ___FULLUSERNAME___. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface Radio : NSObject
@property NSString *name;
@property NSString *imageURL;
@property NSString *serviceURL;

+(id)radioFromJSON:(id)json;
@end