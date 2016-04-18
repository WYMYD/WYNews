//
//  UIBarButtonItem+Extension.m
//  WYnews
//
//  Created by lanou on 16/4/18.
//  Copyright © 2016年 hl. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)itemWithImage:(NSString *)image hightImage:(NSString *)hightImage target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    
    [button setBackgroundImage:[UIImage imageNamed:hightImage] forState:(UIControlStateHighlighted)];
    button.size = button.currentBackgroundImage.size;
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

@end
