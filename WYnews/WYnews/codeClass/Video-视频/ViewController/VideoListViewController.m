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
#import "CAPSPageMenu.h"
#import "AllViewController.h"
#define ZFScreenW self.view.frame.size.width
#define ZFScreenH self.view.frame.size.height
@interface VideoListViewController ()
@property (nonatomic,strong) NSMutableArray *titleArray;
@property (nonatomic)CAPSPageMenu *pageMenu;
@property (nonatomic,strong) NSMutableArray *tidArray;
@property (nonatomic,strong) NSMutableArray *controllerArray;

@end

@implementation VideoListViewController
- (NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}
- (NSMutableArray *)tidArray
{
    if (!_tidArray) {
        _tidArray = [NSMutableArray array];
    }
    return _tidArray;
}
- (NSMutableArray *)controllerArray
{
    if (!_controllerArray) {
        _controllerArray = [NSMutableArray array];
    }
    return _controllerArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestTitleData];
}

- (void)setControllers:(NSMutableArray *)array
{
    for (int i = 0; i < array.count; i++) {
        AllViewController *controller = [[AllViewController alloc] init];
        controller.title = self.titleArray[i];
        controller.tid = self.tidArray[i];
        [self.controllerArray addObject:controller];
        [self addChildViewController:controller];
    }
}

- (void)requestTitleData
{
    [NetWorkRequestManager requestWithType:GET urlString:@"http://c.m.163.com/nc/video/topiclist.html" parDic:nil finish:^(NSData *data) {
        NSArray *titleArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dic in titleArr) {
            VideoTitleModel *model = [[VideoTitleModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.tidArray addObject:model.tid];
            [self.titleArray addObject:model.tname];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setControllers:self.titleArray];
            NSDictionary *parameters = @{
                                         
                                         CAPSPageMenuOptionSelectionIndicatorColor: [UIColor colorWithRed:0 green:0 blue:0 alpha:0],
                                         CAPSPageMenuOptionScrollMenuBackgroundColor:[UIColor whiteColor],
                                         CAPSPageMenuOptionSelectedMenuItemLabelColor:[UIColor redColor],
                                         CAPSPageMenuOptionMenuHeight: @(40),
                                         CAPSPageMenuOptionUnselectedMenuItemLabelColor:[UIColor lightGrayColor],
                                         CAPSPageMenuOptionMenuItemWidth:@(80)
           
                                         
                                         };
            
            _pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:self.controllerArray frame:CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height) options:parameters];
            _pageMenu.menuItemFont = [UIFont systemFontOfSize:16];
            [self.view addSubview:_pageMenu.view];

        });
    } error:^(NSError *error) {
        NSLog(@"error is %@",[error localizedDescription]);
    }];
    
}
- (void)didTapGoToLeft {
    NSInteger currentIndex = self.pageMenu.currentPageIndex;
    
    if (currentIndex > 0) {
        [_pageMenu moveToPage:currentIndex - 1];
    }
}

- (void)didTapGoToRight {
    NSInteger currentIndex = self.pageMenu.currentPageIndex;
    
    if (currentIndex < self.pageMenu.controllerArray.count) {
        [self.pageMenu moveToPage:currentIndex + 1];
    }
}


@end



