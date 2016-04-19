//
//  VideoRecommendModel.h
//  WYnews
//
//  Created by zhangxiaofan on 16/4/19.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "BaseModel.h"

@interface VideoRecommendModel : BaseModel
/**
 *  描述左边的图片
 */
@property (nonatomic,copy) NSString *topicImg;
@property (nonatomic,copy) NSString *replyCount;
@property (nonatomic,copy) NSString *videosource;
/**
 *  视频网址
 */
@property (nonatomic,copy) NSString *mp4Hd_url;
/**
 *  描述(用到)
 */
@property (nonatomic,copy) NSString *topicDesc;
@property (nonatomic,copy) NSString *topicSid;
/**
 *  标题
 */
@property (nonatomic,copy) NSString *title;
/**
 *  遮盖图片(头像)
 */
@property (nonatomic,copy) NSString *cover;
/**
 *  播放次数
 */
@property (nonatomic,copy) NSString *playCount;
@property (nonatomic,copy) NSString *replyBoard;
@property (nonatomic,copy) NSString *replyid;
@property (nonatomic,copy) NSString *mp4_url;
/**
 *  视频时长
 */
@property (nonatomic,copy) NSString *length;
@property (nonatomic,copy) NSString *m3u8Hd_url;
/**
 *  包含相似内容视频播放网址
 */
@property (nonatomic,copy) NSString *vurl;
@property (nonatomic,copy) NSString *videoid;
@property (nonatomic,copy) NSString *m3u8_url;
@property (nonatomic,copy) NSString *topicName;


@end
