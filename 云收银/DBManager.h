//
//  DBManager.h
//  云收银
//
//  Created by 黄达能 on 15/9/1.
//  Copyright (c) 2015年 黄达能. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DBObject :NSObject

@property(nonatomic,strong)NSString *email;

@property(nonatomic,strong)NSString *passWord;

@end

@interface DBManager : NSObject

+(DBManager *)shareManager;
//增 改
-(BOOL)insertDataWithModel:(DBObject *)model;
-(BOOL)updateDataWithModel:(DBObject *)model;
@end
