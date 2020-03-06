//
//  ViewController.m
//  DownLoadImgTest
//
//  Created by Believer Just on 2020/2/27.
//  Copyright © 2020 Believer Just. All rights reserved.
//

#import "ViewController.h"
#import "YXDownLoadCell.h"
#import "YXWriteValueView.h"
#import "YXAlbumVC.h"

#define kMainScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kMainScreenHeight  [UIScreen mainScreen].bounds.size.height
#define kNewStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNewNavBarHeight 44.0
#define kNewTopHeight (kNewStatusBarHeight + kNewNavBarHeight)
#define kNewTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 83 : 49)
#define kRefreshScreen CGRectMake(0, kNewTopHeight, kMainScreenWidth, kMainScreenHeight -kNewTopHeight);

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
/** 下载地址数据数组 */
@property (nonatomic, strong) NSMutableArray *dataSourceArr;
/** 输入视图 */
@property (nonatomic, strong) YXWriteValueView *writeValueView;
/** 储存文件名/图片名前缀 */
@property (nonatomic, copy) NSString *saveName;
/** 储存文件开始数 */
@property (nonatomic, copy) NSString *saveBegainNum;
/** 是否全部下载 */
@property (nonatomic, assign) BOOL boolDownLoadAll;
/** 下载成功计数 */
@property (nonatomic, assign) NSInteger successAmount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStyleDone target:self action:@selector(progressRightBtnItem)];
    rightBtnItem.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
    [self initView];
}

#pragma mark - 组装数据
- (void)assemblyDataSourceValue:(NSString *)saveName downAmount:(NSString *)downAmount downName:(NSString *)downName saveBegainNum:(NSString *)saveBegainNum downAddress:(NSString *)downAddress beforeAddress:(NSString *)beforeAddress afterAddress:(NSString *)afterAddress boolNeedNumMakeUp:(BOOL)boolNeedNumMakeUp {
    
    _saveName = saveName;
    _saveBegainNum = saveBegainNum;
    _dataSourceArr = [[NSMutableArray alloc] init];
    NSInteger begainDownLoadNum = [downName integerValue];
    NSInteger endDownLoadNum = begainDownLoadNum + [downAmount integerValue];
    
    NSInteger saveBegainAddNum = 0;
    for (NSInteger i = begainDownLoadNum; i < endDownLoadNum; i ++) {
        NSString *numStr = [NSString stringWithFormat:@"%@", @(i)];
        NSString *downLoadNumStr = numStr;
        if (boolNeedNumMakeUp) {
            switch (5 - numStr.length) {
                case 0:
                    downLoadNumStr = [NSString stringWithFormat:@"%@", numStr];
                    break;
                case 1:
                    downLoadNumStr = [NSString stringWithFormat:@"0%@", numStr];
                    break;
                case 2:
                    downLoadNumStr = [NSString stringWithFormat:@"00%@", numStr];
                    break;
                case 3:
                    downLoadNumStr = [NSString stringWithFormat:@"000%@", numStr];
                    break;
                case 4:
                    downLoadNumStr = [NSString stringWithFormat:@"0000%@", numStr];
                    break;
                default:
                    break;
            }
        }
        
        if (beforeAddress.length != 0) downLoadNumStr = [NSString stringWithFormat:@"%@%@", beforeAddress, downLoadNumStr];
        
        NSString *downLoadAddress = [NSString stringWithFormat:@"%@/%@.%@", downAddress, downLoadNumStr, (afterAddress.length != 0 ? afterAddress : @"jpg")];
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{kSaveName:saveName, kDownLoadType:@(0), kProgressText:@"0/100", kProgressValue:@(0.0), kDownLoadAddress:downLoadAddress, kSaveBegainNum:[NSString stringWithFormat:@"%@", @([saveBegainNum integerValue] + saveBegainAddNum)]}];
        [_dataSourceArr addObject:dic];
        saveBegainAddNum++;
    }
    
    _writeValueView.allProgressLab.text = [NSString stringWithFormat:@"%@/%@", @"0", @(_dataSourceArr.count)];
    [self.view endEditing:YES];
    [self.tableView reloadData];
}


#pragma mark - progress
#pragma mark - 点击相册按钮
- (void)progressRightBtnItem {
    
    YXAlbumVC *vc = [[YXAlbumVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 弹窗
- (void)presentAlertView:(NSString *)title message:(NSString *)message {
    
    __weak typeof(self) weakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        weakSelf.writeValueView.downLoadAllBtn.userInteractionEnabled = YES;
        [weakSelf.writeValueView.downLoadAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        weakSelf.successAmount = 0;
        [weakSelf.dataSourceArr removeAllObjects];
        [weakSelf.tableView reloadData];
    }];
    [alertController addAction:sureAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 点击下载按钮
- (void)progressDownLoad:(NSMutableDictionary *)dic {
    
    __weak typeof(self) weakSelf = self;
    NSString *imgDownLoadUrl = dic[kDownLoadAddress];
    NSString *saveName = dic[kSaveName];
    NSString *saveBegainNum = dic[kSaveBegainNum];
    [self saveImg:imgDownLoadUrl saveName:saveName saveBegainNumStr:saveBegainNum valueDic:dic resultBlock:^(BOOL isSuccess) {
        
        if (isSuccess) {
            if (weakSelf.boolDownLoadAll) {
                weakSelf.successAmount ++;
                if (weakSelf.successAmount >= weakSelf.dataSourceArr.count) {
                    [weakSelf presentAlertView:@"温馨提示" message:@"全部储存成功"];
                }
            }
            else {
                [weakSelf presentAlertView:@"温馨提示" message:@"储存成功"];
            }
            weakSelf.writeValueView.allProgressLab.text = [NSString stringWithFormat:@"%@/%@", @(weakSelf.successAmount), @(weakSelf.dataSourceArr.count)];
            [dic setObject:@"2" forKey:kDownLoadType];
        }
        else {
            [dic setObject:@"0" forKey:kDownLoadType];
        }
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark - 保存图片
- (void)saveImg:(NSString *)imgUrl saveName:(NSString *)saveName saveBegainNumStr:(NSString *)saveBegainNumStr valueDic:(NSMutableDictionary *)valueDic resultBlock:(void(^)(BOOL isSuccess))resultBlock {
    
    [self webRequestWithUrlDownLoadImage:imgUrl params:valueDic success:^(UIImage *img) {
       
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *savePath = [NSString stringWithFormat:@"%@/%@", path, saveName];
        
        BOOL isDir = NO;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL existed = [fileManager fileExistsAtPath:savePath isDirectory:&isDir];
        if (!(isDir && existed)) {
            [fileManager createDirectoryAtPath:savePath withIntermediateDirectories:YES attributes:nil error:nil];
            NSLog(@"储存地址：%@", savePath);
        }
        
        NSString *imageFilePath = [NSString stringWithFormat:@"%@/%@0%@.jpg", savePath, saveName, saveBegainNumStr];
        BOOL success = [UIImageJPEGRepresentation(img, 0.5) writeToFile:imageFilePath  atomically:YES];
        if (success) {
            NSLog(@"储存成功 == %@", [NSString stringWithFormat:@"%@%@", saveName, saveBegainNumStr]);
            if (resultBlock) {
                resultBlock(YES);
            }
        }
    } fail:^(NSString *result) {
        
        NSLog(@"下载失败 == %@, result == %@", [NSString stringWithFormat:@"%@%@", saveName, saveBegainNumStr], result);
        if (resultBlock) {
            resultBlock(NO);
        }
    }];
}

#pragma mark - 下载图片
- (void)webRequestWithUrlDownLoadImage:(NSString *)url params:(NSMutableDictionary *)params success:(void(^)(id result))success fail:(void(^)(NSString * result))fail {
    
    __weak typeof(self) weakSelf = self;
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager loadImageWithURL:[NSURL URLWithString:url] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
//        NSLog(@"显示当前进度 == %@/%@", @(receivedSize), @(expectedSize));
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [params setObject:[NSString stringWithFormat:@"%@/100", @((receivedSize /expectedSize) *100)] forKey:kProgressText];
                [params setObject:@(receivedSize /expectedSize) forKey:kProgressValue];
                [weakSelf.tableView reloadData];
            });
        });
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        
        if (!error) {
            [params setObject:[NSString stringWithFormat:@"%@/100", @(100)] forKey:kProgressText];
            [params setObject:@(1) forKey:kProgressValue];
            
            success(image);
        }
        else {
            fail([error localizedDescription]);
        }
    }];
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSourceArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YXDownLoadCell *cell = [YXDownLoadCell initTableView:tableView];
    [cell reloadDataWithIndexPath:indexPath arr:_dataSourceArr];

    __weak typeof(self) weakSelf = self;
    cell.yxDownLoadCellDownLoadBlock = ^(NSMutableDictionary * _Nonnull dic) {
      
        [weakSelf progressDownLoad:dic];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [UIView new];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01f;
}

#pragma mark - 初始化视图
- (void)initView {
    
    __weak typeof(self) weakSelf = self;
    _writeValueView = [[[NSBundle mainBundle] loadNibNamed:@"YXWriteValueView" owner:self options:nil] lastObject];
    _writeValueView.frame = CGRectMake(0, kNewTopHeight, kMainScreenWidth, 240);
    [self.view addSubview:_writeValueView];
    
    _writeValueView.yxWriteValueViewGetListBlock = ^(NSString * _Nonnull saveName, NSString * _Nonnull downAmount, NSString * _Nonnull downName, NSString * _Nonnull saveBegainNum, NSString * _Nonnull downAddress, NSString * _Nonnull downAddressBefore, NSString * _Nonnull downAddressAfter, BOOL boolNeedNumMakeUp) {
        
        [weakSelf assemblyDataSourceValue:saveName downAmount:downAmount downName:downName saveBegainNum:saveBegainNum downAddress:downAddress beforeAddress:downAddressBefore afterAddress:downAddressAfter boolNeedNumMakeUp:boolNeedNumMakeUp];
    };
    _writeValueView.yxWriteValueViewDownLoadAllBlock = ^{
        
        weakSelf.boolDownLoadAll = YES;
        [weakSelf.dataSourceArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [weakSelf progressDownLoad:obj];
        }];
        [weakSelf.tableView reloadData];
    };
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_writeValueView.frame), kMainScreenWidth, kMainScreenHeight - CGRectGetMaxY(_writeValueView.frame)) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        
        [_tableView registerNib:[UINib nibWithNibName:[YXDownLoadCell.class description] bundle:nil] forCellReuseIdentifier:NSStringFromClass([YXDownLoadCell class])];
    }
    return _tableView;
}

@end
