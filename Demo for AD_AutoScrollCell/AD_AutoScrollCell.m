//
//  AD_AutoScrollCell.m
//  ImatationDemo
//
//  Created by Chen Defore on 2016/12/2.
//  Copyright © 2016年 Defore Chen. All rights reserved.
//

#import "AD_AutoScrollCell.h"

#define LEFT_BANNER_FRAME CGRectMake(0, 0, WIDTH, HEIGHT)
#define MID_BANNER_FRAME CGRectMake(WIDTH, 0, WIDTH, HEIGHT)
#define RIGHT_BANNER_FRAME CGRectMake(2*WIDTH, 0, WIDTH, HEIGHT)

@interface AD_AutoScrollCell()
@property (nonatomic,strong) UIScrollView *bannerContainerScrollView;
@property (nonatomic,strong) UIPageControl *bannerPageCtrl;

// images to show on background (if you use the Reaveal to debug, you can see 3 images in it)
@property (nonatomic,strong) UIImageView *leftBannerImg;
@property (nonatomic,strong) UIImageView *middleBannerImg;
@property (nonatomic,strong) UIImageView *rightBannerImg;

@property (nonatomic,strong) NSArray <id<bannerInfo>> *modelInfoArray;
@property (nonatomic) int pageCount;
@property (nonatomic) PAGE_CTRL_POS position;
@property (nonatomic) int displayTime;

@end


@implementation AD_AutoScrollCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor redColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setParamsWithModel:(NSArray<id<bannerInfo>>*)modelArray
            pageCtrlCount:(int)pageCnt
         pageCtrlPosition:(PAGE_CTRL_POS)position
          timeForEachPage:(int)time {
    _modelInfoArray = modelArray;
    _pageCount      = pageCnt;
    _position       = position;
    _displayTime    = time;
}

@end
