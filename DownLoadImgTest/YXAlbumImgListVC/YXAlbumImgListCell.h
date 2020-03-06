//
//  YXAlbumImgListCell.h
//  DownLoadImgTest
//
//  Created by Believer Just on 2020/3/6.
//  Copyright © 2020 Believer Just. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXAlbumImgListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgVLayoutConstraintHeight;

+ (instancetype)initTableView:(UITableView *)tableView;
- (void)reloadDataWithIndexPath:(NSIndexPath *)indexPath arr:(NSMutableArray *)arr;

@end

NS_ASSUME_NONNULL_END
