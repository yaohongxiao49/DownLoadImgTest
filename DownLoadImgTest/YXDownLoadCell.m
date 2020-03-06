//
//  YXDownLoadCell.m
//  DownLoadImgTest
//
//  Created by Believer Just on 2020/2/27.
//  Copyright © 2020 Believer Just. All rights reserved.
//

#import "YXDownLoadCell.h"

@interface YXDownLoadCell ()

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSMutableArray *arr;

@end

@implementation YXDownLoadCell

+ (instancetype)initTableView:(UITableView *)tableView {
    
    YXDownLoadCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YXDownLoadCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)reloadDataWithIndexPath:(NSIndexPath *)indexPath arr:(NSMutableArray *)arr {
    
    _indexPath = indexPath;
    _arr = arr;
    
    self.showNameLab.text = [NSString stringWithFormat:@"%@0%@", arr[indexPath.row][kSaveName], @(indexPath.row + 1)];
    self.progressLab.text = [NSString stringWithFormat:@"%@", arr[indexPath.row][kProgressText]];
    self.progressView.progress = [arr[indexPath.row][kProgressValue] floatValue];
    [self judgeBtnShow:indexPath arr:arr];
}

#pragma mark - 判断按钮显示
- (void)judgeBtnShow:(NSIndexPath *)indexPath arr:(NSMutableArray *)arr {
    
    [self.downLoadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    switch ([arr[indexPath.row][kDownLoadType] integerValue]) {
        case 0: {
            [self.downLoadBtn setTitle:@"下载" forState:UIControlStateNormal];
            self.downLoadBtn.userInteractionEnabled = YES;
            break;
        }
        case 1: {
            [self.downLoadBtn setTitle:@"正在下载" forState:UIControlStateNormal];
            self.downLoadBtn.userInteractionEnabled = NO;
            break;
        }
        case 2: {
            [self.downLoadBtn setTitle:@"下载成功" forState:UIControlStateNormal];
            [self.downLoadBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            self.downLoadBtn.userInteractionEnabled = NO;
            break;
        }
        default:
            break;
    }
}

#pragma mark - 开始下载
- (void)begainDownLoad:(NSMutableDictionary *)dic {
    
    [dic setObject:@"1" forKey:kDownLoadType];
    if (self.yxDownLoadCellDownLoadBlock) {
        self.yxDownLoadCellDownLoadBlock(dic);
    }
}

#pragma mark - progress
#pragma mark - 点击下载按钮
- (IBAction)progressDownLoadBtn:(UIButton *)sender {
    
    NSMutableDictionary *dic = _arr[_indexPath.row];
    [self begainDownLoad:dic];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
