//
//  OrderViewController.h
//  BIndoTest
//
//  Created by KingZ on 2020/6/2.
//  Copyright © 2020 KingZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pizza.h"
NS_ASSUME_NONNULL_BEGIN
@class OrderViewController;
@protocol OrderViewControllerDelegate <NSObject>

@optional
-(void)OrderViewControllerDelegateOrderClick:(OrderViewController * )vc PizzaConfig:(PizzaConfig*)config;

@end

@interface OrderViewController : UIViewController

@property(nonatomic,weak) id<OrderViewControllerDelegate> delegate;

@property(nonatomic,strong)Pizza * pizza;

@end

NS_ASSUME_NONNULL_END
