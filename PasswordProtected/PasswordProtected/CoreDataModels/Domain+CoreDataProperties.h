//
//  Domain+CoreDataProperties.h
//  PasswordProtected
//
//  Created by Ethan Hess on 8/8/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//
//

#import "Domain+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Domain (CoreDataProperties)

+ (NSFetchRequest<Domain *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Credential *> *credentials;

@end

@interface Domain (CoreDataGeneratedAccessors)

- (void)addCredentialsObject:(Credential *)value;
- (void)removeCredentialsObject:(Credential *)value;
- (void)addCredentials:(NSSet<Credential *> *)values;
- (void)removeCredentials:(NSSet<Credential *> *)values;

@end

NS_ASSUME_NONNULL_END
