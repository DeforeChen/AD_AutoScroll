//
//  model.h
//  Demo for AD_AutoScrollCell
//
//  Created by Chen Defore on 2016/12/2.
//  Copyright © 2016年 Chen Defore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AD_AutoScrollCell.h"

@interface model : NSObject<bannerInfo>
@property (nonatomic,strong) UIImage *bannerImg;
@property (nonatomic,copy) NSString *urlStr;
@end
