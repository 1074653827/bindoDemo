//
//  ViewController.m
//  BIndoTest
//
//  Created by KingZ on 2020/6/1.
//  Copyright © 2020 KingZ. All rights reserved.
//

#import "ViewController.h"
#import "Manager.h"
#import "ChefTableViewCell.h"
#import "OrderViewController.h"
#import "ChefInfoViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,OrderViewControllerDelegate>

@property(nonatomic,weak)IBOutlet UITableView * tableV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavi];
    
    Manager * manager = [Manager defaults];
    [manager doBusiness];

  
    [self.tableV registerNib:[UINib nibWithNibName:NSStringFromClass(ChefTableViewCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(ChefTableViewCell.class)];
    [self .tableV reloadInputViews];
    
    
}

-(void)setupNavi{
    
    [Manager defaults].infoBlock = ^(NSString * _Nonnull string) {
        self.navigationItem.title = string;
    };
    
    UISwitch * switchV = [[UISwitch alloc]init];
    switchV.on = YES;
    [switchV addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem * item1 = [[UIBarButtonItem alloc]initWithCustomView:switchV];
    UIBarButtonItem * item2 = [[UIBarButtonItem alloc]initWithTitle:@"下订单" style:UIBarButtonItemStylePlain target:self action:@selector(pushOrder)];
    self.navigationItem.rightBarButtonItems = @[item2,item1];
    
}

#pragma mark -- tableViewDelegate --

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [Manager defaults].chefs.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChefTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ChefTableViewCell class]) forIndexPath:indexPath];
    cell.chef = [Manager defaults].chefs[indexPath.row];
    [cell reloadViews];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Chef * chef = [Manager defaults].chefs[indexPath.row];
    
    ChefInfoViewController * vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass(ChefInfoViewController.class)];
    vc.chef = chef;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- OrderViewControllerDelegate --

-(void)OrderViewControllerDelegateOrderClick:(OrderViewController * )vc PizzaConfig:(PizzaConfig*)config{
    
    [vc.navigationController popViewControllerAnimated:YES];
    
    [[Manager defaults] receiveOrder:config];
    
    
}

#pragma mark -- action --

-(void)switchAction:(UISwitch * )switchV{
    if(switchV.on){
        [[Manager defaults] doBusiness];
    }else{
        [[Manager defaults] colseBusiness];
    }
    [self.tableV reloadData];
}
-(void)pushOrder{
//    OrderViewController * vc = kInitStoryBoardVC(@"Main", OrderViewController);
    OrderViewController * vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass(OrderViewController.class)];
    [self.navigationController pushViewController:vc animated:YES];
    
    vc.delegate = self;
    
}

@end
