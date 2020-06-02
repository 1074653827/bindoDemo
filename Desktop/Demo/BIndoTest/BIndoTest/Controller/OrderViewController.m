//
//  OrderViewController.m
//  BIndoTest
//
//  Created by KingZ on 2020/6/2.
//  Copyright © 2020 KingZ. All rights reserved.
//

#import "OrderViewController.h"
#import "Manager.h"
#import "Masonry.h"
@interface OrderViewController ()

@property(nonatomic,weak)IBOutlet UIView * sizeV;

@property(nonatomic,weak)IBOutlet UIView * toppingsV;

@property(nonatomic,weak)IBOutlet UITextField * more;

@property(nonatomic,weak)IBOutlet UIButton * order;

@property(nonatomic,weak)IBOutlet UITextField * number;

@property(nonatomic,strong)PizzaConfig * config;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"下订单";
    [self setupView];
    
    self.config = [[PizzaConfig alloc]init];
    if(self.pizza){
        self.config.nummber = self.pizza.config.nummber;
        self.config.remark = self.pizza.config.remark;
        self.config.size = self.pizza.config.size;
        self.config.toppingss = [[NSMutableArray alloc]initWithArray:self.pizza.config.toppingss];
        self.number.hidden = YES;
        [self reloadData];
    }
    
}

-(void)setupView{
    UIButton * lastView;
    for(int i = 0 ; i < [[Manager defaults] sizes].count ; i++){
        Pizza_Size size = [[[Manager defaults] sizes][i] intValue];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = size;
        
        [button addTarget:self action:@selector(sizeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[PizzaConfig Pizza_SizeStr:size] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self.sizeV addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sizeV);
            make.bottom.equalTo(self.sizeV);
            if(!lastView){
                make.left.equalTo(self.sizeV);
            }else{
                make.left.equalTo(lastView.mas_right);
            }
            make.width.equalTo(self.sizeV).multipliedBy(1.0/[[Manager defaults] sizes].count);
        }];
        lastView = button;
    }
    UIButton * lastBtn;
    for(int i = 0 ; i < [[Manager defaults] toppingss].count ; i ++){
        NSString * toppingsStr = [[Manager defaults] toppingss][i];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = i;
        [button addTarget:self action:@selector(toppingsAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:toppingsStr forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self.toppingsV addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.toppingsV).multipliedBy(1.0/3);
            make.height.equalTo(@(40));
            if(!lastBtn){
                make.top.left.equalTo(self.toppingsV);
            }else{
                
                if((i)%3==0){
                    make.top.equalTo(lastBtn.mas_bottom).offset(0);
                    make.left.equalTo(self.toppingsV);
                }else{
                    make.top.equalTo(lastBtn);
                    make.left.equalTo(lastBtn.mas_right).offset(0);
                }
            }
        }];
        lastBtn = button;
    }
    
}

-(void)reloadData{
    self.more.text = self.config.remark;
    for (UIButton * btn  in self.sizeV.subviews) {
        if(btn.tag == self.config.size){
            btn.selected = YES;
        }
    }
    
    for(UIButton * btn in self.toppingsV.subviews){
        NSString * tpStr = [[Manager defaults] toppingss][btn.tag];
        for(Toppings * top in self.config.toppingss){
            if([tpStr isEqualToString:top.flavour]){
                btn.selected = YES;
            }
        }
    }
    
}

#pragma mark -- action --

-(void)sizeBtnAction:(UIButton*)btn{
    for (UIButton * btn in self.sizeV.subviews) {
        [btn setSelected:NO];
    }
    btn.selected = YES;
    self.config.size = btn.tag;
    
}

-(void)toppingsAction:(UIButton*)sender{
    sender.selected = !sender.selected;
    NSString * topStr = [[Manager defaults]toppingss ][sender.tag];
    
    if(sender.selected){
        Toppings * tops = [[Toppings alloc]init];
        tops.flavour = topStr;
        [self.config.toppingss addObject:tops];
    }else{
        for (Toppings * toppings in self.config.toppingss) {
            if([toppings.flavour isEqualToString:topStr]){
                [self.config.toppingss removeObject:toppings];
            }
        }
    }
    
}

-(IBAction)orderAction{
    self.config.remark = self.more.text;
    self.config.nummber = [self.number.text integerValue];
    if(self.delegate){
        if([self.delegate respondsToSelector:@selector(OrderViewControllerDelegateOrderClick:PizzaConfig:)]){
            [self.delegate OrderViewControllerDelegateOrderClick:self PizzaConfig:self.config];
        }
    }
}

@end
