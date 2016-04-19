//
//  VideoPlayController.m
//  WYnews
//
//  Created by zhangxiaofan on 16/4/19.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "VideoPlayController.h"
#import <AVFoundation/AVFoundation.h>
@interface VideoPlayController ()
@property (nonatomic,strong) AVPlayer *player;
@property (weak, nonatomic) IBOutlet UIView *videoView;

@end

@implementation VideoPlayController

- (void)requestData
{
    NSString *urlString = [NSString stringWithFormat:@"http://c.3g.163.com/nc/video/detail/%@.html",self.vid];
    [NetWorkRequestManager requestWithType:GET urlString:urlString parDic:nil finish:^(NSData *data) {
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dataDic);
    } error:^(NSError *error) {
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    NSURL *url = [NSURL URLWithString:self.playUrl];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    self.player = [[AVPlayer alloc] initWithPlayerItem:item];
    /**
     *  创建图层 作为视频播放的载体
     */
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    layer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300);
    /**
     *  使播放内容适应播放窗口的大小
     */
    layer.videoGravity = AVLayerVideoGravityResizeAspect;
//    layer.backgroundColor = [UIColor ].CGColor;
    [self.view.layer addSublayer:layer];
    
    [self.player play];

    // Do any additional setup after loading the view from its nib.
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
