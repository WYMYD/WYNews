//
//  ViewController.m
//  WYNews
//
//  Created by zhangxiaofan on 16/4/16.
//  Copyright © 2016年 xiaochen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *string = @"http://3g.163.com/ntes/special/0034073A/wechat_article.html?docid=BKOU87RV00963VRO&spst=0&spss=newsapp&spsf=wx&spsw=1";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:string]];
    [self.webView loadRequest:request];
    
    NSLog(@"xxx");
    NSLog(@"bbb");
    NSLog(@"zzz");
    NSLog(@"aaa");
    NSLog(@"ccc");
}

- (NSString *)getTime:(long)second
{
    NSDate *date = [NSDate date];
    NSDate *a  = [date initWithTimeIntervalSince1970:second];
    NSString *time = [a descriptionWithLocale:@""];
    NSString *timeS = [time substringToIndex:10];
    return timeS;
}



- (void)test
{
    [NetWorkrequestManage requestWithType:GET url:@"http://c.m.163.com/newstopic/list/expert/0-10.html" parameters:nil finish:^(NSData *data) {
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"dataDic is %@",dataDic);
    } error:^(NSError *error) {
        NSLog(@"error is %@",[error localizedDescription]);
    }];
}

@end
