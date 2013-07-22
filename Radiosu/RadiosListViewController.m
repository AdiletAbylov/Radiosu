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
#import "JSONKit.h"

@implementation RadiosListViewController
{
    AVPlayer *_player;
    NSMutableArray *_radios;
    NSInteger _selectedRadioIndex;
}

@synthesize tableView = _tableView;
@synthesize playButton = _playButton;
@synthesize bar = _bar;

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
    _radios = [[NSMutableArray alloc] init];
    
    NSString *jsonUrlString = @"https://dl.dropbox.com/sh/x2d7k9tvtywliio/DXTd4VjaMd/settings.strings";
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:jsonUrlString]];    
    NSString *jsonContent = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];    
    NSDictionary *rootJson = [jsonContent objectFromJSONString];    
    NSLog(@"%@", [rootJson objectForKey:@"radiolist"]);
    
    for(NSDictionary *item in [rootJson objectForKey:@"radiolist"])
    {
        NSLog(@"%@", [item objectForKey:@"title"]);
        [_radios addObject:[Radio radioFromJSON:item]];
    }    
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

    if(_selectedRadioIndex != indexPath.row)
    {
        Radio *radio = [_radios objectAtIndex:indexPath.row];
        [self playRadioURL:[[NSURL alloc] initWithString:radio.serviceURL]];
        [self togglePlayButton];
        _playButton.enabled = YES;
        _selectedRadioIndex = indexPath.row;
    }
}

-(void)playRadioURL:(NSURL *)url
{
    _player = [AVPlayer playerWithURL:url];
    [_player play];
}

-(void)togglePlayButton
{
    [_playButton setTitle:[self titleForButton] forState:UIControlStateNormal];
}

-(NSString *)titleForButton
{
    return [self isPlaying] ? @"Pause" : @"Play";
}

-(BOOL)isPlaying
{
    return _player.rate == 1.0;
}


- (IBAction)didTouchPlayButton:(id)sender
{
    if([self isPlaying])
    {
        [_player pause];
    } else
    {
        [_player play];
    }
    [self togglePlayButton];
}

@end