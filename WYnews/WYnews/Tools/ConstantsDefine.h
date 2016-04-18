//
//  ConstantsDefine.h
//  Leisure
//
//  Created by hl on 16/3/29.
//  Copyright © 2016年 hl. All rights reserved.
//

#ifndef ConstantsDefine_h
#define ConstantsDefine_h

#pragma mark -屏幕尺寸-
#define ScreenWidth     [[UIScreen mainScreen] bounds].size.width   //屏幕宽
#define ScreenHeight    [[UIScreen mainScreen] bounds].size.height  //屏幕高
#define NavigationBarHeight     44.0   //导航条高度

#pragma mark -APPKEY-
//#define UMAPPK   @"564913af67e58ed0d7005bb3"  // 友盟注册的AppKey

#pragma mark -数据库-
#define SQLITENAME           @"leisure.sqlite" // 数据库名
#define READDETAILTABLE      @"ReadDetail" // 阅读详情数据表
#define RADIODETAILTABLE     @"RadioDetail" //电台详情表名
#define RADIOPLAYLTABLE      @"RadioPlayInfo" //电台播放详情

#pragma mark -颜色-

#endif /* ConstantsDefine_h */
