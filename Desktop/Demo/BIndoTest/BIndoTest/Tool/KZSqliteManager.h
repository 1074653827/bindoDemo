//
//  SqliteManager.h
//  ProjectCredit
//
//  Created by KingZ on 2018/11/5.
//  Copyright © 2018 工信. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JQFMDB.h"

#define table_Pizza @"Pizza"
#define table_Toppings @"Toppings"

NS_ASSUME_NONNULL_BEGIN

@interface KZSqliteManager : NSObject

+ (void)createDateBase;

+(BOOL)createTableWithName:(NSString*)name modelClass:(Class)className;

+ (NSArray*)insertTable:(NSString*)name dicOrModelArray:(NSArray*)array;

+ (BOOL)insertTable:(NSString*)name dicOrModel:(id)params;

+(BOOL)updateTable:(NSString*)name dicOrModel:(id)params whereFormat:(NSString *)format, ...;

+ (BOOL)executeUpdateOrInsertTable:(NSString*)name dicOrModel:(id)params whereFormat:(NSString *)format, ...;

+ (NSArray *)lookupTable:(NSString *)tableName dicOrModel:(id)parameters whereFormat:(NSString *)format, ...;

@end

NS_ASSUME_NONNULL_END
