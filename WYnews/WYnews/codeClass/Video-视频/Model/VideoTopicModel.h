//
//  VideoTopicModel.h
//  WYnewsss
//
//  Created by zhangxiaofan on 16/4/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  用户的基本信息
 */
@interface VideoTopicModel : BaseModel
/**
 *  用户的备注
 */
@property (nonatomic,copy) NSString *alias;
/**
 *  用户的名字
 */
@property (nonatomic,copy) NSString *tname;
/**
 *  ename和tid相等，标识
 */
@property (nonatomic,copy) NSString *ename;
@property (nonatomic,copy) NSString *tid;


@end
