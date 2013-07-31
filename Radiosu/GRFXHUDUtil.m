//
//  GRFXHUDUtil.m
//  Baraktar
//
//  Created by Adilet Abylov on 31.03.13.
//  Copyright (c) 2013 Adilet Abylov. All rights reserved.
//

#import "GRFXHUDUtil.h"
#import <MBProgressHUD.h>
@implementation GRFXHUDUtil

+(id)sharedInstance
{
    static GRFXHUDUtil *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[GRFXHUDUtil alloc]init];
    });
    return __sharedInstance;
}

-(void)displayLoadingHUDForView:(UIView *)view withTitle:(NSString *)title
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = title;
}

-(void)displayErrorHUDForView:(UIView *)view withTitle:(NSString *)title
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"failedIcon"]];
    hud.labelText = title;
    hud.mode = MBProgressHUDModeCustomView;
}

-(void)displaySuccessHUDForView:(UIView*)view withTitile:(NSString*)title
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SuccessCheckmark"]];
    hud.labelText = title;
    hud.mode = MBProgressHUDModeCustomView;
}

-(void)hideHUDForView:(UIView *)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}

-(void)hideHUDForView:(UIView *)view afterDelay:(NSTimeInterval)delay
{
    [self performSelector:@selector(hideHUDForView:) withObject:view afterDelay:delay];
}



@end
