//
//  VideoListViewCell.h
//  WYnewsss
//
//  Created by zhangxiaofan on 16/4/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoListViewCell : UITableViewCell
+ (instancetype)createWithTableView:(UITableView *)tableView;

- (void)setDataWithModel:(BaseModel*)model;
@end
