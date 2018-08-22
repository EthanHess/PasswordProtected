//
//  CoreDataController.m
//  PasswordProtected
//
//  Created by Ethan Hess on 8/13/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

#import "CoreDataController.h"
#import "CoreDataStack.h"

@implementation CoreDataController

+ (CoreDataController *)sharedInstance {
    static CoreDataController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [CoreDataController new];
    });
    
    return sharedInstance;
    
}

- (void)addDomainWithName:(NSString *)name {
    Domain *domain = [NSEntityDescription insertNewObjectForEntityForName:@"Domain" inManagedObjectContext:[CoreDataStack sharedInstance].managedObjectContext];
    domain.name = name;
    NSError *error; //?
    [[[CoreDataStack sharedInstance]managedObjectContext]save:&error];
}

- (void)removeDomain:(Domain *)domain {
    NSError *error;
    [domain.managedObjectContext deleteObject:domain];
    [[[CoreDataStack sharedInstance]managedObjectContext]save:&error];
}

- (NSArray *)domains {
    NSFetchRequest *theRequest = [NSFetchRequest fetchRequestWithEntityName:@"Domain"];
    NSError *error;
    NSArray *array = [[[CoreDataStack sharedInstance]managedObjectContext]executeFetchRequest:theRequest error:&error];
    return array;
}

- (NSDictionary *)indexedDomains {
    
    NSMutableDictionary *iDomains = [[NSMutableDictionary alloc]init];
    
    for (Domain *domain in self.domains) {
        
        NSString *sortString = domain.name;
        NSString *sortLetter = [sortString substringToIndex:1];
        
        BOOL foundKey = NO;
        
        for (NSString *key in [iDomains allKeys]) {
            if ([key isEqualToString:sortLetter]) {
                foundKey = YES;
            }
        }
        
        NSMutableArray *valueArray;
        
        if (foundKey) {
            valueArray = [((NSArray *)iDomains[sortLetter]) mutableCopy];
        } else {
            valueArray = [[NSMutableArray alloc]init];
        }
        
        [valueArray addObject:domain];
        iDomains[sortLetter] = [valueArray copy];
    }
    
    return [iDomains copy];
}

@end
