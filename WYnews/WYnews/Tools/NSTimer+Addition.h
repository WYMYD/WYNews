//
//  NSTimer+Addition.h
//  WYnews
//
//  Created by lanou on 16/4/18.
//  Copyright © 2016年 hl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)

// 暂停
- (void)pauseTimer;
// 继续
- (void)resumeTimer;
// 在多少秒以后继续
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
