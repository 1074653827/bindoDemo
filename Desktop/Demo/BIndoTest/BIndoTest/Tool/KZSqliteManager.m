//
//  SqliteManager.m
//  ProjectCredit
//
//  Created by KingZ on 2018/11/5.
//  Copyright © 2018 工信. All rights reserved.
//

#import "KZSqliteManager.h"
#import "Pizza.h"
#import "PizzaConfig.h"

#define DBName @"BindoDB.sqlite"



@implementation KZSqliteManager

+ (void)createDateBase{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    JQFMDB *db = [JQFMDB shareDatabase:DBName path:path];
    NSLog(@"sqlite : -- %@/%@ --",path,DBName);
    
    
    if([self createTableWithName:table_Pizza modelClass:[Pizza class]]) {
     
        NSLog(@"sqlite : -- PizzaCreated");
    }
    if([self createTableWithName:table_Toppings modelClass:[Toppings class]]) {
        
           NSLog(@"sqlite : -- PizzaCreated");
       }
    
}

+(BOOL)createTableWithName:(NSString*)name modelClass:(Class)className{
    
    return [[JQFMDB shareDatabase] jq_createTable:name dicOrModel:className];
    
}

+ (BOOL)insertTable:(NSString*)name dicOrModel:(id)params{
    
    return [[JQFMDB shareDatabase] jq_insertTable:name dicOrModel:params];
}
+ (NSArray*)insertTable:(NSString*)name dicOrModelArray:(NSArray*)array{
    
    return [[JQFMDB shareDatabase] jq_insertTable:name dicOrModelArray:array];
}

+(BOOL)updateTable:(NSString*)name dicOrModel:(id)params whereFormat:(NSString *)format, ...{
    
    return [[JQFMDB shareDatabase] jq_updateTable:name dicOrModel:params whereFormat:format];
}

+ (BOOL)executeUpdateOrInsertTable:(NSString*)name dicOrModel:(id)params whereFormat:(NSString *)format, ...{
    
    if([self lookupTable:name dicOrModel:params whereFormat:format].count>0){
        
        return [self updateTable:name dicOrModel:params whereFormat:format];
        
    }else{
        
        return [self insertTable:name dicOrModel:params];
    }
    
}


+ (NSArray *)lookupTable:(NSString *)tableName dicOrModel:(id)parameters whereFormat:(NSString *)format, ...{
    
    return [[JQFMDB shareDatabase]jq_lookupTable:tableName dicOrModel:parameters whereFormat:format];
    
}



@end
