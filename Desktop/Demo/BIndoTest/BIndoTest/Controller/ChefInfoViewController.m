//
//  ChefInfoViewController.m
//  BIndoTest
//
//  Created by KingZ on 2020/6/2.
//  Copyright © 2020 KingZ. All rights reserved.
//

#import "ChefInfoViewController.h"
#import "PizzaTableViewCell.h"
#import "KZAlertView.h"
#import "OrderViewController.h"
@interface ChefInfoViewController ()<UITableViewDelegate,UITableViewDataSource,OrderViewControllerDelegate>

@property(nonatomic,weak)IBOutlet UITableView * tableV;


@end

@implementation ChefInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.chef.name;
    
    [self.tableV registerNib:[UINib nibWithNibName:NSStringFromClass(PizzaTableViewCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(PizzaTableViewCell.class)];
    [self .tableV reloadInputViews];
}


#pragma mark -- tableViewDelegate --

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return (self.chef != nil) ? self.chef.orderList.count : 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PizzaTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PizzaTableViewCell class]) forIndexPath:indexPath];
    cell.pizza = self.chef.orderList[indexPath.row];
    cell.postBlock = ^(PizzaTableViewCell * _Nonnull cell, Pizza * _Nonnull pizza) {
        KZAlertView * alert= [[KZAlertView alloc]init];
        [alert showAlertWithController:self WithTitle:nil WithMessage:[NSString stringWithFormat:@"%d 披萨发送成功",pizza.orderId] WithCanncelButtonTitle:@"确定" otherButtonTitles: nil];
        
        pizza.stage = Pizza_State_Posted;
        [cell reloadViews];
        
    };
    [cell reloadViews];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Pizza * pizza = self.chef.orderList[indexPath.row];
    
    OrderViewController * vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass(OrderViewController.class)];
    vc.pizza = pizza;
    [self.navigationController pushViewController:vc animated:YES];
    
    vc.delegate = self;
}

#pragma mark -- OrderViewControllerDelegate --

-(void)OrderViewControllerDelegateOrderClick:(OrderViewController *)vc PizzaConfig:(PizzaConfig *)config{
    
    [vc.navigationController popViewControllerAnimated:YES];
    KZAlertView * alert = [[KZAlertView alloc]init];
    if(vc.pizza.stage == Pizza_State_No){
        vc.pizza.config = config;
        
        [alert showAlertWithController:self WithTitle:nil WithMessage:@"修改成功" WithCanncelButtonTitle:@"确定" otherButtonTitles: nil];
    }else{
        [alert showAlertWithController:self WithTitle:nil WithMessage:@"无法修改" WithCanncelButtonTitle:@"确定" otherButtonTitles: nil];
    }
    
}


@end
