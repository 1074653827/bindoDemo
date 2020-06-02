//
//  AlertViewManager.h
//  中国一键
//
//  Created by KingZ on 15/12/18.
//  Copyright © 2015年 ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class KZAlertView;

typedef void(^AlertViewBlock)(NSString* s, KZAlertView* alertView);

@interface KZAlertView : NSObject<UIAlertViewDelegate,UIActionSheetDelegate>

-(void)showAlertWithController:(nonnull UIViewController*)controller WithTitle:(nullable NSString*)title WithMessage:(nullable NSString*)message  WithCanncelButtonTitle:(nullable NSString*)canncelButtonTitle otherButtonTitles:(nullable NSString*)otherBtnTitle,...NS_REQUIRES_NIL_TERMINATION;

-(void)showActionSheetWithController:(nonnull UIViewController*)controller WithTitle:(nullable NSString*)title WithMessage:(nullable NSString*)message WithdestructiveButtonTitle:(nullable NSString*)destructiveButtonTitle  WithCanncelButtonTitle:(nullable NSString*)canncelButtonTitle otherButtonTitles:(nullable NSString*)otherBtnTitle,...NS_REQUIRES_NIL_TERMINATION;


@property(nonatomic,strong)AlertViewBlock alertViewblock;

@end
