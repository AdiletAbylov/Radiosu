//
// Created by Adilet Abylov on 11.07.13.
// Copyright (c) 2013 ___FULLUSERNAME___. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "JSONSettingsLoader.h"

@interface RadiosListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, HttpDataLoader>
@property IBOutlet UITableView *tableView;
@property IBOutlet UIButton *playButton;
@property IBOutlet UINavigationBar *bar;
@property IBOutlet UILabel *titleLabel;

- (IBAction)didTouchPlayButton:(id)sender;
@end