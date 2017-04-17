//
//  ViewController.m
//  PullDownView
//
//  Created by Tech-zhangyangyang on 2017/4/17.
//  Copyright © 2017年 Tech-zhangyangyang. All rights reserved.
//

#import "ViewController.h"
#import "PullDownView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(40, 100,100 , 60)];
    [button setBackgroundColor:[UIColor orangeColor]];
    [button setTitle:@"有图标下拉" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [button addTarget:self action:@selector(button1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setFrame:CGRectMake(180, 100,100 , 60)];
    [button2 setBackgroundColor:[UIColor orangeColor]];
    [button2 setTitle:@"无图标下拉" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button2.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [button2 addTarget:self action:@selector(button2Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}

- (void)button1Clicked:(UIButton *)sender {
    CGPoint point = CGPointMake(sender.frame.origin.x + sender.frame.size.width/2, sender.frame.origin.y + sender.frame.size.height);
    NSArray *titles = @[@"有图iOS开发进阶1", @"价格", @"评论",@"销量", @"价格", @"评论"];
    NSArray *images = @[@"icon.png", @"icon.png", @"icon.png",@"icon.png", @"icon.png", @"icon.png"];
    PullDownView *pullDown = [[PullDownView alloc] initWithPoint:point titles:titles images:images];
    pullDown.selectRowAtIndex = ^(NSInteger index){
        NSLog(@"select index:%ld", index);
    };
    [pullDown show];
}

- (void)button2Clicked:(UIButton *)sender {
    CGPoint point = CGPointMake(sender.frame.origin.x + sender.frame.size.width/2, sender.frame.origin.y + sender.frame.size.height);
    NSArray *titles = @[@"无图iOS开发进阶1", @"无图iOS开发进阶2", @"无图iOS开发进阶3"];
    PullDownView *pullDown = [[PullDownView alloc] initWithPoint:point titles:titles images:nil];
    pullDown.selectRowAtIndex = ^(NSInteger index){
        NSLog(@"select index:%ld", index);
    };
    [pullDown show];
}

@end
