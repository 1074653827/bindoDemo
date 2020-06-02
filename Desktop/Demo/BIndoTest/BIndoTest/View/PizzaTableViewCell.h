//
//  PizzaTableViewCell.h
//  BIndoTest
//
//  Created by KingZ on 2020/6/2.
//  Copyright © 2020 KingZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "Pizza.h"
NS_ASSUME_NONNULL_BEGIN

@interface PizzaTableViewCell : BaseTableViewCell

@property(nonatomic,strong)Pizza * pizza;

@property(nonatomic,copy)void(^postBlock)(PizzaTableViewCell* cell , Pizza* pizza);

@end

NS_ASSUME_NONNULL_END
