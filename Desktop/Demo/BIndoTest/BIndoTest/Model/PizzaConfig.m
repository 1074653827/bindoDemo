//
//  PizzaConfig.m
//  BIndoTest
//
//  Created by KingZ on 2020/6/2.
//  Copyright © 2020 KingZ. All rights reserved.
//

#import "PizzaConfig.h"

@interface PizzaConfig ()<NSCoding>

@end

@implementation PizzaConfig

+(NSDictionary *)mj_objectClassInArray{
    return @{@"toppingss":[Toppings class]};;
}

-(instancetype)init{
    if(self == [super init]){
        _toppingss = [NSMutableArray array];
    }
    return self;
}

+(NSString * )Pizza_SizeStr:(Pizza_Size)size{
    switch (size) {
        case Pizza_Size_Small:
            return  @"small";
            break;
        case Pizza_Size_Medium:
            return @"Medium";
            break;
        case Pizza_Size_Large:
            return @"Large";
            break;
        default:
            return @"";
            break;
    }
}
MJCodingImplementation

@end
