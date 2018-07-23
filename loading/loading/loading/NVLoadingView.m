//
//  NVLoadingView.m
//  loading
//
//  Created by 薛佳妮 on 2018/2/10.
//  Copyright © 2018年 jiani. All rights reserved.
//

#import "NVLoadingView.h"

#define NVWidth self.bounds.size.width
#define NVHeight self.bounds.size.height

@interface NVLoadingView() {
    CGFloat lineWidth;
    CGFloat duration;
    CALayer *_layer1;
}
@property (nonatomic,strong) CAShapeLayer *loadingLayer;       //微笑
@end
@implementation NVLoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        lineWidth = 10.f;
        duration = 2.f;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _layer1 = [CALayer layer];
    _layer1.frame = CGRectMake(0, 0, NVWidth, NVHeight);
    _layer1.backgroundColor = [UIColor blueColor].CGColor;
    
    self.loadingLayer.path = [self loadingBezierPath].CGPath;
    [_layer1 setMask:self.loadingLayer];
    
    //颜色渐变
    NSMutableArray *colors = [NSMutableArray arrayWithObjects:(id)[UIColor cyanColor].CGColor,(id)[[UIColor cyanColor] CGColor], nil];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.shadowPath = [self loadingBezierPath].CGPath;
    gradientLayer.frame = CGRectMake(0, 0, NVWidth, NVWidth/2.f);
    gradientLayer.startPoint = CGPointMake(1, 0);
    gradientLayer.endPoint = CGPointMake(0, 0);
    [gradientLayer setColors:[NSArray arrayWithArray:colors]];
    
    NSMutableArray *colors1 = [NSMutableArray arrayWithObjects:(id)[[UIColor cyanColor] CGColor],(id)[[UIColor whiteColor] CGColor], nil];
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.shadowPath = [self loadingBezierPath].CGPath;
    gradientLayer1.frame = CGRectMake(0, NVWidth/2.f, NVWidth, NVWidth/2.f);
    gradientLayer1.startPoint = CGPointMake(0, 1);
    gradientLayer1.endPoint = CGPointMake(1, 1);
    [gradientLayer1 setColors:[NSArray arrayWithArray:colors1]];
    [_layer1 addSublayer:gradientLayer]; //设置颜色渐变
    [_layer1 addSublayer:gradientLayer1];
    
    
    [self startLoading];
    [self.layer addSublayer:_layer1];
}

- (void)startLoading {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:2.0*M_PI];
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.duration = 1;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [_layer1 addAnimation:rotationAnimation forKey:@"rotationAnnimation"];
    
}


- (CAShapeLayer *)loadingLayer {
    if (!_loadingLayer) {
        _loadingLayer = [CAShapeLayer layer];
        _loadingLayer.fillColor = [UIColor clearColor].CGColor;
        _loadingLayer.strokeColor = [UIColor whiteColor].CGColor;
        _loadingLayer.lineWidth = lineWidth;
        _loadingLayer.strokeStart = 0;
        _loadingLayer.strokeEnd = 0.9;
        _loadingLayer.lineCap = kCALineCapRound;
        _loadingLayer.lineDashPhase = 0.8;
        
    }
    return _loadingLayer;
}


- (UIBezierPath *)loadingBezierPath {
    CGFloat radius = (NVWidth - lineWidth)/2.f;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:CGPointMake(NVWidth/2.f, NVHeight/2.f)
                          radius:radius
                      startAngle:0
                        endAngle:2 *M_PI
                       clockwise:YES];
    return bezierPath;
}

@end
