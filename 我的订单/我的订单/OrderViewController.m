//
//  OrderViewController.m
//  我的订单
//
//  Created by qhzc-iMac-02 on 2017/4/14.
//  Copyright © 2017年 Yxl. All rights reserved.
//

#import "OrderViewController.h"
#import "DAPagesContainer.h"

#import "OrderListTableViewController.h"

/**
 *  屏幕宽度
 */
#define k_Width [[UIScreen mainScreen] bounds].size.width

/**
 *  屏幕高度
 */
#define k_Height [[UIScreen mainScreen] bounds].size.height

@interface OrderViewController ()

@property (nonatomic,strong)DAPagesContainer *pagesContainer;

@end

@implementation OrderViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.pagesContainer.selectedIndex = _selectedIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationItem.title = @"我的订单";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    //添加主页面
    self.pagesContainer = [[DAPagesContainer alloc]init];
    [self.pagesContainer willMoveToParentViewController:self];
    self.pagesContainer.view.frame = CGRectMake(0, 0, k_Width, k_Height);
    self.pagesContainer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.pagesContainer didMoveToParentViewController:self];
    
    OrderListTableViewController *shouldPayOrderListVC = [[OrderListTableViewController alloc]init];
    shouldPayOrderListVC.title = @"未支付";
    shouldPayOrderListVC.orderListVC = self;
    //    shouldPayOrderListVC.isPushFromSubmitOrderSuccess = _isPushFromSubmitOrderSuccess;
    
    OrderListTableViewController *aleradyPayOrderListVC = [[OrderListTableViewController alloc]init];
    aleradyPayOrderListVC.title = @"已支付";
    aleradyPayOrderListVC.orderListVC = self;
    //    aleradyPayOrderListVC.isPushFromSubmitOrderSuccess = _isPushFromSubmitOrderSuccess;
    
    OrderListTableViewController *aleradyFinishOrderListVC = [[OrderListTableViewController alloc]init];
    aleradyFinishOrderListVC.title = @"已完成";
    aleradyFinishOrderListVC.orderListVC = self;
    //    aleradyFinishOrderListVC.isPushFromSubmitOrderSuccess = _isPushFromSubmitOrderSuccess;
    
    OrderListTableViewController *aleradyCancelOrderListVC = [[OrderListTableViewController alloc]init];
    aleradyCancelOrderListVC.title = @"已取消";
    aleradyCancelOrderListVC.orderListVC = self;
    //    aleradyCancelOrderListVC.isPushFromSubmitOrderSuccess = _isPushFromSubmitOrderSuccess;
    
    OrderListTableViewController *allOrderListVC = [[OrderListTableViewController alloc]init];
    allOrderListVC.title = @"全部";
    allOrderListVC.orderListVC = self;
    //    allOrderListVC.isPushFromSubmitOrderSuccess = _isPushFromSubmitOrderSuccess;
    
    self.pagesContainer.viewControllers = @[shouldPayOrderListVC,aleradyPayOrderListVC,aleradyFinishOrderListVC,aleradyCancelOrderListVC,allOrderListVC];
    [self addChildViewController:shouldPayOrderListVC];
    [self addChildViewController:aleradyPayOrderListVC];
    [self addChildViewController:aleradyFinishOrderListVC];
    [self addChildViewController:aleradyCancelOrderListVC];
    [self addChildViewController:allOrderListVC];
    [self.view addSubview:self.pagesContainer.view];
    
    self.pagesContainer.topBarHeight = 40;
    self.pagesContainer.topBarBackgroundColor = [UIColor whiteColor];
    self.pagesContainer.pageIndicatorBackgroundColor = [UIColor redColor];
    self.pagesContainer.selectedPageItemTitleColor = [UIColor redColor];
    self.pagesContainer.pageItemsTitleColor = [UIColor blueColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
