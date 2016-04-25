//
//  VideoDetailController.m
//  WYnews
//
//  Created by zhangxiaofan on 16/4/22.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "VideoDetailController.h"
#import "VideoListModel.h"
#import "DetailViewCell.h"
#import "VideoDetailPlayController.h"
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>
#import <SVProgressHUD.h>
#define ZFScreenW self.view.frame.size.width
@interface VideoDetailController ()
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,copy) NSString *topicImg;
@property (nonatomic,copy) NSString *topicDesc;
@property (nonatomic,strong) NSMutableArray *mp4_urlArrar;

@end

@implementation VideoDetailController
- (NSMutableArray *)mp4_urlArrar
{
    if (!_mp4_urlArrar) {
        _mp4_urlArrar = [NSMutableArray array];
    }
    return _mp4_urlArrar;
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        self.manager = [[AFHTTPSessionManager alloc] init];
    }
    return _manager;
}

- (void)requestData
{
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
    NSString *urlString = [NSString stringWithFormat:@"http://c.3g.163.com/nc/video/list/%@/n/%ld-10.html",self.topicSid,self.count];
    [self.manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        for (NSDictionary *dic in responseObject[self.topicSid]) {
            VideoListModel *model = [[VideoListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            self.topicImg = model.topicImg;
            self.topicDesc = model.topicDesc;
            [self.dataArray addObject:model];
            [self.mp4_urlArrar addObject:model.mp4_url];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView registerNib:[UINib nibWithNibName:@"DetailViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
            self.tableView.rowHeight = 120;
            /**
             tableHeaderView添加视图
             */
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZFScreenW, 200)];
            view.backgroundColor = [UIColor blackColor];
            view.alpha = 0.5;
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(ZFScreenW / 2 - 25, 75, 50, 50)];
            [imageV sd_setImageWithURL:[NSURL URLWithString:self.topicImg]];
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 135, ZFScreenW - 20, 20)];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.text = self.topicDesc;
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.font = [UIFont systemFontOfSize:12];
            [view addSubview:titleLabel];
            [view addSubview:imageV];
            self.tableView.tableHeaderView = view;
            [self.tableView reloadData];
            if (self.count > self.dataArray.count) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        });
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    self.count = 0;
    [self setUpRefresh];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    [self requestData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewCell *cell = [DetailViewCell createWithTableView:tableView];
    VideoListModel *model = self.dataArray[indexPath.row];
    [cell setDataWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoDetailPlayController *detailPC = [[VideoDetailPlayController alloc] init];
    detailPC.mp4_url = self.mp4_urlArrar[indexPath.row];
    [self.navigationController pushViewController:detailPC animated:YES];
}


@end
