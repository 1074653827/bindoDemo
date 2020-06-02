//
//  ChefTableViewCell.m
//  BIndoTest
//
//  Created by KingZ on 2020/6/2.
//  Copyright © 2020 KingZ. All rights reserved.
//

#import "ChefTableViewCell.h"

@interface ChefTableViewCell ()

@property(nonatomic,weak)IBOutlet UILabel * name;

@property(nonatomic,weak)IBOutlet UILabel * info;

@property(nonatomic,weak)IBOutlet UILabel * progress;

@property(nonatomic,weak)IBOutlet UISwitch * switchV;

@end

@implementation ChefTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)reloadViews{
    if(!self.chef)return;
    self.name.text = self.chef.name;
    self.switchV.on = self.chef.isWork;
    __weak ChefTableViewCell * weakSelf = self;
    self.chef.infoBlock = ^(Chef * _Nullable chef, Pizza * _Nullable pizza, NSString * _Nullable info) {
        weakSelf.info.text = info;
        weakSelf.progress.text = [NSString stringWithFormat:@"%lu/%d",(unsigned long)chef.completePizzas.count,chef.orderList.count];
    };
}

-(IBAction)swAction:(UISwitch*)sender{
    if(sender.on){
        [self.chef startWork];
    }else{
        [self.chef stopWork];
    }
    [self reloadViews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
