//
//  SearchViewController.m
//  WYnews
//
//  Created by lanou on 16/4/18.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self setupNav];
    // Do any additional setup after loading the view from its nib.
}
- (void)setupNav {
    
    self.navigationItem.title = @"新闻";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"search_icon" hightImage:@"search_icon" target:self action:@selector(tagClick)];
    self.view.backgroundColor = ArcrandomColor;
    
}

- (void)tagClick {
    SearchViewController *tags = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:tags animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
