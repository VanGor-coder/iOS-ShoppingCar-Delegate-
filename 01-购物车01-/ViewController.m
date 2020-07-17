//
//  ViewController.m
//  01-购物车01-
//
//  Created by GaoFan on 2020/7/9.
//  Copyright © 2020 GaoFan. All rights reserved.
//

#import "ViewController.h"
#import "JFTableViewCell.h"
#import "JFModel.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,JFTableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *Sum;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,strong) NSMutableArray *shopArr;

@end
@implementation ViewController

-(NSArray *)arr
{
    if (_arr == nil) {
        _arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wineData.plist" ofType:nil]];
        NSMutableArray *arrTemp = [NSMutableArray array];
        for (NSDictionary *dict in _arr) {
            JFModel *model = [[JFModel alloc]init];
            model.imageName = dict[@"iamgeName"];
            model.name = dict[@"name"];
            model.price = dict[@"price"];
            model.count = dict[@"count"];
            [arrTemp addObject:model];
        }
        _arr = arrTemp;
    }
    return _arr;;
}

-(NSMutableArray *)shopArr
{
    if (_shopArr == nil) {
        _shopArr = [NSMutableArray array];
    }
    return _shopArr;;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID= @"cell";
    JFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.delegate = self;
    cell.model = self.arr[indexPath.row];
    return cell;
}

//清空购物车
- (IBAction)clearShopCar
{
    //总价清零
    self.Sum.text = @"0";

    //修改模型
    for (JFModel *model in self.shopArr) {
        model.count = @"0";
    }
    
    //刷新表格
    [self.tableView reloadData];
    
    //控制购买按钮的状态
    self.buyBtn.enabled = NO;
    
    [self.shopArr removeAllObjects];
}

//结算
- (IBAction)CountPrice
{
    //打印用户购买的商品个数
    for (JFModel *model in self.shopArr) {
        NSLog(@"购买了%@件%@,共%d元",model.count,model.name,model.price.intValue* model.count.intValue);
    }
    NSLog(@"合计:%d 元",self.Sum.text.intValue);
}

#pragma -mark JFTableViewDelegate
//点击加号
- (void)jfTableViewCellDidClickPlusButton:(nonnull JFTableViewCell *)cell
{
    self.Sum.text = [NSString stringWithFormat:@"%d",self.Sum.text.intValue + cell.model.price.intValue];
    self.buyBtn.enabled = YES;
    if (![self.shopArr containsObject:cell.model]) {
        [self.shopArr addObject:cell.model];
    }
    
}
//点击减号
- (void)jfTableViewCellDidClickMinusButton:(nonnull JFTableViewCell *)cell
{
    int totalPrice = self.Sum.text.intValue - cell.model.price.intValue;
    self.Sum.text = [NSString stringWithFormat:@"%d",totalPrice];
    self.buyBtn.enabled = totalPrice > 0;
    if (cell.model.count.intValue == 0) {
        [self.shopArr removeObject:cell.model];
    }
}


@end
