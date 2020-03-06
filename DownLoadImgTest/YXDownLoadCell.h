//
//  YXDownLoadCell.h
//  DownLoadImgTest
//
//  Created by Believer Just on 2020/2/27.
//  Copyright © 2020 Believer Just. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImage/UIImageView+WebCache.h"

NS_ASSUME_NONNULL_BEGIN

#define kSaveName @"saveName"
#define kDownLoadType @"downLoadType"
#define kProgressText @"progressText"
#define kProgressValue @"progressValue"
#define kDownLoadAddress @"downLoadAddress"
#define kSaveBegainNum @"saveBegainNum"

typedef void(^YXDownLoadCellDownLoadBlock)(NSMutableDictionary *dic);

@interface YXDownLoadCell : UITableViewCell

/** 显示名称 */
@property (weak, nonatomic) IBOutlet UILabel *showNameLab;
/** 下载进度 */
@property (weak, nonatomic) IBOutlet UILabel *progressLab;
/** 下载进度条 */
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
/** 下载按钮 */
@property (weak, nonatomic) IBOutlet UIButton *downLoadBtn;

/** 下载按钮回调 */
@property (nonatomic, copy) YXDownLoadCellDownLoadBlock yxDownLoadCellDownLoadBlock;

+ (instancetype)initTableView:(UITableView *)tableView;
- (void)reloadDataWithIndexPath:(NSIndexPath *)indexPath arr:(NSMutableArray *)arr;

@end

NS_ASSUME_NONNULL_END
