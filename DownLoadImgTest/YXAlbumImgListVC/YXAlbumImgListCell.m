//
//  YXAlbumImgListCell.m
//  DownLoadImgTest
//
//  Created by Believer Just on 2020/3/6.
//  Copyright © 2020 Believer Just. All rights reserved.
//

#import "YXAlbumImgListCell.h"

@implementation YXAlbumImgListCell

+ (instancetype)initTableView:(UITableView *)tableView {
    
    YXAlbumImgListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YXAlbumImgListCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat proportion = 375 /[[UIScreen mainScreen] bounds].size.width;
    CGSize imgSize = self.imgV.image.size;
    self.imgVLayoutConstraintHeight.constant = imgSize.height *proportion;
}

- (void)reloadDataWithIndexPath:(NSIndexPath *)indexPath arr:(NSMutableArray *)arr {
    
    [self.imgV setImage:[UIImage imageWithContentsOfFile:arr[indexPath.row]]];
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
