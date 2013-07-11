//
// Created by Adilet Abylov on 11.07.13.
// Copyright (c) 2013 ___FULLUSERNAME___. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface RadiosListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property IBOutlet UITableView *tableView;
@property IBOutlet UIButton *playButton;
@property IBOutlet UINavigationBar *bar;

-(IBAction)didTouchPlayButton:(id)sender;
@end