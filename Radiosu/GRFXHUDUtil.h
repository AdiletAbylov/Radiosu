//
//  GRFXHUDUtil.h
//  Baraktar
//
//  Created by Adilet Abylov on 31.03.13.
//  Copyright (c) 2013 Adilet Abylov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRFXHUDUtil : NSObject
+(id)sharedInstance;
-(void)displayLoadingHUDForView:(UIView*)view withTitle:(NSString*)title;
-(void)displayErrorHUDForView:(UIView*)view withTitle:(NSString*)title;
-(void)hideHUDForView:(UIView *)view;
-(void)hideHUDForView:(UIView *)view afterDelay:(NSTimeInterval)delay;
-(void)displaySuccessHUDForView:(UIView*)view withTitile:(NSString*)title;
@end
