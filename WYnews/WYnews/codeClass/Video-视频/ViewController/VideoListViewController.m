//
//  VideoListViewController.m
//  WYnewsss
//
//  Created by zhangxiaofan on 16/4/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "VideoListViewController.h"
#import "VideoTitleModel.h"
#import "VideoListModel.h"
#import "VideoListViewCell.h"
#import "VideoPlayController.h"
@interface VideoListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *titleArray;
@property (nonatomic,strong) UIButton *firstButton;
@property (nonatomic,strong) NSMutableArray *dataArray;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollV;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation VideoListViewController
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.tableView.rowHeight = 240;
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestTitleData];
    [self requestData];
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoListViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
  
}


- (void)requestData
{
    [NetWorkRequestManager requestWithType:GET urlString:@"http://c.m.163.com/nc/video/Tlist/T1457068979049/0-10.html" parDic:nil finish:^(NSData *data) {
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dic in dataDic[@"T1457068979049"]) {
            VideoListModel *model = [[VideoListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } error:^(NSError *error) {
        NSLog(@"error is %@",[error localizedDescription]);
    }];

}

- (void)requestTitleData
{
    [NetWorkRequestManager requestWithType:GET urlString:@"http://c.m.163.com/nc/video/topiclist.html" parDic:nil finish:^(NSData *data) {
        NSArray *titleArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dic in titleArr) {
            VideoTitleModel *model = [[VideoTitleModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.titleArray addObject:model.tname];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
             self.scrollV.contentSize = CGSizeMake(20 + 70*self.titleArray.count + 20, 44);
             self.scrollV.backgroundColor = [UIColor whiteColor];
             self.scrollV.bounces = NO;
            for (int i = 0; i < self.titleArray.count; i++) {
                UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [titleButton setTitle:self.titleArray[i] forState:UIControlStateNormal];
                titleButton.titleLabel.font = [UIFont systemFontOfSize:15];
                titleButton.frame = CGRectMake((70 * i), 5, 80, 30);
                if (i == 3) {
                    titleButton.frame = CGRectMake(70 * 3 + 20, 5, 80, 30);
                }
                if (i > 3) {
                    titleButton.frame = CGRectMake((70 * 3 + 45) + 70 * (i - 3), 5, 80, 30);

                }
                [titleButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
                if (i == 1) {
                    self.firstButton = titleButton;
                }
                [titleButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                [self.scrollV addSubview:titleButton];
            }
            [self.view addSubview:self.scrollV];
        });
    } error:^(NSError *error) {
        NSLog(@"error is %@",[error localizedDescription]);
    }];

}

- (void)click:(UIButton *)button
{
    if (button!=self.firstButton) {
        button.selected = NO;
    } else {
        self.firstButton.selected = YES;
    }
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
    BaseModel *model = self.dataArray[indexPath.row];
    [cell setDataWithModel:model];
    return cell;
}

#pragma mark - Table view didSelect

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoPlayController *playVC = [[VideoPlayController alloc] init];
    VideoListModel *model = self.dataArray[indexPath.row];
    playVC.vid = model.vid;
    playVC.playUrl = model.mp4_url;
    [self.navigationController pushViewController:playVC animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
