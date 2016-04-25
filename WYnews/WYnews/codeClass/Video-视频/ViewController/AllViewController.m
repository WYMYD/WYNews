//
//  AllViewController.m
//  WYnews
//
//  Created by zhangxiaofan on 16/4/20.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "AllViewController.h"
#import "VideoListModel.h"
#import "VideoListViewCell.h"
#import "VideoPlayController.h"
#import "VideoDetailController.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <SVProgressHUD.h>
@interface AllViewController ()
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UINavigationController *navigationC;
@property (nonatomic,assign) int count;
//管理者
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation AllViewController

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        self.manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.tableView.rowHeight = 300;
        _dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    [self setUpRefresh];
    self.count = 10;
    self.navigationC = self.navigationController;
}
/**
 *  http://c.3g.163.com/recommend/getChanListNews?channel=T1457068979049&size=10&passport=b4zGX7HoI0CV1N8IGrI49y%2F88pTxHuZTwmTTeD89zyHL2AgtwrES0PPiPHJrLH2UePBK0dNsyevylzp8V9OOiA%3D%3D&devId=yUzLsMq8LC5WbV7nppX6OA%3D%3D&lat=giEtWXR1ZOsM5Ghzx80JYQ%3D%3D&lon=pA7AT36%2BQqzY87hAqIdY2Q%3D%3D&version=7.0&net=wifi&ts=1461377209&sign=QS4YwWqUdUYllMRsMByzsTAHvXJNizkZaRNcgCHZ4fN48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=QQ_news
 */
- (void)requestData
{
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
    NSString *urlString = [NSString stringWithFormat:@"http://c.m.163.com/nc/video/Tlist/%@/%d-10.html",self.tid,self.count];
    [self.manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        for (NSDictionary *dic in responseObject[self.tid]) {
            VideoListModel *model = [[VideoListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [model.topicModel setValuesForKeysWithDictionary:dic[@"videoTopic"]];
            [self.dataArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView registerNib:[UINib nibWithNibName:@"VideoListViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            self.tableView.backgroundColor = [UIColor blackColor];
            [self.tableView reloadData];
        });

        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [self.tableView.mj_footer endRefreshing];
        NSLog(@"error is %@",[error localizedDescription]);

    }];
}

- (void)setUpRefresh
{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreVideo)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRefresh)];
    [self.tableView.mj_header beginRefreshing];
}
/**
 *  下拉刷新
 */
- (void)loadRefresh
{
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    self.count = 0;
    [self.dataArray removeAllObjects];
    [self.tableView.mj_header endRefreshing];
    [self requestData];
}
/**
 *  上拉加载
 */
- (void)loadMoreVideo
{
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    self.count +=10;
    [self.tableView.mj_footer endRefreshing];
//    if (self.count == self.dataArray.count) {
//        [self.tableView.mj_footer endRefreshingWithNoMoreData];
//    }
    [self requestData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoListViewCell *cell = [VideoListViewCell createWithTableView:tableView];
    VideoListModel *model = self.dataArray[indexPath.row];
    [cell setDataWithModel:model];
    cell.detail = ^(NSString *topicSid){
        VideoDetailController *playV = [[VideoDetailController alloc] init];
        playV.topicSid = topicSid;
        [self.navigationC pushViewController:playV animated:YES];
    };
    cell.play = ^(VideoListModel *model){
        VideoPlayController *playV = [[VideoPlayController alloc] init];
        playV.model = model;
        [self.navigationC pushViewController:playV animated:YES];
    };
    return cell;
}

#pragma mark - Table view didSelect

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    VideoPlayController *playVC = [[VideoPlayController alloc] init];
//    VideoListModel *model = self.dataArray[indexPath.row];
//    playVC.vid = model.vid;
//    playVC.playUrl = model.mp4_url;
//    [self.navigationC pushViewController:playVC animated:YES];
//}
//

@end
