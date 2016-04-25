//
//  VideoDetailPlayController.m
//  WYnews
//
//  Created by zhangxiaofan on 16/4/22.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "VideoDetailPlayController.h"
#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>
@interface VideoDetailPlayController ()
/**播放器*/
@property (nonatomic, strong)  MPMoviePlayerController *playerController;
@property (weak, nonatomic) IBOutlet UIView *playView;
@end

@implementation VideoDetailPlayController

- (void)play
{
    _playerController = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.mp4_url]];
    _playerController.view.frame = self.playView.frame;
    [self.playView addSubview:_playerController.view];
    [_playerController play];
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self play];
    
}


@end
