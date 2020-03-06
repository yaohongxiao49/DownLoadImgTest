//
//  YXWriteValueView.m
//  DownLoadImgTest
//
//  Created by Believer Just on 2020/2/27.
//  Copyright © 2020 Believer Just. All rights reserved.
//

#import "YXWriteValueView.h"

@implementation YXWriteValueView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self endEditing:YES];
}

#pragma mark - progress
#pragma mark - 获取列表
- (IBAction)progressGetListBtn:(UIButton *)sender {
    
    if (self.yxWriteValueViewGetListBlock) {
        self.yxWriteValueViewGetListBlock(self.saveName.text, self.downAmount.text, self.downName.text, self.saveBegainNum.text, self.downAddress.text, self.downLoadAddressBefore.text, self.downLoadAddressAfter.text, self.boolNeedNumToMakeUp.isOn);
    }
}
#pragma mark - 全部下载
- (IBAction)progressDownLoadAllBtn:(UIButton *)sender {
    
    sender.userInteractionEnabled = YES;
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    if (self.yxWriteValueViewDownLoadAllBlock) {
        self.yxWriteValueViewDownLoadAllBlock();
    }
}

@end
