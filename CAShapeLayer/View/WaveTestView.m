//
//  WaveTestView.m
//  CAShapeLayer
//
//  Created by LOLITA on 17/6/25.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import "WaveTestView.h"

@interface WaveTestView ()

@property (nonatomic, strong) UIImageView *grayImageView;
@property (nonatomic, strong) UIImageView *sineImageView;
@property (nonatomic, strong) CAShapeLayer *waveSinLayer;
@property (nonatomic, strong) CADisplayLink *displayLink;
//波浪相关的参数
@property (nonatomic, assign) CGFloat waveWidth;
@property (nonatomic, assign) CGFloat waveHeight;

@property (nonatomic, assign) CGFloat maxAmplitude;  //峰值
@property (nonatomic, assign) CGFloat frequency;     //角速度

@property (nonatomic, assign) CGFloat phaseShift;
@property (nonatomic, assign) CGFloat phase;         //初相参数

@end

static CGFloat kWavePositionDuration = 5.0 ;

@implementation WaveTestView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupSubViews];
        
        [self start];
    }
    
    return self;
}




#pragma mark - Public Methods
- (void)start
{
    [_displayLink invalidate];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self
                                                   selector:@selector(updateWave:)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop]
                       forMode:NSRunLoopCommonModes];
    
    CGPoint position = self.waveSinLayer.position;
    position.y = position.y - self.bounds.size.height - 10;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:self.waveSinLayer.position];
    animation.toValue = [NSValue valueWithCGPoint:position];
    animation.duration = kWavePositionDuration;
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    [self.waveSinLayer addAnimation:animation forKey:@"positionWave"];
    
    
    self.grayImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.grayImageView.image = [UIImage imageNamed:@"du.png"];
    [self addSubview:self.grayImageView];
    
    self.sineImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.sineImageView.image = [UIImage imageNamed:@"blue.png"];
    [self addSubview:self.sineImageView];
    // 给图片加上遮罩
    self.sineImageView.layer.mask = self.waveSinLayer;
}



- (void)updateWave:(CADisplayLink *)displayLink
{
    self.phase += self.phaseShift;
    self.waveSinLayer.path = [self createSinPath].CGPath;
}



#pragma mark - Private Methods
- (void)setupSubViews
{
    self.waveSinLayer = [CAShapeLayer layer];
    self.waveSinLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.waveSinLayer.fillColor = [[UIColor greenColor] CGColor];
    self.waveSinLayer.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
    
    self.waveHeight = CGRectGetHeight(self.bounds) * 0.5;
    self.waveWidth  = CGRectGetWidth(self.bounds);
    self.frequency = 0.3;
    self.phaseShift = 8;
    self.maxAmplitude = self.waveHeight * 0.3;

}


- (UIBezierPath *)createSinPath
{
    UIBezierPath *wavePath = [UIBezierPath bezierPath];
    CGFloat endX = 0;
    for (CGFloat x = 0; x < self.waveWidth + 1; x++) {
        endX=x;
        CGFloat y = self.maxAmplitude * sinf(360.0 / self.waveWidth * (x  * M_PI / 180) * self.frequency + self.phase * M_PI/ 180) + self.maxAmplitude;
        if (x == 0) {
            [wavePath moveToPoint:CGPointMake(x, y)];
        } else {
            [wavePath addLineToPoint:CGPointMake(x, y)];
        }
    }
    
    CGFloat endY = CGRectGetHeight(self.bounds) + 10;
    [wavePath addLineToPoint:CGPointMake(endX, endY)];
    [wavePath addLineToPoint:CGPointMake(0, endY)];
    
    return wavePath;
}








@end
