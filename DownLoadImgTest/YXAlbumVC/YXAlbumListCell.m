//
//  YXAlbumListCell.m
//  DownLoadImgTest
//
//  Created by Believer Just on 2020/3/6.
//  Copyright © 2020 Believer Just. All rights reserved.
//

#import "YXAlbumListCell.h"

@implementation YXAlbumListCell

+ (instancetype)initTableView:(UITableView *)tableView {
    
    YXAlbumListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YXAlbumListCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)reloadDataWithIndexPath:(NSIndexPath *)indexPath arr:(NSMutableArray *)arr {
    
    self.nameLab.text = [NSString stringWithFormat:@"%@", arr[indexPath.row]];
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
