//
// Created by Adilet Abylov on 11.07.13.
// Copyright (c) 2013 ___FULLUSERNAME___. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class Radio;


@interface RadioCell : UITableViewCell
@property IBOutlet UILabel *nameLabel;
@property IBOutlet UIImageView *iconView;

-(void)fillWithRadio:(Radio *)radio;
@end