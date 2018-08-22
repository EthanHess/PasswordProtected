//
//  Domain+CoreDataProperties.m
//  PasswordProtected
//
//  Created by Ethan Hess on 8/8/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//
//

#import "Domain+CoreDataProperties.h"

@implementation Domain (CoreDataProperties)

+ (NSFetchRequest<Domain *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Domain"];
}

@dynamic name;
@dynamic credentials;

@end
