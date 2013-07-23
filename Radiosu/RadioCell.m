//
// Created by Adilet Abylov on 11.07.13.
// Copyright (c) 2013 ___FULLUSERNAME___. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "RadioCell.h"
#import "Radio.h"
#import "UIImageView+AFNetworking.h"

@implementation RadioCell
{

}
@synthesize nameLabel = _nameLabel;
@synthesize iconView = _iconView;

- (void)fillWithRadio:(Radio *)radio
{
    _nameLabel.text = radio.title;
    [_iconView setImageWithURL:[[NSURL alloc] initWithString:radio.imageURL]];
}
@end