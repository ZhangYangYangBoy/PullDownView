//
//  PullDownView.h
//  PullDownView
//
//  Created by Tech-zhangyangyang on 2017/4/17.
//  Copyright © 2017年 Tech-zhangyangyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PullDownView : UIView
@property (nonatomic, copy) UIColor *borderColor;
@property (nonatomic, copy) void (^selectRowAtIndex)(NSInteger index);

- (id)initWithPoint:(CGPoint)point titles:(NSArray *)titles images:(NSArray *)images;
- (void)show;
- (void)dismiss;
- (void)dismiss:(BOOL)animated;

@end
