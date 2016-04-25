//
//  VideoDetailModel.h
//  WYnews
//
//  Created by zhangxiaofan on 16/4/23.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "BaseModel.h"
#import "VideoDetailRecModel.h"

@interface VideoDetailModel : BaseModel
@property (nonatomic,copy) NSString *cover;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSString *hits;
@property (nonatomic,copy) NSString *length;
@property (nonatomic,copy) NSString *m3u8Hd_url;
@property (nonatomic,copy) NSString *m3u8_url;
@property (nonatomic,copy) NSString *mp4Hd_url;
@property (nonatomic,copy) NSString *mp4_url;
@property (nonatomic,copy) NSString *playersize;
@property (nonatomic,copy) NSString *ptime;


/**
 *  推荐的信息
 */
@property (nonatomic,strong,readonly) VideoDetailRecModel *recommendModel;

@end
