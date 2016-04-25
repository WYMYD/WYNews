//
//  VideoListViewCell.m
//  WYnewsss
//
//  Created by zhangxiaofan on 16/4/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "VideoListViewCell.h"

#import <UIImageView+WebCache.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
@interface VideoListViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;

@property (weak, nonatomic) IBOutlet UIImageView *coverimg;

@property (weak, nonatomic) IBOutlet UIImageView *topicImg;
@property (weak, nonatomic) IBOutlet UILabel *topicName;
@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distance;

@property (weak, nonatomic) IBOutlet UILabel *timeAndPlay;
@property (weak, nonatomic) IBOutlet UIView *detailView;

/**播放器*/
@property (nonatomic, strong)  MPMoviePlayerController *playerController;
@property (nonatomic,copy) NSString *mp4_url;
@property (weak, nonatomic) IBOutlet UIView *playV;

@property (nonatomic,copy) NSString *topicSid;

@property (nonatomic,strong) VideoListModel *model;

@end


@implementation VideoListViewCell
/**
 *  完成赋值
 */
- (void)setDataWithModel:(VideoListModel *)model
{
    self.playV.hidden = YES;
    self.titlelabel.text = model.title;
    self.mp4_url = model.mp4_url;
    self.topicSid = model.topicSid;
    self.model = model;
    [self.coverimg sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    [self.detailView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detaiClick)]];
    self.detailView.userInteractionEnabled = YES;
    [self.topicImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick)]];
    self.topicImg.userInteractionEnabled = YES;
    self.topicName.userInteractionEnabled = YES;
    [self.topicName addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick)]];
    self.view.layer.cornerRadius = 20;
    self.topicImg.layer.cornerRadius = 15;
    self.view.backgroundColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1.0];
    [self.topicImg sd_setImageWithURL:[NSURL URLWithString:model.topicImg]];
    self.topicName.text = model.topicName;
    CGSize labelSize = [self.topicName.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    self.distance.constant = (self.topicName.frame.origin.x + labelSize.width + 10);
    
    NSString *timeStr = [NSString stringWithFormat:@"%02d:%02d",[model.length intValue]/60,[model.length intValue]%60];
    NSString *playCountStr = [NSString stringWithFormat:@"%ld播放",model.playCount];
    if (model.playCount > 9999) {
        playCountStr = [NSString stringWithFormat:@"%0.1f万播放",model.playCount/10000.0];
    }
    self.timeAndPlay.text = [NSString stringWithFormat:@"%@/%@",timeStr,playCountStr];
}
/**
 *  根据标识创建cell
 */
+ (instancetype)createWithTableView:(UITableView *)tableView
{
    NSString *ID = @"Cell";
    VideoListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[VideoListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
/**
 *  点击按钮进行播放
 */
- (IBAction)playVideo:(id)sender
{
    self.playV.hidden = NO;
    self.coverimg.hidden = YES;
    _playerController = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.mp4_url]];
    _playerController.view.frame = self.playV.bounds;
    [self.playV addSubview:_playerController.view];
    [_playerController play];
}

/**
 *  响应触摸事件
 */
- (void)coverClick
{
    if (self.detail) {
        self.detail(self.topicSid);
    }
}

- (void)detaiClick
{
    NSLog(@"-----");
    if (self.play) {
        self.play(self.model);
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
