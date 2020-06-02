//
//  ChefTableViewCell.h
//  BIndoTest
//
//  Created by KingZ on 2020/6/2.
//  Copyright © 2020 KingZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "Chef.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChefTableViewCell : BaseTableViewCell

@property(nonatomic,strong)Chef * chef;



@end

NS_ASSUME_NONNULL_END
