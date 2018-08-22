//
//  Credential+CoreDataClass.h
//  PasswordProtected
//
//  Created by Ethan Hess on 8/8/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Domain;

NS_ASSUME_NONNULL_BEGIN

@interface Credential : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Credential+CoreDataProperties.h"
