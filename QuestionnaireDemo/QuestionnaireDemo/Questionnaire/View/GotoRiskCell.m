//
//  GotoRiskCell.m
//  QuestionnaireDemo
//
//  Created by mxy on 2017/8/17.
//  Copyright © 2017年 mxy. All rights reserved.
//

#import "GotoRiskCell.h"

@implementation GotoRiskCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    [self.questionBtn setUserInteractionEnabled:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(QuestionModel *)model{
    _model = model;
}

@end
