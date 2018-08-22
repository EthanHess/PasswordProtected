//
//  DomainListDataSource.m
//  PasswordProtected
//
//  Created by Ethan Hess on 8/13/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

#import "DomainListDataSource.h"
#import "CoreDataController.h"
#import "Domain+CoreDataClass.h"
#import "Domain+CoreDataProperties.h"

static NSString *cellID = @"cellID";

@implementation DomainListDataSource

- (void)registerTableView:(UITableView *)tableView {
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSDictionary *indexedDomains = [[CoreDataController sharedInstance]indexedDomains];
    
    NSArray *myKeys = [indexedDomains allKeys];
    NSString *key = myKeys[section];
    
    return [((NSArray *)[[CoreDataController sharedInstance]indexedDomains][key]) count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    NSString *key = [[[CoreDataController sharedInstance]indexedDomains] allKeys][indexPath.section];
    
    Domain *domain = ((NSArray *)[[CoreDataController sharedInstance]indexedDomains][key])[indexPath.row];
    
    cell.textLabel.text = domain.name;
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *allKeys = [[[CoreDataController sharedInstance] indexedDomains]allKeys];
    NSArray *sortedStrings = [allKeys sortedArrayUsingSelector:@selector(compare:)];
    
    return sortedStrings[section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSArray *teams = [[[CoreDataController sharedInstance]indexedDomains]allKeys];
    return teams != nil ? teams.count : 0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSString *key = [[[CoreDataController sharedInstance]indexedDomains] allKeys][indexPath.section];
        
        Domain *domain = ((NSArray *)[[CoreDataController sharedInstance]indexedDomains][key])[indexPath.row];
        
        [[CoreDataController sharedInstance]removeDomain:domain];
        
        [self refresh:tableView];
    }
}

- (void)refresh:(UITableView *)tableView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [tableView reloadData];
    });
}

@end
