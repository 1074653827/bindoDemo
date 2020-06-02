//
//  Pizza.m
//  BIndoTest
//
//  Created by KingZ on 2020/6/1.
//  Copyright © 2020 KingZ. All rights reserved.
//

#import "Pizza.h"
#import "Chef.h"

@interface Pizza ()<NSCoding>

@end

@implementation Pizza


+(NSArray *)mj_ignoredPropertyNames{
    return @[@"infoBlock",@"completeBlock"];
}



-(void)progressInfo:(Chef *)chef{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.infoBlock){
            self.infoBlock(chef, self);
        }
    });
}
-(void)completeInfo:(Chef *)chef{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.completeBlock){
            self.completeBlock(chef, self);
        }
    });
    
}
MJCodingImplementation

@end
