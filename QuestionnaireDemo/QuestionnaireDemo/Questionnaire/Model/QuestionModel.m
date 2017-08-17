//
//  QuestionModel.m
//  QuestionnaireDemo
//
//  Created by mxy on 2017/8/17.
//  Copyright © 2017年 mxy. All rights reserved.
//

#import "QuestionModel.h"

// 间距
#define kConmentX 10
// 每行的高度(包括竖直方向间距)
#define kConmentY 34
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@implementation QuestionModel


#pragma mark - 设定了cell的高度和图片的frame
- (CGFloat)cellHeight{
    CGFloat textW = kScreenW - 2 * kConmentX;
    CGFloat textH = [self.questionTitle boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;

    if (_questionE) {
        _cellHeight = textH + 2*kConmentX + 5*kConmentY;
    }else{
        _cellHeight = textH + 2*kConmentX + 4*kConmentY;
    }

    return _cellHeight;
}

- (CGFloat)cellHeight1{

    CGFloat textW = kScreenW - 2 * kConmentX;
    CGFloat textH = [self.questionTitle boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;

    _cellHeight1 = textH + 2 * kConmentX;

    return _cellHeight1;

}

@end
