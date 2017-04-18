//
//  PullDownView.m
//  PullDownView
//
//  Created by Tech-zhangyangyang on 2017/4/17.
//  Copyright © 2017年 Tech-zhangyangyang. All rights reserved.
//

#import "PullDownView.h"

#define PullDownArrowHeight    10.f // 箭头的高
#define PullDownArrowCurvature 6.f  // 箭头的弯曲度 扭率
#define SPACE                  2.f  // tableview的上下左右间距
#define ROW_HEIGHT             44.f // tableview的cell高
#define PullDownTextSize       CGSizeMake(300, 100) // cell文本长度限制
#define RGB(r, g, b)           [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]

@interface PullDownView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) UIButton *handerView;
@property (nonatomic, assign) CGPoint showPoint;

@end

@implementation PullDownView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.borderColor = RGB(200, 200, 200);
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// point 箭头的x、y  titles 文本数组  images 图片数组
- (id)initWithPoint:(CGPoint)point titles:(NSArray *)titles images:(NSArray *)images {
    self = [super init];
    if (self) {
        self.showPoint  = point;
        self.titleArray = titles;
        self.imageArray = images;
        self.frame      = [self getViewFrame];
        [self addSubview:self.tableView];
    }
    return self;
}

- (CGRect)getViewFrame {
    CGRect frame = CGRectZero;
    
    // 高
    frame.size.height = self.titleArray.count * ROW_HEIGHT + SPACE + PullDownArrowHeight;
    
    // 宽
    for (NSString *titles in self.titleArray) {
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
        CGFloat width = [titles boundingRectWithSize:CGSizeMake(300, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:dic context:nil].size.width;
        frame.size.width = MAX(width, frame.size.width);
    }

    // 左边距10 + 文本长度 + 右边距40
    frame.size.width = 10 + frame.size.width + 40;

    // 如果有icon，左边距 + 图片自身宽
    if (self.titleArray.count == self.imageArray.count) {
        frame.size.width += 10 + 25 ;
    }
    
    // X
    // 设置左间隔 最小5
    frame.origin.x = self.showPoint.x - frame.size.width/2;
    if (frame.origin.x < 5) {
        frame.origin.x = 5;
    }
 
    // Y
    frame.origin.y = self.showPoint.y;
    
    return frame;
}

- (void)show {
    // 添加一个蒙层
    self.handerView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.handerView.frame = [UIScreen mainScreen].bounds;
    self.handerView.backgroundColor = [UIColor clearColor];
    [self.handerView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.handerView addSubview:self];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.handerView];
    
    CGPoint arrawPoint = [self convertPoint:self.showPoint fromView:self.handerView];
    self.layer.anchorPoint = CGPointMake(arrawPoint.x / self.frame.size.width, arrawPoint.y/self.frame.size.height);
    self.frame = [self getViewFrame];
    self.alpha = 0.f;
    self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    [UIView animateWithDuration:0.2f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.05f, 1.05f);
        self.alpha = 1.f;
    } completion:^(BOOL finished) {
      [UIView animateWithDuration:0.08f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
          self.transform  = CGAffineTransformIdentity;
      } completion:nil];
    }];
}

- (void)dismiss {
    [self dismiss:YES];
}

- (void)dismiss:(BOOL)animate {
    if (!animate) {
        [self.handerView removeFromSuperview];
        return;
    }
    [UIView animateWithDuration:0.3f animations:^{
        self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self.handerView removeFromSuperview];
    }];
}

- (UITableView *)tableView {
    if (_tableView != nil) {
        return _tableView;
    }
    CGRect rect = self.frame;
    rect.origin.x = SPACE;
    rect.origin.y = PullDownArrowHeight + SPACE;
    rect.size.width -= SPACE * 2;
    rect.size.height -= (SPACE - PullDownArrowHeight);
    _tableView = [[UITableView  alloc] initWithFrame:rect style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.alwaysBounceHorizontal = NO;
    _tableView.alwaysBounceVertical = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.scrollsToTop = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundView = [[UIView alloc] init];
    cell.backgroundView.backgroundColor = RGB(245, 245, 245);
    
    if (self.imageArray.count == self.titleArray.count) {
        cell.imageView.image = [UIImage imageNamed:[self.imageArray objectAtIndex:indexPath.row]];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.selectRowAtIndex) {
        self.selectRowAtIndex(indexPath.row);
    }
    [self dismiss:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ROW_HEIGHT;
}

//  绘制下拉展开线条
- (void)drawRect:(CGRect)rect {
    [self.borderColor set];
    CGRect frame = CGRectMake(0, 10, self.bounds.size.width, self.bounds.size.height - PullDownArrowHeight);
    float xMin = CGRectGetMinX(frame);
    float yMin = CGRectGetMinY(frame);
    float xMax = CGRectGetMaxX(frame);
    float yMax = CGRectGetMaxY(frame);
    
    CGPoint arrowPoint = [self convertPoint:self.showPoint fromView:self.handerView];
    
    UIBezierPath *pullDownPath = [UIBezierPath bezierPath];
    [pullDownPath moveToPoint:CGPointMake(xMin, yMin)];
    [pullDownPath addLineToPoint:CGPointMake(arrowPoint.x - PullDownArrowHeight, yMin)];
    [pullDownPath addCurveToPoint:arrowPoint controlPoint1:CGPointMake(arrowPoint.x - PullDownArrowHeight + PullDownArrowCurvature, yMin) controlPoint2:arrowPoint];
    [pullDownPath addCurveToPoint:CGPointMake(arrowPoint.x + PullDownArrowHeight, yMin) controlPoint1:arrowPoint controlPoint2:CGPointMake(arrowPoint.x + PullDownArrowHeight - PullDownArrowCurvature, yMin)];
    
    [pullDownPath addLineToPoint:CGPointMake(xMax, yMin)];
    [pullDownPath addLineToPoint:CGPointMake(xMax, yMax)];
    [pullDownPath addLineToPoint:CGPointMake(xMin, yMax)];
    
    [RGB(245, 245, 245) setFill];
    [pullDownPath fill];
    
    [pullDownPath closePath];
    [pullDownPath stroke];
}

@end
