//
//  ViewController.m
//  QuestionnaireDemo
//
//  Created by mxy on 2017/8/17.
//  Copyright © 2017年 mxy. All rights reserved.
//

#import "ViewController.h"
#import "QuestionnaireViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonAction:(id)sender {

    QuestionnaireViewController *vc = [[QuestionnaireViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
