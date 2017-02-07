//
//  waterwave.h
//  wavepathandscrollnumber
//
//  Created by mac on 17/1/14.
//  Copyright © 2017年 qzlp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Waterwave : UIView

@property (nonatomic, strong) UIColor *frontcolor;

@property (nonatomic, strong) UIColor *behindcolor;
/**波浪线的高度*/
@property (nonatomic, assign) CGFloat waterLineY;

@property (nonatomic, assign) CGFloat waveAmplitude;
/**波浪线*/
@property (nonatomic, assign) CGFloat wavepathCycle;

@end
