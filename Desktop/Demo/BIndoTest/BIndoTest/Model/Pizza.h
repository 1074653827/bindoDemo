//
//  Pizza.h
//  BIndoTest
//
//  Created by KingZ on 2020/6/1.
//  Copyright © 2020 KingZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PizzaConfig.h"
#import "MJExtension.h"
@class Chef;
NS_ASSUME_NONNULL_BEGIN

typedef enum {
    
    Pizza_State_No = 0 ,
    
    Pizza_State_Doing = 1,
    
    Pizza_State_Yes = 2,
    
    Pizza_State_Posted = 3,
    
}Pizza_State;

@interface Pizza : NSObject

@property(nonatomic,copy)NSString * chefer;

@property(nonatomic,assign)NSUInteger orderId;

/**
 配置
 */
@property(nonatomic,strong)PizzaConfig * config;

//@property(nonatomic,strong)PizzaConfig * config;

/**
 状态
 */
@property(nonatomic,assign)Pizza_State stage;

/**
 进度
 */
@property(nonatomic,assign)float progress;


@property(nonatomic,copy)void(^infoBlock)(Chef * _Nullable  chef ,  Pizza *_Nullable pizza);

@property(nonatomic,copy)void(^completeBlock)(Chef * _Nullable  chef ,  Pizza *_Nullable pizza);

-(void)progressInfo:(Chef*)chef;

-(void)completeInfo:(Chef*)chef;

@end

NS_ASSUME_NONNULL_END
