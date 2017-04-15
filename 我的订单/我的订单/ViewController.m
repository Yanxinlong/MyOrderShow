//
//  ViewController.m
//  我的订单
//
//  Created by qhzc-iMac-02 on 2017/4/14.
//  Copyright © 2017年 Yxl. All rights reserved.
//

#import "ViewController.h"
#import "OrderViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 60)];
    btn.backgroundColor = [UIColor colorWithRed:179.0/255.0 green:179.0/255.0 blue:179.0/255.0 alpha:1.0f];
    
    [btn addTarget:self action:@selector(dididi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)dididi {

    OrderViewController *orderVC = [[OrderViewController alloc]init];
    orderVC.selectedIndex = 3;
    [self.navigationController pushViewController:orderVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
