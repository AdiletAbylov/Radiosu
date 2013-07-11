//
//  GRFXAppDelegate.h
//  Radiosu
//
//  Created by Adilet Abylov on 11.07.13.
//  Copyright (c) 2013 Adilet Abylov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>


@interface GRFXAppDelegate : UIResponder <UIApplicationDelegate, AVAudioSessionDelegate>

@property (strong, nonatomic) UIWindow *window;

@end