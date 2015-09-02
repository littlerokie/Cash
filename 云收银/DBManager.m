//
//  DBManager.m
//  云收银
//
//  Created by 黄达能 on 15/9/1.
//  Copyright (c) 2015年 黄达能. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"
@implementation DBObject

@end

@implementation DBManager
{
    NSLock *_lock;
    FMDatabase *_dataBase;
}
static DBManager *_DB=nil;

+(DBManager *)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (_DB==nil) {
            _DB=[[DBManager alloc]init];
        }
    });
    return _DB;
}
-(id)init
{
    if (self=[super init]) {
        NSString *path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/MyDB.db"];
        NSLog(@"%@",path);
        _dataBase=[[FMDatabase alloc]initWithPath:path];
        if ([_dataBase open]) {
            NSLog(@"打开数据库成功");
            //create table if not exists app 如果没有包含user这个表格的话 我们就创建 这句sql语句的意思
            NSString *sql=@"create table if not exists user(email varchar(32),password varchar(32))";
            BOOL isSuccess=[_dataBase executeUpdate:sql];
            if (isSuccess) {
                NSLog(@"创建表成功");
            }
            else{
                NSLog(@"create faile:%@",_dataBase.lastErrorMessage);
            }
        }
        else{
            NSLog(@"打开数据库失败");
        }
    }
    return self;
}
//增
-(BOOL)insertDataWithModel:(DBObject *)model
{
    [_lock lock];
    NSString *sql=@"insert into user(email,password) values(?,?)";
    BOOL isSuccess=[_dataBase executeUpdate:sql,model.email,model.passWord];
    if(isSuccess){
        NSLog(@"数据增加成功");
    }
    else{
        NSLog(@"增加数据失败:%@",_dataBase.lastErrorMessage);
    }
    [_lock unlock];
    return isSuccess;
}
//删
-(BOOL)deleteDataWithModel:(DBObject *)model
{
    [_lock lock];
    NSString *sql=@"delete from user where email = ?";
    BOOL isSuccess=[_dataBase executeUpdate:sql,model.email];
    if(isSuccess){
        NSLog(@"数据删除成功");
    }
    else{
        NSLog(@"删除数据失败:%@",_dataBase.lastErrorMessage);
    }
    [_lock unlock];
    return isSuccess;
}
//改
-(BOOL)updateDataWithModel:(DBObject *)model
{
    [_lock lock];
    NSString *sql=@"update app set password = ? where email = ?";
    BOOL isSuccess=[_dataBase executeUpdate:sql,model.passWord,model.email];
    if(isSuccess){
        NSLog(@"数据修改成功");
    }
    else{
        NSLog(@"修改数据失败:%@",_dataBase.lastErrorMessage);
    }
    [_lock unlock];
    return isSuccess;
}

//返回表格的所有数据
- (NSArray *)allData{
    //sql :查询这个表格的所有数据
    NSString *sql = @"select * from app";
    //得到一个结果集
    FMResultSet *set = [_dataBase executeQuery:sql];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    //set next 如果下一个结果是真的话 我们给model赋值 并且加到数组里面
    while ([set next]) {
        DBObject *model = [[DBObject alloc] init];
        model.email = [set stringForColumn:@"email"];
        model.passWord = [set stringForColumn:@"passWord"];
        [arr addObject:model];
    }
    return arr;
}
//查询里面是不是包含这个数据
- (BOOL)searchDataWithModel:(DBObject *)model{
    NSString *sql = @"select applicationId from app where email = ?";
    FMResultSet *set = [_dataBase executeQuery:sql,model.email];
    return [set next];
}

@end
