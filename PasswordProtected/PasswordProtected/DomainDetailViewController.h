//
//  DomainDetailViewController.h
//  PasswordProtected
//
//  Created by Ethan Hess on 8/13/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Domain+CoreDataProperties.h"
#import "Domain+CoreDataClass.h"

@interface DomainDetailViewController : UIViewController

- (void)updateWithDomain:(Domain *)domain;

@end
