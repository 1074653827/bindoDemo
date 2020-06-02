//
//  PizzaConfig.h
//  BIndoTest
//
//  Created by KingZ on 2020/6/2.
//  Copyright © 2020 KingZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Toppings.h"
#import "MJExtension.h"
NS_ASSUME_NONNULL_BEGIN

typedef enum {
 
    Pizza_Size_Small = 320 ,
    
    Pizza_Size_Medium = 530 ,
    
    Pizza_Size_Large = 860 ,
    
}Pizza_Size;

@interface PizzaConfig : NSObject


/**
 尺寸
 */
@property(nonatomic,assign)Pizza_Size size;

/**
 备注
 */
@property(nonatomic,copy)NSString * remark;


/**
 味道
 */
@property(nonatomic,strong)NSMutableArray <Toppings*>* toppingss;

/**
 数量
 */
@property(nonatomic,assign)NSUInteger nummber;

+(NSString * )Pizza_SizeStr:(Pizza_Size)size;

@end

NS_ASSUME_NONNULL_END
