//
//  AlertViewManager.m
//  中国一键
//
//  Created by KingZ on 15/12/18.
//  Copyright © 2015年 ios. All rights reserved.
//

#import "KZAlertView.h"
#import <objc/runtime.h>

#define kVersion [[UIDevice currentDevice].systemVersion floatValue]

static char overviewKey;

@interface KZAlertView (){
    UIViewController* _controller;

}

@end

@implementation KZAlertView

-(void)showAlertWithController:(UIViewController*)controller WithTitle:(NSString*)title WithMessage:(NSString*)message  WithCanncelButtonTitle:(NSString*)canncelButtonTitle otherButtonTitles:(NSString*)otherBtnTitle,...{
    _controller = controller;
//    与controller 进行关联 ，防止被释放
    objc_setAssociatedObject(controller, &overviewKey, self, OBJC_ASSOCIATION_RETAIN);
    if (kVersion <9.0) {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:canncelButtonTitle otherButtonTitles:otherBtnTitle,nil];
        NSString* curStr;
        va_list list;
        if(otherBtnTitle)
        {
            //2.从第2个参数开始，依此取得所有参数的值
            va_start(list, otherBtnTitle);
            while ((curStr= va_arg(list, NSString*))){
                [alert addButtonWithTitle: curStr];
            }
            va_end(list);
        }
        
        [alert show];
    }else{
        UIAlertController* alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* canncel = [UIAlertAction actionWithTitle:canncelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
          [alertVc addAction:canncel];
        
        NSString* curStr;
        va_list list;
        if(otherBtnTitle)
        {
            
            UIAlertAction* other = [UIAlertAction actionWithTitle:otherBtnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (_alertViewblock) {
                    _alertViewblock(action.title,self);
                }
                
            }];
            [alertVc addAction:other];
            
            //2.从第2个参数开始，依此取得所有参数的值
            va_start(list, otherBtnTitle);
            while ((curStr= va_arg(list, NSString*))){
                UIAlertAction* other = [UIAlertAction actionWithTitle:curStr style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
                    if (_alertViewblock) {
                        _alertViewblock(action.title,self);
                    }
                }];
                [alertVc addAction:other];
            }
            va_end(list);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [controller presentViewController:alertVc animated:YES completion:^{
                //            解除关联
//                objc_setAssociatedObject(controller, &overviewKey, nil, OBJC_ASSOCIATION_RETAIN);
            }];
        });
        
    }

}

-(void)showActionSheetWithController:(UIViewController*)controller WithTitle:(NSString*)title WithMessage:(NSString*)message WithdestructiveButtonTitle:(NSString*)destructiveButtonTitle  WithCanncelButtonTitle:(NSString*)canncelButtonTitle otherButtonTitles:(NSString*)otherBtnTitle,...{

    _controller = controller;
    //    与controller 进行关联 ，防止被释放
    objc_setAssociatedObject(controller, &overviewKey, self, OBJC_ASSOCIATION_RETAIN);
    if (kVersion <=9.0) {
        UIActionSheet* sheet = [[UIActionSheet alloc]initWithTitle:title delegate:self cancelButtonTitle:canncelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherBtnTitle, nil];
        NSString* curStr;
        va_list list;
        if(otherBtnTitle)
        {
            //2.从第2个参数开始，依此取得所有参数的值
            va_start(list, otherBtnTitle);
            while ((curStr= va_arg(list, NSString*))){
                [sheet addButtonWithTitle:curStr];
            }
            va_end(list);
        }
        [sheet showInView:_controller.view];
        
    }else{
        UIAlertController* alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction* canncel = [UIAlertAction actionWithTitle:canncelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        [alertVc addAction:canncel];
        
        
        
        NSString* curStr;
        va_list list;
        if(otherBtnTitle)
        {
            UIAlertAction* other = [UIAlertAction actionWithTitle:otherBtnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (_alertViewblock) {
                    _alertViewblock(action.title,self);
                }
            }];
            [alertVc addAction:other];
            //2.从第2个参数开始，依此取得所有参数的值
            va_start(list, otherBtnTitle);
            while ((curStr= va_arg(list, NSString*))){
                UIAlertAction* other = [UIAlertAction actionWithTitle:curStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    if (_alertViewblock) {
                        _alertViewblock(action.title,self);
                    }
                    
                }];
                [alertVc addAction:other];
            }
            va_end(list);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [controller presentViewController:alertVc animated:YES completion:^{
                //            解除关联
//                objc_setAssociatedObject(_controller, &overviewKey, nil, OBJC_ASSOCIATION_RETAIN);
                
            }];
        });
        
    }

}

- (void)alertViewCancel:(UIAlertView *)alertView{
//    objc_setAssociatedObject(_controller, &overviewKey, nil, OBJC_ASSOCIATION_RETAIN);
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString* butTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if (_alertViewblock) {
        _alertViewblock(butTitle,self);
    }
//    objc_setAssociatedObject(_controller, &overviewKey, nil, OBJC_ASSOCIATION_RETAIN);
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 8_3) __TVOS_PROHIBITED{
    
    NSString* butTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if (_alertViewblock) {
        _alertViewblock(butTitle,self);
    }
//    objc_setAssociatedObject(_controller, &overviewKey, nil, OBJC_ASSOCIATION_RETAIN);
}

- (void)dealloc{
    
}

@end
