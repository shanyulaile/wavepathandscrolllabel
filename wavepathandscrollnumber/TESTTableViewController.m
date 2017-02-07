//
//  TESTTableViewController.m
//  wavepathandscrollnumber
//
//  Created by mac on 17/1/14.
//  Copyright © 2017年 qzlp. All rights reserved.
//

#import "TESTTableViewController.h"
#import "Waterwave.h"
#import "UICountingLabel.h"
#import "MJRefresh.h"


@interface TESTTableViewController ()

@property (nonatomic, strong) Waterwave *waterwave;

@property (nonatomic, strong) UICountingLabel *countinglabel;

@property (nonatomic, strong) NSArray *titlearray;

@end

@implementation TESTTableViewController

- (Waterwave *)waterwave {
    if (!_waterwave) {
        self.waterwave = [[Waterwave alloc] initWithFrame:(CGRect){0, 0, self.view.bounds.size.width, 200}];
        _waterwave.frontcolor = [UIColor colorWithRed:11/255.0f green:153/255.0f blue:226/255.0f alpha:1];
        _waterwave.behindcolor = [UIColor colorWithRed:9/255.0f green:144/255.0f blue:215/255.0f alpha:1];
        _waterwave.waterLineY = 60;
        _waterwave.backgroundColor = [UIColor colorWithRed:72/255.0f green:165/255.0f blue:232/255.0f alpha:1];
    }
    return _waterwave;
}

- (UICountingLabel *)countinglabel {
    if (!_countinglabel) {
        
        UICountingLabel *myLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(20, 40, self.view.bounds.size.width - 40, 45)];
        myLabel.textAlignment = NSTextAlignmentCenter;
        myLabel.font = [UIFont fontWithName:@"Avenir Next" size:30];
        myLabel.textColor = [UIColor whiteColor];
        [self.view addSubview:myLabel];
        //设置格式
        myLabel.format = @"%.2f";
        //设置变化范围及动画时间
        [myLabel countFrom:9999.99
                             to:0.00
                   withDuration:1.0f];
        self.countinglabel = myLabel;
    }
    return _countinglabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIView *topview = [[UIView alloc] initWithFrame:(CGRect){0, 0, self.view.bounds.size.width, 200}];
    [topview addSubview:self.waterwave];
    [topview addSubview:self.countinglabel];
    __weak typeof(&*self)weakself = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakself.tableView.header endRefreshing];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself.countinglabel countFrom:9999.99
                                           to:0.00
                                 withDuration:1.0f];            
        });
    }];
    self.tableView.tableHeaderView = topview;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"test"];
    self.titlearray = @[@"资金管理", @"投资管理", @"我的优惠", @"账户设置", @"累计收益", @"余额生息", @"冻结金额"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.titlearray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = self.titlearray[indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
