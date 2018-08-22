//
//  ViewController.m
//  PasswordProtected
//
//  Created by Ethan Hess on 8/8/18.
//  Copyright © 2018 EthanHess. All rights reserved.
//

#import "ViewController.h"
#import "CodePadView.h"

//VC
#import "DomainListViewController.h"

@interface ViewController () <CodePadDelegate>

@property (nonatomic, strong) CodePadView *codePadView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self viewConfiguration];
}

- (void)viewConfiguration {
    
    if (self.codePadView == nil) {
        CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        self.codePadView = [[CodePadView alloc]initWithFrame:frame];
        self.codePadView.delegate = self;
        self.codePadView.initialLoad = [self initialLoad];
        [self.view addSubview:self.codePadView]; 
    }
}

- (BOOL)initialLoad {
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"Code"] == nil;
}

- (void)codeIsValid {
    DomainListViewController *dlvc = [DomainListViewController new];
    [self.navigationController pushViewController:dlvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
