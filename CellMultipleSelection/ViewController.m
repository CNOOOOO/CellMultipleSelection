//
//  ViewController.m
//  CellMultipleSelection
//
//  Created by Mac2 on 2018/11/8.
//  Copyright © 2018年 Mac2. All rights reserved.
//

#import "ViewController.h"
#import "DataTableViewCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *allDatas;
@property (nonatomic, strong) NSMutableArray *selectedDatas;

@end

@implementation ViewController

- (NSMutableArray *)allDatas {
    if (!_allDatas) {
        _allDatas = [NSMutableArray array];
    }
    return _allDatas;
}

- (NSMutableArray *)selectedDatas {
    if (!_selectedDatas) {
        _selectedDatas = [NSMutableArray array];
    }
    return _selectedDatas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"自定义多选框";
    
    for (int i=0; i<30; i++) {
        DataModel *model = [[DataModel alloc] init];
        model.number = [NSString stringWithFormat:@"%d", i];
        [self.allDatas addObject:model];
    }
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(deleteSelectedData)];
    
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithTitle:@"全选" style:UIBarButtonItemStylePlain target:self action:@selector(selectAll:)];
    self.navigationItem.rightBarButtonItems = @[rightItem, rightItem1];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edit:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self setUpTableView];
}

- (void)edit:(UIBarButtonItem *)item {
    if ([item.title isEqualToString:@"编辑"]) {
        item.title = @"取消";
        [self.tableView setEditing:YES animated:YES];
    }else {
        item.title = @"编辑";
        [self.tableView setEditing:NO animated:YES];
        [self.selectedDatas removeAllObjects];
    }
}

- (void)deleteSelectedData {
    for (DataModel *model in self.selectedDatas) {
        [self.allDatas removeObject:model];
    }
    [self.tableView reloadData];
    [self.selectedDatas removeAllObjects];
}

- (void)selectAll:(UIBarButtonItem *)item {
    if ([item.title isEqualToString:@"全选"]) {
        item.title = @"取消全选";
        for (int i = 0; i < self.allDatas.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
            DataModel *model = self.allDatas[i];
            [self.selectedDatas addObject:model];
        }
    }else {
        item.title = @"全选";
        [self.selectedDatas removeAllObjects];
        for (int i = 0; i < self.allDatas.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
        }
    }
}

- (void)setUpTableView {
    CGFloat naviHeight = (self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height);
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - naviHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[DataTableViewCell class] forCellReuseIdentifier:@"dataCell"];
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dataCell" forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    DataModel *model = self.allDatas[indexPath.row];
    cell.model = model;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DataModel *model = self.allDatas[indexPath.row];
    [self.selectedDatas addObject:model];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    DataModel *model = self.allDatas[indexPath.row];
    [self.selectedDatas removeObject:model];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
