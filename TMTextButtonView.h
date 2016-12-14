//
//  TMTextButtonView.h
//  TravelMaster
//
//  Created by 澳达国际 on 16/9/27.
//  Copyright © 2016年 遨游大师. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMTextButtonView : UIView

@property (nonatomic, strong) NSString *title;

@property (nonatomic, copy) void (^deleteHandler)();

@property (nonatomic, strong) NSIndexPath *indexPath;

@end
