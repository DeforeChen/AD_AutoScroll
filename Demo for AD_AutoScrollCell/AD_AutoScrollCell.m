//
//  AD_AutoScrollCell.m
//  ImatationDemo
//
//  Created by Chen Defore on 2016/12/2.
//  Copyright © 2016年 Defore Chen. All rights reserved.
//

#import "AD_AutoScrollCell.h"
#import "BannerWebViewController.h"

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

@property (nonatomic,copy) NSArray <id<bannerInfo>> *modelInfoArray;
@property (nonatomic) int bannerCnt;
@property (nonatomic) PAGE_CTRL_POS position;
@property (nonatomic) NSTimeInterval displayTime;
@property (strong,nonatomic) BannerBtnCallback bannerBlk;
@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,assign) BOOL secondTimeBeginTimer;
@end


@implementation AD_AutoScrollCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                action:@selector(JumpToWeb)];//点击手势
    [self addGestureRecognizer:tapGesture];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)setParamsWithModel:(NSArray<id<bannerInfo>>*)modelArray
         pageCtrlPosition:(PAGE_CTRL_POS)position
          timeForEachPage:(NSTimeInterval)time
     tapBannerCompleteBlk:(BannerBtnCallback)blk{
    
    _modelInfoArray = modelArray;
    _position       = position;
    _displayTime    = time;
    _bannerCnt      = (int)modelArray.count;
    _bannerBlk      = blk;
    _secondTimeBeginTimer = NO;
    [self enableTimer];
    [self initUI];
}

-(void)initUI {
    // 1. config the scrollview
    self.bannerContainerScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self.bannerContainerScrollView setContentSize:CGSizeMake(3*WIDTH, HEIGHT)];
    self.bannerContainerScrollView.pagingEnabled = YES;
    self.bannerContainerScrollView.bounces       = NO;
    self.bannerContainerScrollView.showsHorizontalScrollIndicator = YES;
    self.bannerContainerScrollView.delegate         = self;
    self.bannerContainerScrollView.backgroundColor  = [UIColor blackColor];
    [self.contentView addSubview:self.bannerContainerScrollView];
    
    // 2. config the page control
    CGRect pageCtrlRect;
    switch (self.position) {
        case LEFT:
            pageCtrlRect = CGRectMake(0, self.frame.size.height-37, 20*self.bannerCnt, 37);
            break;
        case MIDDLE:
            pageCtrlRect = CGRectMake(WIDTH/2-10*self.bannerCnt, self.frame.size.height-37, 20*self.bannerCnt, 37);
            break;
        case RIGHT:
            pageCtrlRect = CGRectMake(WIDTH-20*self.bannerCnt, self.frame.size.height-37, 20*self.bannerCnt, 37);
            break;
    }
    self.bannerPageCtrl = [[UIPageControl alloc] initWithFrame:pageCtrlRect];
    self.bannerPageCtrl.numberOfPages = self.bannerCnt;
    self.bannerPageCtrl.currentPage   = 1;
    self.bannerPageCtrl.backgroundColor = [UIColor yellowColor];
    self.bannerPageCtrl.pageIndicatorTintColor = [UIColor blackColor];
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
    
    self.leftBannerImg  = [self fetchButtonWithBannerIndex:LeftBannerIndex WithFrame:LEFT_BANNER_FRAME];
    self.middleBannerImg   = [self fetchButtonWithBannerIndex:MidBannerIndex WithFrame:MID_BANNER_FRAME];
    self.rightBannerImg = [self fetchButtonWithBannerIndex:RightBannerIndex WithFrame:RIGHT_BANNER_FRAME];
    
    [self.bannerContainerScrollView addSubview:self.leftBannerImg];
    [self.bannerContainerScrollView addSubview:self.middleBannerImg];
    [self.bannerContainerScrollView addSubview:self.rightBannerImg];
}

-(UIImageView*)fetchButtonWithBannerIndex:(NSUInteger)bannerIndex
                                WithFrame:(CGRect)frame{
    UIImageView *img = [[UIImageView alloc] initWithFrame:frame];
    img.image = [self.modelInfoArray[bannerIndex] bannerImg];
    return img;
}

-(void)JumpToWeb {
    NSLog(@"get into web btn");
    [self disableTimer];
    NSString *urlStr = [_modelInfoArray[self.bannerPageCtrl.currentPage] urlStr];
    if (urlStr) {
        BannerWebViewController *bannerWebVC = [[BannerWebViewController alloc] initWithURL:urlStr];
        if (self.bannerBlk) {
            self.bannerBlk(bannerWebVC);
        }
    } else
        NSLog(@"No available URL");
}

#pragma mark Timer related
-(void)enableTimer {
    if (_displayTime != 0) {
        NSNumber *animationTime = [[NSNumber alloc] initWithFloat:0.4];
        if (_timer == nil) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:_displayTime
                                                      target:self
                                                    selector:@selector(advertisementAutoScrolling:)
                                                    userInfo:animationTime
                                                     repeats:YES];
            [_timer fire];
        }
    }
}

-(void)advertisementAutoScrolling:(NSTimer*) timer {
    if (self.secondTimeBeginTimer == NO) {
        self.secondTimeBeginTimer = YES;
    } else {
        [UIView animateWithDuration:[timer.userInfo floatValue]
                         animations:^{
                             self.bannerContainerScrollView.contentOffset = CGPointMake(WIDTH*2, 0);
                         }
                         completion:^(BOOL complete){
                             [self dealWithScroll:WIDTH*2];
                         }];
    }
}

-(void)disableTimer {
    [_timer invalidate];
    self.secondTimeBeginTimer = NO;
    _timer = nil;
}

#pragma mark ScrollView Delegate
#pragma mark -滑动结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    [self dealWithScroll:offsetX];
    [self enableTimer];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self disableTimer];
}

-(void)dealWithScroll:(CGFloat)offsetX {
    if (offsetX == 0) { // 右滑
        //若是第一张且往右滑动，currentPage要跳到最大，否则就-1
        self.bannerPageCtrl.currentPage = (self.bannerPageCtrl.currentPage == 0)?_bannerCnt-1:(self.bannerPageCtrl.currentPage-1);
    } else if (offsetX != WIDTH) { // 左滑
        //若是最后一张且往左滑动，currentPage要跳到0，否则就+1
        self.bannerPageCtrl.currentPage = (self.bannerPageCtrl.currentPage == _bannerCnt-1)?0:(self.bannerPageCtrl.currentPage+1);
    }
    
    [self reloadBannerButtons];
}
@end
