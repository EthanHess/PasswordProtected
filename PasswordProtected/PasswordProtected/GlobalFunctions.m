//
//  GlobalFunctions.m
//  PasswordProtected
//
//  Created by Ethan Hess on 8/13/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

#import "GlobalFunctions.h"

@implementation GlobalFunctions

//Domain

+ (void)presentAddAlertWithTitle:(NSString *)title placeholder:(NSString *)placeholder firstActionTitle:(NSString *)firstAction andText:(NSString *)text fromVC:(UIViewController *)theVC andCompletion:(void (^)(NSString *textToAdd))textToAdd {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = placeholder;
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:firstAction style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *textField = [[alert textFields] firstObject];
        textToAdd(textField.text != nil ? textField.text : @"");
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        textToAdd(@"");
    }]];
    
    [theVC presentViewController:alert animated:YES completion:nil];
}

//Creds

+ (void)presentAddCredentialAlertWithTitle:(NSString *)title placeholderOne:(NSString *)placeholderOne placeholderTwo:(NSString *)placeholderTwo firstActionTitle:(NSString *)firstAction andText:(NSString *)text fromVC:(UIViewController *)theVC andCompletion:(void (^)(NSString * _Nullable username, NSString * _Nullable password))handler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = placeholderOne;
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = placeholderTwo;
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:firstAction style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *textField = [[alert textFields] firstObject];
        UITextField *fieldTwo = [alert textFields][1];
        NSString *username = textField.text != nil ? textField.text : @"";
        NSString *password = fieldTwo.text != nil ? fieldTwo.text : @"";
        handler(username, password);
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        handler(nil, nil);
    }]];
    
    [theVC presentViewController:alert animated:YES completion:nil];
}

@end
