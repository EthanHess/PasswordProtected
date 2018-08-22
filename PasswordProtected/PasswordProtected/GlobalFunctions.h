//
//  GlobalFunctions.h
//  PasswordProtected
//
//  Created by Ethan Hess on 8/13/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit; 

@interface GlobalFunctions : NSObject

+ (void)presentAddAlertWithTitle:(NSString *)title placeholder:(NSString *)placeholder firstActionTitle:(NSString *)firstAction andText:(NSString *)text fromVC:(UIViewController *)theVC andCompletion:(void (^)(NSString *textToAdd))textToAdd;


+ (void)presentAddCredentialAlertWithTitle:(NSString *)title placeholderOne:(NSString *)placeholderOne placeholderTwo:(NSString *)placeholderTwo firstActionTitle:(NSString *)firstAction andText:(NSString *)text fromVC:(UIViewController *)theVC andCompletion:(void (^)(NSString * _Nullable username, NSString * _Nullable password))handler;

@end
