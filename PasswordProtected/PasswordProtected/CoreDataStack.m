//
//  CoreDataStack.m
//  PasswordProtected
//
//  Created by Ethan Hess on 8/13/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

#import "CoreDataStack.h"

@interface CoreDataStack () //May not need now
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@end

@implementation CoreDataStack

+ (CoreDataStack *)sharedInstance {
    static CoreDataStack *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [CoreDataStack new];
    });
    
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        [self mocSetup]; //Managed object context
    }
    return self;
}

- (NSURL *)storeURL {
    NSURL* documentsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL];
    return [documentsDirectory URLByAppendingPathComponent:@"db.sqlite"];
}

- (NSURL*)modelURL {
    return [[NSBundle mainBundle]URLForResource:@"PasswordProtected" withExtension:@"momd"];
    //return [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
}

- (NSManagedObjectModel*)managedObjectModel {
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:self.modelURL];
}

- (void)mocSetup {
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    NSError* error;
    [self.managedObjectContext.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                                       configuration:nil
                                                                                 URL:self.storeURL
                                                                             options:nil
                                                                               error:&error];
    if (error) {
        NSLog(@"error: %@", error);
    }
    
    self.managedObjectContext.undoManager = [[NSUndoManager alloc] init];
}


@end
