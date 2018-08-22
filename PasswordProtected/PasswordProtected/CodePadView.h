//
//  CodePadView.h
//  PasswordProtected
//
//  Created by Ethan Hess on 8/8/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CodePadDelegate <NSObject>

@required
- (void)codeIsValid;
@end

@interface CodePadView : UIView

@property (nonatomic) BOOL initialLoad;
@property (weak, nonatomic) id <CodePadDelegate> delegate;

@end
