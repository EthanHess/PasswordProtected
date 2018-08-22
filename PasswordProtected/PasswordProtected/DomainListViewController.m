//
//  DomainListViewController.m
//  PasswordProtected
//
//  Created by Ethan Hess on 8/13/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

#import "DomainListViewController.h"
#import "DomainDetailViewController.h"
#import "DomainListDataSource.h"
#import "UIView+FLKAutoLayout.h"
#import "GlobalFunctions.h"
#import "CoreDataController.h"

@interface DomainListViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DomainListDataSource *dataSource; //External DSrc

@end

@implementation DomainListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"Domains";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *addDomainButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addDomainButtonPressed)];
    self.navigationItem.rightBarButtonItem = addDomainButton;
    
    [self setUpTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];;
    self.dataSource = [DomainListDataSource new];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    [self.dataSource registerTableView:self.tableView];
    [self.view addSubview:self.tableView];
    
    //Pin to view via FLKAutoLayout
    [self.tableView alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:self.view];
}

- (void)addDomainButtonPressed {
    [GlobalFunctions presentAddAlertWithTitle:@"Add Domain" placeholder:@"Domain Name" firstActionTitle:@"Add" andText:@"" fromVC:self andCompletion:^(NSString *textToAdd) {
        if (![textToAdd isEqualToString:@""]) {
            [[CoreDataController sharedInstance]addDomainWithName:textToAdd];
            [self refreshTable];
        } else {
            //Do nothing
        }
    }];
}

- (void)refreshTable {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DomainDetailViewController *dvc = [DomainDetailViewController new];
    NSString *key = [[[CoreDataController sharedInstance]indexedDomains] allKeys][indexPath.section];
    Domain *domain = ((NSArray *)[[CoreDataController sharedInstance]indexedDomains][key])[indexPath.row];
    [dvc updateWithDomain:domain];
    
    [self.navigationController showViewController:dvc sender:nil];
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
