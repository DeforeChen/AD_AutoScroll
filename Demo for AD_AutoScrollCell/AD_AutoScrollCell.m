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

//屏幕尺寸
#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT self.bounds.size.height

@interface AD_AutoScrollCell()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *bannerContainerScrollView;
@property (nonatomic,strong) UIPageControl *bannerPageCtrl;

// images to show on background (if you use the Reaveal to debug, you can see 3 images in it)
@property (nonatomic,strong) UIImageView *leftBannerImg;
@property (nonatomic,strong) UIImageView *middleBannerImg;
@property (nonatomic,strong) UIImageView *rightBannerImg;

@property (nonatomic,strong) NSArray <id<bannerInfo>> *modelInfoArray;
@property (nonatomic) int pageCount;
@property (nonatomic) int bannerCnt;
@property (nonatomic) PAGE_CTRL_POS position;
@property (nonatomic) int displayTime;
@property (strong,nonatomic) BannerBtnCallback bannerBlk;
@end


@implementation AD_AutoScrollCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)setParamsWithModel:(NSArray<id<bannerInfo>>*)modelArray
            pageCtrlCount:(int)pageCnt
         pageCtrlPosition:(PAGE_CTRL_POS)position
          timeForEachPage:(int)time
     tapBannerCompleteBlk:(BannerBtnCallback)blk{
//    NSAssert(modelArray.count < pageCnt, @"illegal, model count is smaller than page-control numbers");
    if (modelArray.count < pageCnt) {
        NSLog(@"illegal, model count is smaller than page-control numbers");
        return;
    }
    
    _modelInfoArray = modelArray;
    _pageCount      = pageCnt;
    _position       = position;
    _displayTime    = time;
    _bannerCnt      = (int)modelArray.count;
    _bannerBlk      = blk;
    [self initUI];
}

-(void)initUI {
    // 1. config the scrollview
    self.bannerContainerScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self.bannerContainerScrollView setContentSize:CGSizeMake(self.pageCount*WIDTH, HEIGHT)];
    self.bannerContainerScrollView.pagingEnabled = YES;
    self.bannerContainerScrollView.delegate      = self;
    self.bannerContainerScrollView.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:self.bannerContainerScrollView];
    
    // 2. config the page control
    CGRect pageCtrlRect;
    switch (self.position) {
        case LEFT:
            pageCtrlRect = CGRectMake(0, self.frame.size.height-37, 20*self.pageCount, 37);
            break;
        case MIDDLE:
            pageCtrlRect = CGRectMake(WIDTH/2-10*self.pageCount, self.frame.size.height-37, 20*self.pageCount, 37);
            break;
        case RIGHT:
            pageCtrlRect = CGRectMake(WIDTH-20*self.pageCount, self.frame.size.height-37, 20*self.pageCount, 37);
            break;
    }
    self.bannerPageCtrl = [[UIPageControl alloc] initWithFrame:pageCtrlRect];
    self.bannerPageCtrl.numberOfPages = self.pageCount;
    self.bannerPageCtrl.currentPage   = 1;
    self.bannerPageCtrl.backgroundColor = [UIColor redColor];
    [self addSubview:self.bannerPageCtrl];
    [self reloadBannerButtons];
}

- (void)reloadBannerButtons {
    [self.leftBannerImg removeFromSuperview];
    [self.middleBannerImg removeFromSuperview];
    [self.rightBannerImg removeFromSuperview];
    
    self.bannerContainerScrollView.contentOffset = CGPointMake(WIDTH, 0);
    
    NSUInteger MidBannerIndex = self.bannerPageCtrl.currentPage;
    NSUInteger LeftBannerIndex,RightBannerIndex;
    // 取出正确的index值
    if (MidBannerIndex == 0) {
        LeftBannerIndex  = _bannerCnt-1;
        RightBannerIndex = MidBannerIndex+1;
    } else if (MidBannerIndex == _bannerCnt-1) {
        LeftBannerIndex  = MidBannerIndex - 1;
        RightBannerIndex = 0;
    } else {
        LeftBannerIndex  = MidBannerIndex - 1;
        RightBannerIndex = MidBannerIndex + 1;
    }
    
    self.leftBannerImg = [[UIImageView alloc] initWithImage:[self.modelInfoArray[LeftBannerIndex] bannerImg]];
    self.middleBannerImg = [[UIImageView alloc] initWithImage:[self.modelInfoArray[MidBannerIndex] bannerImg]];
    self.rightBannerImg = [[UIImageView alloc] initWithImage:[self.modelInfoArray[RightBannerIndex] bannerImg]];
    
    [self.bannerContainerScrollView addSubview:self.leftBannerImg];
    [self.bannerContainerScrollView addSubview:self.middleBannerImg];
    [self.bannerContainerScrollView addSubview:self.rightBannerImg];
}

#pragma mark ScrollView Delegate
#pragma mark -滑动结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    
    if (offsetX == 0) { // 右滑
        //若是第一张且往右滑动，currentPage要跳到最大，否则就-1
        self.bannerPageCtrl.currentPage = (self.bannerPageCtrl.currentPage == 0)?_pageCount-1:(self.bannerPageCtrl.currentPage-1);
    } else if (offsetX != WIDTH) { // 左滑
        //若是最后一张且往左滑动，currentPage要跳到0，否则就+1
        NSLog(@"左滑,偏移 = %f",offsetX);
        self.bannerPageCtrl.currentPage = (self.bannerPageCtrl.currentPage == _pageCount-1)?0:(self.bannerPageCtrl.currentPage+1);
        NSLog(@"最后一张，当前页码为 = %lu",self.bannerPageCtrl.currentPage);
    }
    //滑动后重载图片
    [self reloadBannerButtons];
}
@end
