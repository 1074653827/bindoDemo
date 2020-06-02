//
//  Manager.h
//  BIndoTest
//
//  Created by KingZ on 2020/6/1.
//  Copyright © 2020 KingZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Chef.h"
NS_ASSUME_NONNULL_BEGIN

@interface Manager : NSObject

/**
厨师
 */
@property(nonatomic,readonly,strong)NSMutableArray <Chef*>* chefs;


@property(nonatomic,readonly,strong)NSArray <NSString*>*toppingss;

@property(nonatomic,readonly,strong)NSArray <NSNumber*>*sizes;


@property(nonatomic,copy)void(^infoBlock)(NSString * string);

+ (instancetype)defaults;

/**
 营业
 */
-(void)doBusiness;

/**
 打烊
 */
-(void)colseBusiness;

-(void)receiveOrder:(PizzaConfig*)order;

-(void)saveData;

@end

NS_ASSUME_NONNULL_END
