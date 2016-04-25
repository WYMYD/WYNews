//
//  DetailViewCell.m
//  WYnews
//
//  Created by zhangxiaofan on 16/4/22.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "DetailViewCell.h"
#import "VideoListModel.h"
#import <UIImageView+WebCache.h>
@interface DetailViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *coverImg;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *timeScale;


@end


@implementation DetailViewCell

+ (instancetype)createWithTableView:(UITableView *)tableView
{
    NSString *ID = @"Cell";
    DetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DetailViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)setDataWithModel:(VideoListModel *)model
{
    [self.coverImg sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    self.title.text = model.title;
    self.timeScale.text = [NSString stringWithFormat:@"%02d:%02d",[model.length intValue]/60,[model.length intValue]%60];;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
