//
//  MyTabBarViewController.m
//  WYnews
//
//  Created by lanou on 16/4/18.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "MyTabBarViewController.h"

#import "MyNavigationViewController.h"

#import "MyNewsViewController.h"

@interface MyTabBarViewController ()

@end

@implementation MyTabBarViewController

+ (void)initialize {
    //通过appearance统一设置所有uitabbaritem的文字属性
    //后面带有UI_APPEARANCE_SELECTOR的方法，都可以调用appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:(UIControlStateNormal)];
    [item setTitleTextAttributes:selectedAttrs forState:(UIControlStateSelected)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor grayColor];
    [self setupTabBar];
    
    // Do any additional setup after loading the view.
}

- (void)setupTabBar {
    [self setupChildViewController:[[MyNewsViewController alloc] init] title:@"新闻" image:@"tabbar_icon_news_normal" selectImage:@"tabbar_icon_news_highlight"];
    [self setupChildViewController:[[UIViewController alloc] init] title:@"阅读" image:@"tabbar_icon_reader_normal" selectImage:@"tabbar_icon_reader_highlight"];
    [self setupChildViewController:[[UIViewController alloc] init] title:@"视频" image:@"tabbar_icon_media_normal" selectImage:@"tabbar_icon_media_highlight"];
    [self setupChildViewController:[[UIViewController alloc] init] title:@"话题" image:@"tabbar_icon_found_normal" selectImage:@"tabbar_icon_found_highlight"];
    [self setupChildViewController:[[UIViewController alloc] init] title:@"我" image:@"tabbar_icon_me_normal" selectImage:@"tabbar_icon_me_highlight"];
    
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
    
}


- (void)setupChildViewController:(UIViewController *)viewController title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage {
    //设置文字和图片
    viewController.tabBarItem.title = title;
    viewController.navigationItem.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:image];
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    //viewController.view.backgroundColor =
    MyNavigationViewController *nav = [[MyNavigationViewController alloc] initWithRootViewController:viewController];
    viewController.view.backgroundColor = ArcrandomColor;
    [self addChildViewController:nav];
    
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
