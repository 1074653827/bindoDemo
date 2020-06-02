//
//  Manager.m
//  BIndoTest
//
//  Created by KingZ on 2020/6/1.
//  Copyright © 2020 KingZ. All rights reserved.
//

#import "Manager.h"

@interface Manager ()

@property(nonatomic,strong)NSMutableArray<Pizza*> * orderList;

@end

@implementation Manager

#pragma mark -- init --

static Manager * _netCore;
+ (instancetype)defaults{
    if (!_netCore) {
        _netCore = [[Manager alloc]init];
    }
    return _netCore;
}


/**
 "Roast Beef"
 case Toppings_Flavour_BP  = "Bell Peppers"
 case Toppings_Flavour_Mu  = "Mushrooms"
 case Toppings_Flavour_On  = "Onions"
 case Toppings_Flavour_To  = "Tomatoes"
 case Toppings_Flavour_Ma  = "Marinara"
 */


-(instancetype)init{
    if(self == [super init]){
        _chefs = [NSMutableArray arrayWithCapacity:7];
        _orderList = [NSMutableArray array];
        _toppingss = @[@"Roast Beef",@"Bell Peppers",@"Mushrooms",@"Onions",@"Tomatoes",@"Marinara"];
        _sizes = @[@(Pizza_Size_Small),@(Pizza_Size_Medium),@(Pizza_Size_Large)];
        [self initChef];
    }
    return self;
}

#pragma mark -- public --
-(void)doBusiness{
    if (self.infoBlock) {
        self.infoBlock(@"--- : Bindo 营业");
    }
    [self startAllWork];
}
-(void)colseBusiness{
    if (self.infoBlock) {
        self.infoBlock(@"--- : Bindo 打烊");
    }
    [self stopAllWork];
}

-(void)receiveOrder:(PizzaConfig*)order{
    
    NSUInteger orderListCount = _orderList.count;
    for (int i = 0; i < order.nummber; i ++) {
        Pizza * pizza = [[Pizza alloc]init];
        pizza.orderId = i+1 + orderListCount;
        pizza.config = order;
        for(int j = 0 ; j < self.chefs.count ; j ++){
            
            if((pizza.orderId - 1) % self.chefs.count == j){
                [[self.chefs objectAtIndex:j] receiveOrder:pizza];
                break;
            }
        }
        [self.orderList addObject:pizza];
    }
    [self startAllWork];
}

#pragma mark -- private --

-(void)startAllWork{
    for(Chef * chef in self.chefs){
        [self startWork:chef];
    }
}
-(void)startWork:(Chef*)chef{
    [chef startWork];
}

-(void)stopAllWork{
    for(Chef * chef in self.chefs){
        [self stopWork:chef];
    }
}
-(void)stopWork:(Chef*)chef{
    [chef stopWork];
}


-(void)initChef{
    for(int i = 0 ; i < 7 ; i++){
        Chef * chef = [[Chef alloc]initWithName:[NSString stringWithFormat:@"厨师 %d号",i] PerSpeed:i+1];
        [_chefs addObject:chef];
        [self.orderList addObjectsFromArray:chef.orderList];
    }
}

-(void)saveData{
    for(Chef * chef in self.chefs){
        [chef saveData];
    }
}


@end
