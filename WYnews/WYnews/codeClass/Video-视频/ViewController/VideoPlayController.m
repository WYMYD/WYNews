//
//  VideoPlayController.m
//  WYnews
//
//  Created by zhangxiaofan on 16/4/19.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "VideoPlayController.h"
#import "DetailViewCell.h"
#import "VideoDetailModel.h"
#import <UIImageView+WebCache.h>
@interface VideoPlayController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *playView;

@property (weak, nonatomic) IBOutlet UILabel *titLe;

@property (weak, nonatomic) IBOutlet UILabel *descriPtion;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;


@property (weak, nonatomic) IBOutlet UIView *topicView;
@property (weak, nonatomic) IBOutlet UIImageView *topicImg;
@property (weak, nonatomic) IBOutlet UILabel *tname;

@property (weak, nonatomic) IBOutlet UILabel *alias;

@property (nonatomic,strong) AFHTTPSessionManager *manager;
/**播放器*/
@property (nonatomic, strong)  MPMoviePlayerController *playerController;

@end

@implementation VideoPlayController
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        self.manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}


- (void)requestData
{
    NSString *urlString = [NSString stringWithFormat:@"http://c.3g.163.com/nc/video/detail/%@.html",self.model.vid];
    [self.manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"responseObject is %@",responseObject);
        
        for (NSDictionary *dic in responseObject[@"recommend"]) {
        
            VideoDetailModel *model = [[VideoDetailModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView registerNib:[UINib nibWithNibName:@"DetailViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
            self.tableView.rowHeight = 120;
            self.titLe.text = self.model.title;
            self.descriPtion.text = self.model.desc;
            [self.topicImg sd_setImageWithURL:[NSURL URLWithString:self.model.topicImg]];
            self.tname.text = self.model.topicModel.tname;
            self.alias.text = self.model.topicModel.alias;
            [self.tableView reloadData];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    [self play];
}

- (void)play
{
    _playerController = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.model.mp4_url]];
    _playerController.view.frame = self.playView.frame;
    [self.playView addSubview:_playerController.view];
    [_playerController play];
    
}



#pragma mark -tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewCell *cell = [DetailViewCell createWithTableView:tableView];
    VideoDetailModel *model = self.dataArray[indexPath.row];
    [cell setDataWithModel:model];
    return cell;

}


@end
