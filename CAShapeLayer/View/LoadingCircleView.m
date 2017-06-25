//
//  LoadingCircleView.m
//  CAShapeLayer
//
//  Created by LOLITA on 17/6/25.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import "LoadingCircleView.h"

@interface LoadingCircleView()
{
    UIBezierPath *path;
    CAShapeLayer *layer;
}
@end

@implementation LoadingCircleView



-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    CGFloat progressRadian = M_PI*2*self.progress + M_PI*3/2.0;
    
    if (path==nil) {
        path = [UIBezierPath bezierPath];
    }
    
    [path moveToPoint:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width/2.0, 0)];
    [path addArcWithCenter:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0) radius:(self.viewWidth-1)/2.0 startAngle:M_PI*3/2.0 endAngle:progressRadian clockwise:YES];
    
    if (layer==nil) {
        layer = [CAShapeLayer layer];
        layer.fillColor = self.fillColor.CGColor;
    }
    
    layer.path = path.CGPath;
    [self.layer addSublayer:layer];
    
    
}


-(UIColor *)fillColor{
    if (_fillColor==nil) {
        _fillColor = [UIColor whiteColor];
    }
    return _fillColor;
}



@end
