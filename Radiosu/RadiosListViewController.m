//
// Created by Adilet Abylov on 11.07.13.
// Copyright (c) 2013 ___FULLUSERNAME___. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "RadiosListViewController.h"
#import "RadioCell.h"
#import "Radio.h"
#import "AVFoundation/AVPlayer.h"
#import "JSONSettingsParser.h"
#import "MBProgressHUD.h"

@implementation RadiosListViewController
{
    AVPlayer *_player;
    NSArray *_radios;
    NSInteger _selectedRadioIndex;
}

@synthesize tableView = _tableView;
@synthesize playButton = _playButton;
@synthesize bar = _bar;
@synthesize titleLabel = _titleLabel;

- (void)viewDidLoad
{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self initRadios];
    _playButton.enabled = NO;
    _selectedRadioIndex = -1;
    [super viewDidLoad];
}

- (void)initRadios
{
    JSONSettingsLoader *loader = [[JSONSettingsLoader alloc] init];
    loader.delegate = self;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [loader start];
}

- (void)dataLoadComplete:(NSString *)jsonString
{
    JSONSettingsParser *parser = [[JSONSettingsParser alloc] init];
    _radios = [parser parseJSON:jsonString];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [_tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"RadioCell";
    RadioCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    Radio *radio = [_radios objectAtIndex:indexPath.row];
    [cell fillWithRadio:radio];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _radios.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (_selectedRadioIndex != indexPath.row)
    {
        Radio *radio = [_radios objectAtIndex:indexPath.row];
        [self playRadioURL:[[NSURL alloc] initWithString:radio.serviceURL]];
        [self togglePlayButton];
        _playButton.enabled = YES;
        _selectedRadioIndex = indexPath.row;
        [self updateTopBarTitle];
    }
}

- (void)playRadioURL:(NSURL *)url
{
    _player = [AVPlayer playerWithURL:url];
    [_player play];
}

- (void)togglePlayButton
{
    [_playButton setTitle:[self titleForButton] forState:UIControlStateNormal];
}

- (NSString *)titleForButton
{
    return [self isPlaying] ? @"Pause" : @"Play";
}

- (BOOL)isPlaying
{
    return _player.rate == 1.0;
}

- (void)updateTopBarTitle
{
    Radio *radio = [_radios objectAtIndex:_selectedRadioIndex];
    _titleLabel.text = radio.title;
}

- (IBAction)didTouchPlayButton:(id)sender
{
    if ([self isPlaying])
    {
        [_player pause];
    } else
    {
        [_player play];
    }
    [self togglePlayButton];
}

@end