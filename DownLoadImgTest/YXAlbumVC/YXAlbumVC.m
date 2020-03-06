//
//  YXAlbumVC.m
//  DownLoadImgTest
//
//  Created by Believer Just on 2020/3/6.
//  Copyright © 2020 Believer Just. All rights reserved.
//

#import "YXAlbumVC.h"
#import "YXAlbumListCell.h"
#import "YXAlbumImgListVC.h"

@interface YXAlbumVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArr;

@end

@implementation YXAlbumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"图片库";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initView];
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSourceArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YXAlbumListCell *cell = [YXAlbumListCell initTableView:tableView];
    [cell reloadDataWithIndexPath:indexPath arr:_dataSourceArr];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *documentPaths = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *folderName = [NSString stringWithFormat:@"%@", _dataSourceArr[indexPath.row]];
    NSString *savePath = [NSString stringWithFormat:@"%@/%@", documentPaths, folderName];
    
    YXAlbumImgListVC *vc = [[YXAlbumImgListVC alloc] init];
    vc.savePath = savePath;
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01f;
}

#pragma mark - 初始化视图
- (void)initView {
    
    NSString *documentPaths = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //获取沙盒目录文件夹下的文件夹列表
    NSError *error = nil;
    NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentPaths error:&error]];
    [arr enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj containsString:@".DS_Store"]) {
            [arr removeObject:obj];
        }
    }];
    _dataSourceArr = arr;
    [self.tableView reloadData];
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 40;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        [self.view addSubview:_tableView];
        
        [_tableView registerNib:[UINib nibWithNibName:[YXAlbumListCell.class description] bundle:nil] forCellReuseIdentifier:NSStringFromClass([YXAlbumListCell class])];
    }
    return _tableView;
}

@end
