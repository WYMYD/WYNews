//
//  VideoListModel.h
//  WYnewsss
//
//  Created by zhangxiaofan on 16/4/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoTopicModel.h"
#import "VideoRecommendModel.h"
@interface VideoListModel : BaseModel
/**
 *  用户图标
 */
@property (nonatomic,copy) NSString *topicImg;
/**
 *  评论次数
 */
@property (nonatomic,assign) NSNumber *replyCount;
@property (nonatomic,copy) NSString *videosource;
@property (nonatomic,copy) NSString *mp4Hd_url;
/**
 *  视频描述
 */
@property (nonatomic,copy) NSString *desc;

/**
 *  用户备注
 */
@property (nonatomic,copy) NSString *topicDesc;
@property (nonatomic,copy) NSString *topicSid;
/**
 *  视频的播放图片
 */
@property (nonatomic,copy) NSString *cover;
/**
 *  视频标题
 */
@property (nonatomic,copy) NSString *title;
/**
 *  播放次数
 */
@property (nonatomic,assign) NSInteger playCount;
@property (nonatomic,copy) NSString *replyBoard;
/**
 *  用户的信息
 */
@property (nonatomic,strong,readonly) VideoTopicModel *topicModel;
@property (nonatomic,copy) NSString *sectiontitle;
/**
 *  视频的备注
 */
@property (nonatomic,copy) NSString *desCription;
@property (nonatomic,copy) NSString *replyid;
/**
 *  视频的播放地址
 */
@property (nonatomic,copy) NSString *mp4_url;
/**
 *  视频的播放时间
 */
@property (nonatomic,assign) NSNumber *length;
@property (nonatomic,copy) NSString *playersize;
@property (nonatomic,copy) NSString *m3u8Hd_url;
/**
 *  用于识别不同的网址参数
 */
@property (nonatomic,copy) NSString *vid;
@property (nonatomic,copy) NSString *m3u8_url;
/**
 *  视频的时间
 */
@property (nonatomic,copy) NSString *ptime;
/**
 *  用户名字
 */
@property (nonatomic,copy) NSString *topicName;

/**
 *  推荐的信息
 */
@property (nonatomic,strong,readonly) VideoRecommendModel *recommendModel;





@end
