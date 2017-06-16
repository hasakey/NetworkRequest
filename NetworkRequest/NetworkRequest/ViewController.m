//
//  ViewController.m
//  NetworkRequest
//
//  Created by 同筑科技 on 2017/6/16.
//  Copyright © 2017年 well. All rights reserved.
//

#import "ViewController.h"
#import "IndexRequest.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,BaseRequestDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self newWorkRequest];
}

#pragma mark    METHODS
-(void)newWorkRequest
{
    IndexRequest *indexRequest = [IndexRequest new];
    indexRequest.httpDelegate = self;
    [indexRequest requestWithParameter:nil];
}

#pragma mark    BaseRequestDelegate
-(void)requestResultWithData:(id)data RequestName:(NSString *)requestName RequestResult:(RequestResult)requestResult
{
    if (requestResult == RequestSuccess) {
        
        [self.dataArray removeAllObjects];
        self.dataArray = (NSMutableArray *)[data valueForKey:@"room"];
        [self.tableView reloadData];
        
    }else
    {
        NSLog(@"请求失败");
    }
}

#pragma mark    UITableViewDelegate  AND  UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [self.dataArray[indexPath.row] valueForKey:@"name"];
    return cell;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



@end
