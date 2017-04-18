# PullDownView
oc版本
一个用tableView实现的点击下拉展开菜单

// icon加文字
CGPoint point = CGPointMake(sender.frame.origin.x + sender.frame.size.width/2, sender.frame.origin.y + sender.frame.size.height);
NSArray *titles = @[@"有图iOS开发进阶1", @"价格", @"评论",@"销量", @"价格", @"评论"];
NSArray *images = @[@"icon.png", @"icon.png", @"icon.png",@"icon.png", @"icon.png", @"icon.png"];
PullDownView *pullDown = [[PullDownView alloc] initWithPoint:point titles:titles images:images];
pullDown.selectRowAtIndex = ^(NSInteger index){
NSLog(@"select index:%ld", index);
// do something
};
[pullDown show];

／/ 只有文字

CGPoint point = CGPointMake(sender.frame.origin.x + sender.frame.size.width/2, sender.frame.origin.y + sender.frame.size.height);
NSArray *titles = @[@"无图iOS开发进阶1", @"无图iOS开发进阶2", @"无图iOS开发进阶3"];
PullDownView *pullDown = [[PullDownView alloc] initWithPoint:point titles:titles images:nil];
pullDown.selectRowAtIndex = ^(NSInteger index){
NSLog(@"select index:%ld", index);
};
[pullDown show];

