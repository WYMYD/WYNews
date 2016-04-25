//
//  VideoListViewCell.h
//  WYnewsss
//
//  Created by zhangxiaofan on 16/4/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoListModel.h"
@interface VideoListViewCell : UITableViewCell
+ (instancetype)createWithTableView:(UITableView *)tableView;

- (void)setDataWithModel:(BaseModel*)model;

@property (nonatomic,strong) void(^detail) (NSString *);

@property (nonatomic,strong) void(^play) (VideoListModel *);
@end
