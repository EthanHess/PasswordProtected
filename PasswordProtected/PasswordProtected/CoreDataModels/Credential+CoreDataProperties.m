//
//  Credential+CoreDataProperties.m
//  PasswordProtected
//
//  Created by Ethan Hess on 8/8/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//
//

#import "Credential+CoreDataProperties.h"

@implementation Credential (CoreDataProperties)

+ (NSFetchRequest<Credential *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Credential"];
}

@dynamic username;
@dynamic password;
@dynamic domain;

@end
