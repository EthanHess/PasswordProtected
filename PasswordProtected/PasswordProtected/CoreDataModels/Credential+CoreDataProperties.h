//
//  Credential+CoreDataProperties.h
//  PasswordProtected
//
//  Created by Ethan Hess on 8/8/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//
//

#import "Credential+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Credential (CoreDataProperties)

+ (NSFetchRequest<Credential *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *username;
@property (nullable, nonatomic, copy) NSString *password;
@property (nullable, nonatomic, retain) Domain *domain;

@end

NS_ASSUME_NONNULL_END
