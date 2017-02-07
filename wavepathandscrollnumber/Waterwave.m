//
//  waterwave.m
//  wavepathandscrollnumber
//
//  Created by mac on 17/1/14.
//  Copyright © 2017年 qzlp. All rights reserved.
//

#import "Waterwave.h"

@interface Waterwave ()

@property (nonatomic, assign) BOOL increase;

@property (nonatomic, strong) CADisplayLink *waveDisplayLink;

@end

@implementation Waterwave

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor grayColor]];
        self.waveAmplitude=3.0;
        self.wavepathCycle=1.0;
        self.increase=NO;
        self.frontcolor=[UIColor colorWithRed:11/255.0f green:153/255.0f blue:226/255.0f alpha:1];
        self.behindcolor = [UIColor colorWithRed:9/255.0f green:144/255.0f blue:215/255.0f alpha:1];
        
        
        self.waveDisplayLink=[CADisplayLink displayLinkWithTarget:self selector:@selector(runWave)];
        [self.waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)setWaterLineY:(CGFloat)waterLineY {
    waterLineY= self.frame.size.height - waterLineY;
    _waterLineY = waterLineY;
}



-(void)runWave
{
    
    if (self.increase) {
        self.waveAmplitude += 0.02;
    }else{
        self.waveAmplitude -= 0.02;
    }
    
    
    if (self.waveAmplitude<=1) {
        self.increase = YES;
    }
    
    if (self.waveAmplitude>=1.5) {
        self.increase = NO;
    }
    
    self.wavepathCycle+=0.1;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    //初始化画布
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //推入
    CGContextSaveGState(context);
    
    
    //定义前波浪path
    CGMutablePathRef frontPath = CGPathCreateMutable();
    
    //定义后波浪path
    CGMutablePathRef backPath=CGPathCreateMutable();
    
    //定义前波浪反色path
    CGMutablePathRef frontReversePath = CGPathCreateMutable();
    
    //定义后波浪反色path
    CGMutablePathRef backReversePath=CGPathCreateMutable();
    
    //画水
    CGContextSetLineWidth(context, 1);
    
    
    //前波浪位置初始化
    float frontY=self.waterLineY;
    CGPathMoveToPoint(frontPath, NULL, 0, frontY);
    
    //前波浪反色位置初始化
    float frontReverseY=self.waterLineY;
    CGPathMoveToPoint(frontReversePath, NULL, 0,frontReverseY);
    
    //后波浪位置初始化
    float backY=self.waterLineY;
    CGPathMoveToPoint(backPath, NULL, 0, backY);
    
    //后波浪反色位置初始化
    float backReverseY=self.waterLineY;
    CGPathMoveToPoint(backReversePath, NULL, 0, backReverseY);
    
    for(float x=0;x<=320;x++){
        
        //前波浪绘制
        frontY= self.waveAmplitude * sin( x/180*M_PI + 4*self.wavepathCycle/M_PI ) * 5 + self.waterLineY;
        CGPathAddLineToPoint(frontPath, nil, x, frontY);
        
        //后波浪绘制
        backY= self.waveAmplitude * cos( x/180*M_PI + 3*self.wavepathCycle/M_PI ) * 5 + self.waterLineY;
        CGPathAddLineToPoint(backPath, nil, x, backY);
        
        
        if (x>=100) {
            
            //后波浪反色绘制
            backReverseY= _waveAmplitude * cos( x/180*M_PI + 3*self.wavepathCycle/M_PI ) * 5 + self.waterLineY;
            CGPathAddLineToPoint(backReversePath, nil, x, backReverseY);
            
            //前波浪反色绘制
            frontReverseY= _waveAmplitude * sin( x/180*M_PI + 4*self.wavepathCycle/M_PI ) * 5 + self.waterLineY;
            CGPathAddLineToPoint(frontReversePath, nil, x, frontReverseY);
        }
    }
    
    //后波浪绘制
    CGContextSetFillColorWithColor(context, [self.behindcolor CGColor]);
    CGPathAddLineToPoint(backPath, nil, 320, rect.size.height);
    CGPathAddLineToPoint(backPath, nil, 0, rect.size.height);
    CGPathAddLineToPoint(backPath, nil, 0, self.waterLineY);
    CGPathCloseSubpath(backPath);
    CGContextAddPath(context, backPath);
    CGContextFillPath(context);
    
    //推入
    CGContextSaveGState(context);
    
    //后波浪反色绘制
    CGPathAddLineToPoint(backReversePath, nil, 320, rect.size.height);
    CGPathAddLineToPoint(backReversePath, nil, 100, rect.size.height);
    CGPathAddLineToPoint(backReversePath, nil, 100, self.waterLineY);
    
    CGContextAddPath(context, backReversePath);
    CGContextClip(context);
    
    //弹出
    CGContextRestoreGState(context);
    
    //前波浪绘制
    CGContextSetFillColorWithColor(context, [self.frontcolor CGColor]);
    CGPathAddLineToPoint(frontPath, nil, 320, rect.size.height);
    CGPathAddLineToPoint(frontPath, nil, 0, rect.size.height);
    CGPathAddLineToPoint(frontPath, nil, 0, self.waterLineY);
    CGPathCloseSubpath(frontPath);
    CGContextAddPath(context, frontPath);
    CGContextFillPath(context);
    
    //推入
    CGContextSaveGState(context);
    
    
    //前波浪反色绘制
    CGPathAddLineToPoint(frontReversePath, nil, 320, rect.size.height);
    CGPathAddLineToPoint(frontReversePath, nil, 100, rect.size.height);
    CGPathAddLineToPoint(frontReversePath, nil, 100, self.waterLineY);
    
    CGContextAddPath(context, frontReversePath);
    CGContextClip(context);
    
    //推入
    CGContextSaveGState(context);
    
    
    //释放
    CGPathRelease(backPath);
    CGPathRelease(backReversePath);
    CGPathRelease(frontPath);
    CGPathRelease(frontReversePath);
    
}



@end
