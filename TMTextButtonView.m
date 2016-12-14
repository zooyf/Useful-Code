//
//  TMTextButtonView.m
//  TravelMaster
//
//  Created by 澳达国际 on 16/9/27.
//  Copyright © 2016年 遨游大师. All rights reserved.
//

#import "TMTextButtonView.h"

@interface TMTextButtonView ()

@property (strong, nonatomic) UILabel *titleLb;

@end

@implementation TMTextButtonView

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLb = ({
            UILabel *label = [[UILabel alloc] initWithFrame:frame];
            label.width -= CGRectGetHeight(frame);
            label.originX = 0;
            label.originY = 0;
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = BG_COLOR;
            label;
        });
        [self addSubview:self.titleLb];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:frame];
        btn.originX = CGRectGetMaxX(self.titleLb.frame);
        btn.originY = 0;
        btn.width = CGRectGetHeight(frame);
        [self addSubview:btn];
        [btn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:[UIImage imageNamed:@"customizeDeleteButton"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    // 圆角矩形
    UIBezierPath *roundedRectPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5];
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.path = roundedRectPath.CGPath;// 添加路径 下面三个同理
    layer.strokeColor = BG_COLOR.CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:layer];
    
    // 竖线
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    CGFloat x = rect.size.width-rect.size.height;
    CGFloat y = rect.size.height * 0.8;
    [linePath moveToPoint:CGPointMake(x, y)];
    [linePath addLineToPoint:CGPointMake(x, rect.size.height-y)];
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.path = linePath.CGPath;
    lineLayer.strokeColor = BG_COLOR.CGColor;
    [self.layer addSublayer:lineLayer];
    
}

- (void)deleteAction:(id)sender {
    
    if (self.deleteHandler) {
        self.deleteHandler();
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLb.text = title;
}

@end
