//
// Created by Adilet Abylov on 11.07.13.
// Copyright (c) 2013 ___FULLUSERNAME___. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Radio.h"


@implementation Radio
{

}

@synthesize name = _name;
@synthesize imageURL = _imageURL;
@synthesize serviceURL = _serviceURL;

+ (id)radioFromJSON:(id)json
{
    Radio *radio = [Radio new];
    radio.name = [json objectForKey:@"title"];
    radio.serviceURL = [json objectForKey:@"url"];
    radio.imageURL = [json objectForKey:@"picUrl"];
    
    return radio;
}

@end