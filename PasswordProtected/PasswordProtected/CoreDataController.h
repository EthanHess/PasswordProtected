//
//  CoreDataController.h
//  PasswordProtected
//
//  Created by Ethan Hess on 8/13/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Domain+CoreDataClass.h"
#import "Domain+CoreDataProperties.h"
#import "Credential+CoreDataClass.h"
#import "Credential+CoreDataProperties.h"

@interface CoreDataController : NSObject

+ (CoreDataController *)sharedInstance;

//Domain functions
- (void)addDomainWithName:(NSString *)name;
- (void)removeDomain:(Domain *)domain;
- (NSArray *)domains;
- (NSDictionary *)indexedDomains;

//Credential functions (May be okay to do elsewhere)

@end
