//
//  Chef.m
//  BIndoTest
//
//  Created by KingZ on 2020/6/1.
//  Copyright © 2020 KingZ. All rights reserved.
//

#import "Chef.h"
#import "KZSqliteManager.h"

@interface Chef ()

@property(nonatomic,strong)dispatch_queue_t chefQueue;

@property(nonatomic,strong)dispatch_source_t timer;

@property(nonatomic,assign) NSUInteger indexx;

@property(nonatomic,strong)Pizza * lastP;

@property(nonatomic,strong)Pizza * nextP;

@property(nonatomic,assign)BOOL isDoPizza;

@end

@implementation Chef

#pragma mark -- public --

-(instancetype)initWithName:(NSString *)name PerSpeed:(NSUInteger)perSpeed{
    if(self == [super init]){
        _name = name;
        _perSpeed = perSpeed;
        _orderList = [NSMutableArray array];
        _completePizzas = [NSMutableArray array];
        
        NSAssert(self.name, @"name can not be null！");
           _chefQueue = dispatch_queue_create([name UTF8String], DISPATCH_QUEUE_SERIAL);
        
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _chefQueue);
        dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        
        _indexx = 0;
        
        [self getLocalData];
    }
    return self;;
}

-(void)receiveOrder:(Pizza *)order{
    order.chefer = self.name;
    [self.orderList addObject:order];
}

-(void)completePizza:(void (^)(Chef * _Nonnull, Pizza * _Nonnull))block{
    
}

-(void)startWork{
    _isWork = YES;
    if(self.orderList == nil || self.orderList.count == 0){
        [self info:[NSString stringWithFormat:@"--- : %@没有订单了",self.name]];
        
        return;
    }
    if(!self.lastP){
        self.lastP = _orderList.firstObject;
        for(Pizza * pizza in self.orderList){
            if(pizza.stage >= Pizza_State_Yes){
                [self.completePizzas addObject:pizza];
                self.lastP = pizza;
            }else{
                break;
            }
        }
    }
    [self info:[NSString stringWithFormat:@" ---:%@有工作le",self.name]];
    

    dispatch_source_set_event_handler(_timer, ^{
        [self doPizza];
    });
    
    if(!_isDoPizza){
        [self resumeTimer];
    }
    
    self.isDoPizza = YES;
    
}
-(void)stopWork{
    _isWork = NO;
    _isDoPizza = NO;
    [self info:[NSString stringWithFormat:@" ---:%@休息中",self.name]];
    [self pauseTimer];
}


-(void)saveData{
    
//    [KZSqliteManager executeUpdateOrInsertTable:table_Pizza dicOrModel:self.orderList whereFormat:@"where chefer = %@",self.name];
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",self.name]];
    
    NSArray *dictArray = [Pizza mj_keyValuesArrayWithObjectArray:self.orderList];
    
    BOOL result = [dictArray writeToFile:path atomically:NO];
    
    NSLog(@"%d",result);
    
//    NSData * data = [NSPropertyListSerialization dataWithPropertyList:self.orderList format:NSPropertyListBinaryFormat_v1_0 options:0 error:nil];
//
//
//    [data writeToFile:path atomically:YES];
//    NSLog(@"%@",dictArray);
}

-(void)getLocalData{
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",self.name]];
    NSArray * dicArr = [[NSArray alloc]initWithContentsOfFile:path];
    [self.orderList addObjectsFromArray: [Pizza mj_objectArrayWithKeyValuesArray:dicArr]];
    
//    NSData * data = [[NSData alloc] initWithContentsOfFile:path];
//    id a = [NSPropertyListSerialization propertyListWithData:data options:0 format:NULL error:nil];
    
    
    
}

#pragma mark -- private --

-(void)doPizza{
    
    self.indexx++;
    
    if(self.lastP.stage >= Pizza_State_Yes && self.lastP == self.orderList.lastObject){
        [self info:[NSString stringWithFormat:@"--- : %@ 订单都做完了 ------ thread:%@",self.name,[NSThread currentThread]]];
        _isDoPizza = NO;
        [self pauseTimer];
        self.indexx = 0;
        return;
    }
    self.nextP = self.lastP.stage >=  Pizza_State_Yes ? [self.orderList objectAtIndex:[self.orderList indexOfObject:self.lastP] + 1] : self.lastP;
    self.nextP.progress = (float)self.indexx / (float)_perSpeed;
    
    [self info:[NSString stringWithFormat:@"--- : %@ 正在做 %lu pizza 完成百分比 : %f ------ thread:%@",self.name,(unsigned long)self.nextP.orderId, self.nextP.progress ,[NSThread currentThread]]];
    self.nextP.stage = Pizza_State_Doing;
    [self.nextP progressInfo:self];
    
    if(self.indexx == self.perSpeed){
        self.nextP.stage = Pizza_State_Yes;
        self.nextP.progress = 1;
        [self.nextP completeInfo:self];
        [self info:[NSString stringWithFormat:@"--- : %@ 做完 %lu pizza , 执行下一个订单 ------ thread:%@",self.name,(unsigned long)self.nextP.orderId,[NSThread currentThread]]];
        [self.completePizzas addObject:self.nextP];
        self.lastP = self.nextP;
        
        self.indexx = 0 ;
    }
    
}


-(void) pauseTimer{
    if(self.timer){
        dispatch_suspend(_timer);
        _isDoPizza = NO;
    }
}
-(void) resumeTimer{
    if(self.timer){
        
        dispatch_resume(_timer);
    }
}
-(void) stopTimer{
    if(self.timer){
        dispatch_source_cancel(_timer);
        _isDoPizza = NO;
        _timer = nil;
    }
}

-(void)info:(NSString*)string{
    NSString * info = string;
    NSLog(@"%@",info);
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.infoBlock){
            self.infoBlock(self,nil,info);
        }
    });
}

@end
