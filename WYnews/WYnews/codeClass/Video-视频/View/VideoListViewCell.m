//
//  VideoListViewCell.m
//  WYnewsss
//
//  Created by zhangxiaofan on 16/4/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "VideoListViewCell.h"
#import "VideoListModel.h"
#import <UIImageView+WebCache.h>
@interface VideoListViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;

@property (weak, nonatomic) IBOutlet UIImageView *coverimg;

@property (weak, nonatomic) IBOutlet UIImageView *topicImg;
@property (weak, nonatomic) IBOutlet UILabel *topicName;
@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIButton *playButton;


@end


@implementation VideoListViewCell
/**
 *  完成赋值
 */
- (void)setDataWithModel:(VideoListModel *)model
{
    self.titlelabel.text = model.title;
    [self.coverimg sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    [self.coverimg addSubview:self.playButton];
    self.view.layer.cornerRadius = 20;
    self.topicImg.layer.cornerRadius = 15;
    [self.topicImg sd_setImageWithURL:[NSURL URLWithString:model.topicImg]];
    self.topicName.text = model.topicName;
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
    NSLog(@"----");
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
