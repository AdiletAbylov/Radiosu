//
// Created by Adilet Abylov on 11.07.13.
// Copyright (c) 2013 ___FULLUSERNAME___. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <AVFoundation/AVFoundation.h>
#import "RadiosListViewController.h"
#import "RadioCell.h"
#import "Radio.h"
#import "AVFoundation/AVPlayer.h"
#import "JSONSettingsParser.h"
#import "GRFXHUDUtil.h"


#pragma mark Audio session callbacks_______________________
void audioRouteChangeListenerCallback(void *inUserData, AudioSessionPropertyID inPropertyID, UInt32 inPropertyValueSize, const void *inPropertyValue)
{
    // ensure that this callback was invoked for a route change
    if (inPropertyID != kAudioSessionProperty_AudioRouteChange) return;

    RadiosListViewController *controller = (__bridge RadiosListViewController *) inUserData;
    CFDictionaryRef routeChangeDictionary = inPropertyValue;
    CFNumberRef routeChangeReasonRef = CFDictionaryGetValue(routeChangeDictionary, CFSTR (kAudioSession_AudioRouteChangeKey_Reason));

    SInt32 routeChangeReason;

    CFNumberGetValue(routeChangeReasonRef, kCFNumberSInt32Type, &routeChangeReason);

    CFStringRef oldRouteRef = CFDictionaryGetValue(routeChangeDictionary, CFSTR (kAudioSession_AudioRouteChangeKey_OldRoute));

    NSString *oldRouteString = (__bridge NSString *) oldRouteRef;
    if (routeChangeReason == kAudioSessionRouteChangeReason_NewDeviceAvailable)
    {
        //do nothing
    }

    if (routeChangeReason == kAudioSessionRouteChangeReason_OldDeviceUnavailable)
    {

        if ([controller isPlaying] && ([oldRouteString isEqualToString:@"Headphone"] || [oldRouteString isEqualToString:@"LineOut"]))
        {
            [controller pause];
        }
    }
}

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
    AudioSessionAddPropertyListener(kAudioSessionProperty_AudioRouteChange, audioRouteChangeListenerCallback, (__bridge  void*)self);
}

- (void)initRadios
{
    JSONSettingsLoader *loader = [[JSONSettingsLoader alloc] init];
    loader.delegate = self;
    [[GRFXHUDUtil sharedInstance] displayLoadingHUDForView:self.view withTitle:nil];
    [loader start];
}

- (void)dataLoadComplete:(NSString *)jsonString
{
    JSONSettingsParser *parser = [[JSONSettingsParser alloc] init];
    _radios = [parser parseJSON:jsonString];
    [[GRFXHUDUtil sharedInstance] hideHUDForView:self.view];

    [_tableView reloadData];
}

- (void)dataLoadError:(NSError *)error
{
    [[GRFXHUDUtil sharedInstance] hideHUDForView:self.view];
    [[GRFXHUDUtil sharedInstance] displayErrorHUDForView:self.view withTitle:@"Ошибка сервиса"];
    [[GRFXHUDUtil sharedInstance] hideHUDForView:self.view afterDelay:2];
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
    [self isPlaying] ? [self pause] : [self play];
}

- (void)play
{
    [_player play];
    [self togglePlayButton];
}

- (void)pause
{
    [_player pause];
    [self togglePlayButton];
}
@end