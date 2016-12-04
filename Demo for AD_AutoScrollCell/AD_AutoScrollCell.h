//
//  AD_AutoScrollCell.h
//  ImatationDemo
//
//  Created by Chen Defore on 2016/12/2.
//  Copyright © 2016年 Defore Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol bannerInfo <NSObject>
@required
@property (nonatomic,strong) UIImage *bannerImg;
@property (nonatomic,copy) NSString *urlStr;
@end

typedef enum{
    LEFT   = 0,
    MIDDLE = 1,
    RIGHT  = 2,
}
PAGE_CTRL_POS;
typedef void (^BannerBtnCallback)(UIViewController *vc);
@interface AD_AutoScrollCell : UITableViewCell

/**
 初始化
 
 @param modelArray 传入的数据模型，必须遵循 bannerInfo 协议，至少包含图片和链接
 @param pageCnt 展示的页面数
 @param position 指出pageControl的位置
 @param time 每张图展示的时间
 @param blk 当且仅当图片有对应url时跳转到对应网页
 */
-(void)setParamsWithModel: (NSArray<id<bannerInfo>>*) modelArray ///
            pageCtrlCount: (int)pageCnt
         pageCtrlPosition:(PAGE_CTRL_POS)position
          timeForEachPage:(int)time
     tapBannerCompleteBlk:(BannerBtnCallback)blk;

@end
