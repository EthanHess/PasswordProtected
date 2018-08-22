//
//  DomainDetailViewController.m
//  PasswordProtected
//
//  Created by Ethan Hess on 8/13/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

#import "DomainDetailViewController.h"
#import "Credential+CoreDataClass.h"
#import "Credential+CoreDataProperties.h"
#import "GlobalFunctions.h"
#import "CoreDataStack.h"

@interface DomainDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) Domain *domain;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DomainDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = self.domain.name;
    [self tableViewConfigure];
    
    UIBarButtonItem *addCredentialButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNew)];
    self.navigationItem.rightBarButtonItem = addCredentialButton;
}

- (void)tableViewConfigure {
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self registerTableView:self.tableView];
    [self.view addSubview:self.tableView];
}

- (void)addNew {
    [GlobalFunctions presentAddCredentialAlertWithTitle:@"Add Username and Password" placeholderOne:@"Username" placeholderTwo:@"Password" firstActionTitle:@"Add" andText:@"" fromVC:self andCompletion:^(NSString * _Nullable username, NSString * _Nullable password) {
        
        if (username != nil && password != nil) {
            
            Credential *newCred = [NSEntityDescription insertNewObjectForEntityForName:@"Credential" inManagedObjectContext:[CoreDataStack sharedInstance].managedObjectContext];
            newCred.username = username;
            newCred.password = password;
            newCred.domain = self.domain;
            
            [[CoreDataStack sharedInstance].managedObjectContext save:nil];
            [self refresh];
            
        } else {
            NSLog(@"Cancelled");
        }
    }];
}

- (void)registerTableView:(UITableView *)tableView {
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)refresh {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)updateWithDomain:(Domain *)domain {
    self.domain = domain;
    self.title = domain.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Table View

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    NSOrderedSet *set = [NSOrderedSet orderedSetWithSet:self.domain.credentials];
    
    Credential *credential = [set objectAtIndexedSubscript:indexPath.row];
    cell.textLabel.text = credential.username;
    cell.detailTextLabel.text = credential.password;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.domain.credentials != nil ? self.domain.credentials.count : 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
