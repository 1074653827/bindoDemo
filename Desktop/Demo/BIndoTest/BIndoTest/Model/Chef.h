//
//  Chef.h
//  BIndoTest
//
//  Created by KingZ on 2020/6/1.
//  Copyright © 2020 KingZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pizza.h"
NS_ASSUME_NONNULL_BEGIN

@interface Chef : NSObject

@property(nonatomic,copy,nonnull)NSString * name;

@property(nonatomic,assign)NSUInteger perSpeed;

@property(nonatomic,assign,readonly)BOOL isWork;

@property(nonatomic,strong,readonly)NSMutableArray <Pizza*>*orderList;

@property(nonatomic,strong)NSMutableArray <Pizza*>*completePizzas;

@property(nonatomic,copy)void(^infoBlock)(Chef * _Nullable  chef ,  Pizza *_Nullable pizza,  NSString * _Nullable info);

-(instancetype)initWithName:(NSString*)name PerSpeed:(NSUInteger)perSpeed;

-(void)receiveOrder:(Pizza*)order;

-(void)completePizza:(void(^)(Chef * chef , Pizza * pizza))block;

-(void)startWork;

-(void)stopWork;

-(void)saveData;

@end

NS_ASSUME_NONNULL_END
