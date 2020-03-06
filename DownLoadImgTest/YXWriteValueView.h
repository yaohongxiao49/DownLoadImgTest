//
//  YXWriteValueView.h
//  DownLoadImgTest
//
//  Created by Believer Just on 2020/2/27.
//  Copyright © 2020 Believer Just. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^YXWriteValueViewGetListBlock)(NSString *saveName, NSString *downAmount, NSString *downName, NSString *saveBegainNum, NSString *downAddress);
typedef void(^YXWriteValueViewDownLoadAllBlock)(void);

@interface YXWriteValueView : UIView

/** 储存文件名/图片名前缀 */
@property (weak, nonatomic) IBOutlet UITextField *saveName;
/** 下载总数 */
@property (weak, nonatomic) IBOutlet UITextField *downAmount;
/** 下载的图片名 */
@property (weak, nonatomic) IBOutlet UITextField *downName;
/** 储存文件开始数 */
@property (weak, nonatomic) IBOutlet UITextField *saveBegainNum;
/** 下载地址 */
@property (weak, nonatomic) IBOutlet UITextView *downAddress;
/** 获取列表 */
@property (weak, nonatomic) IBOutlet UIButton *getListBtn;
/** 全部下载 */
@property (weak, nonatomic) IBOutlet UIButton *downLoadAllBtn;
/** 整体下载进度 */
@property (weak, nonatomic) IBOutlet UILabel *allProgressLab;

/** 获取列表回调 */
@property (nonatomic, copy) YXWriteValueViewGetListBlock yxWriteValueViewGetListBlock;
/** 全部下载回调 */
@property (nonatomic, copy) YXWriteValueViewDownLoadAllBlock yxWriteValueViewDownLoadAllBlock;

@end

NS_ASSUME_NONNULL_END
