//
//  GotoRiskCell.h
//  QuestionnaireDemo
//
//  Created by mxy on 2017/8/17.
//  Copyright © 2017年 mxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionModel.h"

@interface GotoRiskCell : UITableViewCell

@property (nonatomic, strong) QuestionModel *model;

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIButton *questionBtn;


@end
