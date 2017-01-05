//
//  TMProblemCell.m
//  TravelMaster
//
//  Created by 澳达国际 on 17/1/4.
//  Copyright © 2017年 遨游大师. All rights reserved.
//

#import "TMProblemCell.h"

@interface TMProblemCell ()

@property (weak, nonatomic) IBOutlet UILabel *questionLb;
@property (weak, nonatomic) IBOutlet UILabel *answerLb;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation TMProblemCell
@synthesize dataDict = _dataDict;

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.imgView setImage:[UIImage imageNamed:@"icon-more-n"]];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        [self.imgView setImage:[UIImage imageNamed:@"icon-more-h"]];
    } else {
        [self.imgView setImage:[UIImage imageNamed:@"icon-more-n"]];
    }
    self.answerLb.hidden = !selected;
    
    // Configure the view for the selected state
}

- (void)setDataDict:(NSDictionary *)dataDict {
    _dataDict = dataDict;
    
    self.questionLb.text = dataDict[@"Q"] ? :@"";
    
    NSString *answer = dataDict[@"A"] ? :@"";
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineSpacing = 12.5;
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:answer attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName: [UIColor colorWithHexString:@"999999"], NSParagraphStyleAttributeName: style}];
    self.answerLb.attributedText = attrStr;
    
}

@end
