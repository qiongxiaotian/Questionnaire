//
//  QuestionnaireViewController.m
//  QuestionnaireDemo
//
//  Created by mxy on 2017/8/17.
//  Copyright © 2017年 mxy. All rights reserved.
//

#import "QuestionnaireViewController.h"
#import <MJExtension.h>
#import "QuestionModel.h"
#import "GotoRiskCell.h"
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kObjcNull           ((id)[NSNull null])
@interface QuestionnaireViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSArray *dataArray; // 装tableViewCell组的数组

@property (nonatomic, strong) NSMutableArray *cellMarkArray;

@property (nonatomic,strong)NSMutableDictionary *indexDic;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic,strong)  NSMutableDictionary *cellDic;//放cell的标识符

@property (nonatomic, copy) NSArray *imageArray;

@end

static NSString * const question = @"GotoRiskCell";

@implementation QuestionnaireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"问卷调查";

    [self loadData:YES changeType:NO selectedIndex:1];

    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GotoRiskCell class]) bundle:nil] forCellReuseIdentifier:question];

    [self.view addSubview:self.tableView];

}

#pragma - mark 获取商品数据
- (void)loadData:(BOOL)isRefresh changeType:(BOOL)isChange selectedIndex:(long)selectedIndex{

    if (!_dataArray) {
        _dataArray = [NSArray new];
        //解析本地json文件获取数据，生产环境中从网络获取json
        NSString *path = [[NSBundle mainBundle]pathForResource:@"risk" ofType:@"json"];
        NSData *data = [[NSData alloc]initWithContentsOfFile:path];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        _dataArray = [QuestionModel mj_objectArrayWithKeyValuesArray:dict[@"question"]];

        NSLog(@"_dataArray.count = %ld", _dataArray.count);
    }
    
}

#pragma - mark TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    QuestionModel *model = self.dataArray[indexPath.section];
    // 每次先从字典中根据IndexPath取出唯一标识符
    NSString *identifier = [_cellDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
    // 如果取出的唯一标示符不存在，则初始化唯一标示符，并将其存入字典中，对应唯一标示符注册Cell
    if (identifier == nil) {
        identifier = [NSString stringWithFormat:@"%@%@", @"cell", [NSString stringWithFormat:@"%@", indexPath]];
        [_cellDic setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
        // 注册Cell
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GotoRiskCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    }

    GotoRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.row == 0) {
        cell.questionLabel.text = model.questionA;
    }else if (indexPath.row == 1){
        cell.questionLabel.text = model.questionB;
    }else if (indexPath.row == 2){
        cell.questionLabel.text = model.questionC;
    }else if (indexPath.row == 3){
        cell.questionLabel.text = model.questionD;
    }

    [cell.questionBtn setImage:[UIImage imageNamed:self.imageArray[indexPath.row]] forState:UIControlStateNormal];
    [cell.questionBtn setImage:[UIImage imageNamed:self.imageArray[indexPath.row+4]] forState:UIControlStateSelected];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    NSString *section = [NSString stringWithFormat:@"%ld",indexPath.section];

    NSInteger index = [self.indexDic[section] integerValue];

    NSLog(@"index == %ld",(long)index);
    if (index != 0) {
        GotoRiskCell *lastCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index-1 inSection:indexPath.section]];
        [lastCell.questionBtn setSelected:NO];
    }


    GotoRiskCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.questionBtn setSelected:YES];
    [self.tableView performSelector:@selector(deselectRowAtIndexPath:animated:) withObject:indexPath afterDelay:.5];
    NSLog(@"indexPath = %ld",(long)indexPath.row);
    [self.indexDic setObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1] forKey:section];

    NSLog(@"%@",self.indexDic);

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    QuestionModel *model = _dataArray[section];
    //1 自定义头部
    UIView * view=[[UIView alloc] init];
    view.backgroundColor=[UIColor lightGrayColor];
    view.layer.borderWidth=1;
    view.layer.borderColor=[UIColor whiteColor].CGColor;

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-30, 80)];
    label.font = [UIFont systemFontOfSize:14];
    label.numberOfLines = 0;
    label.text = model.questionTitle;
    [view addSubview:label];

    return view;

}




- (NSMutableArray *)cellMarkArray
{
    if (!_cellMarkArray)
    {
        _cellMarkArray = [NSMutableArray arrayWithObjects:kObjcNull, kObjcNull, kObjcNull, kObjcNull, kObjcNull, kObjcNull, kObjcNull, kObjcNull, kObjcNull, kObjcNull,nil];
    }
    return _cellMarkArray;
}
- (NSMutableDictionary *)indexDic{
    if (!_indexDic) {
        _indexDic = [NSMutableDictionary dictionary];
    }
    return _indexDic;
}

- (NSArray *)imageArray{
    if(!_imageArray){
        _imageArray = [NSArray arrayWithObjects:@"icon_a_on",@"icon_b_on",@"icon_c_on",@"icon_d_on",@"icon_a",@"icon_b",@"icon_c",@"icon_d", nil];
    }
    return _imageArray;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
