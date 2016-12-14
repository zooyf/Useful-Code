//
//  GFWaterView.m
//  TravelMaster
//
//  Created by 澳达国际 on 16/9/26.
//  Copyright © 2016年 遨游大师. All rights reserved.
//

#import "GFWaterView.h"

@implementation GFWaterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat centerX = CGRectGetWidth(frame)/2.0;
        CGFloat centerY = CGRectGetHeight(frame)/2.0;
        self.centerPoint = CGPointMake(centerX, centerY);
        self.radius = CGRectGetWidth(frame)/2.0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {

    // 半径
    CGFloat radius = self.radius;
    // 开始角
    CGFloat startAngle = 0;
    
    // 中心点
    CGPoint point = self.centerPoint; // 中心店我手动写的,你看看怎么弄合适 自己在搞一下
    
    // 结束角
    CGFloat endAngle = 2*M_PI;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];

    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.path = path.CGPath;// 添加路径 下面三个同理
    layer.strokeColor = [UIColor colorWithWhite:1 alpha:1].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:layer];

    CAShapeLayer *layer2 = [[CAShapeLayer alloc]init];
    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:point radius:radius+5 startAngle:startAngle endAngle:endAngle clockwise:YES];
    layer2.path = path2.CGPath;
    layer2.strokeColor = [UIColor colorWithWhite:1 alpha:0.8].CGColor;
    layer2.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:layer2];
    
}

@end
