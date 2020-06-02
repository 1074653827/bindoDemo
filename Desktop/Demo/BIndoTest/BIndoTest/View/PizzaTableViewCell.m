//
//  PizzaTableViewCell.m
//  BIndoTest
//
//  Created by KingZ on 2020/6/2.
//  Copyright © 2020 KingZ. All rights reserved.
//

#import "PizzaTableViewCell.h"

@interface PizzaTableViewCell ()

@property(nonatomic,weak)IBOutlet UILabel * order;

@property(nonatomic,weak)IBOutlet UILabel * progress;

@property(nonatomic,weak)IBOutlet UIButton * post;

@end

@implementation PizzaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
-(void)reloadViews{
    if(!self.pizza)return;
    __weak PizzaTableViewCell * weakSelf = self;
    self.order.text =  [NSString stringWithFormat:@"%lu",(unsigned long)self.pizza.orderId];
    self.progress.text = [NSString stringWithFormat:@"%.2f",weakSelf.pizza.progress];
    self.post.hidden = ! (self.pizza.progress==1);
    self.post.selected = (self.pizza.stage == Pizza_State_Posted) ? YES : NO;
    self.pizza.infoBlock = ^(Chef * _Nullable chef, Pizza * _Nullable pizza) {
        weakSelf.progress.text = [NSString stringWithFormat:@"%.2f",weakSelf.pizza.progress];
        [weakSelf reloadViews];
    };
    self.pizza.completeBlock = ^(Chef * _Nullable chef, Pizza * _Nullable pizza) {
        weakSelf.post.hidden = YES;
        [weakSelf reloadViews];
    };
    
    
}

-(IBAction)postAction:(UIButton*)sender{
    if(sender.selected)return;
    sender.selected = YES;
    
    if(self.postBlock){
        self.postBlock(self, self.pizza);
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
