//
//  SmileLoadingView.m
//  loading
//
//  Created by 薛佳妮 on 2018/1/29.
//  Copyright © 2018年 jiani. All rights reserved.
//

#import "SmileLoadingView.h"
#define boderW 5.f

@interface SmileLoadingView()<CAAnimationDelegate> {
    
    NSInteger _duration;

}

@property (nonatomic,strong) CAShapeLayer *smileLayer;       //微笑
@property (nonatomic,strong) CAShapeLayer *rightEyeLayer;    //右眼
@property (nonatomic,strong) CAShapeLayer *leftEyeLayer;     //左眼

@end
@implementation SmileLoadingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _duration = 1.5f;
        [self createUI];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)createUI {
    
    [self test2];
    
}

- (void)test2 {
    
    self.smileLayer.path = [self smaileBezierPath].CGPath;
    [self.layer addSublayer:self.smileLayer];
    
    self.leftEyeLayer.path = [self leftEyeBezierPath].CGPath;
    [self.layer addSublayer:self.leftEyeLayer];
    
    self.rightEyeLayer.path = [self rightEyeBezierPath].CGPath;
    [self.layer addSublayer:self.rightEyeLayer];
    
    [self loadingAnimation];
}

- (void)loadingAnimation {
    
    [self.smileLayer removeAllAnimations];
    [self.leftEyeLayer removeAllAnimations];
    [self.rightEyeLayer removeAllAnimations];
    
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue         = @0.07;
    strokeStartAnimation.toValue           = @0.25;
    strokeStartAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    strokeStartAnimation.removedOnCompletion = NO;
    strokeStartAnimation.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *strokeEndAnimation   = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue           = @0.43;
    strokeEndAnimation.toValue             = @1;
    strokeEndAnimation.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    strokeEndAnimation.removedOnCompletion = NO;
    strokeEndAnimation.fillMode = kCAFillModeForwards;
    
    
    CAAnimationGroup *strokeAniamtionGroup = [CAAnimationGroup animation];
    strokeAniamtionGroup.duration          = _duration;
    strokeAniamtionGroup.removedOnCompletion = NO;
    strokeAniamtionGroup.fillMode = kCAFillModeForwards;
    
    
    strokeAniamtionGroup.delegate          = self;
    strokeAniamtionGroup.animations        = @[strokeEndAnimation,strokeStartAnimation];
    [self.smileLayer addAnimation:strokeAniamtionGroup forKey:@"strokeAniamtionGroup"];
    
    
    //右眼动
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGPoint rightP =  [self getLocaCnter:CGPointMake(self.bounds.size.width/2, self.bounds.size.width/2) radius:self.bounds.size.width/2.f angle:320];
    
    [path addArcWithCenter:CGPointMake((self.bounds.size.width/2.f-rightP.x), (self.bounds.size.width/2.f-rightP.y))
                    radius:self.bounds.size.width/2.f
                startAngle: (2- (2/9.f)) *M_PI
                  endAngle:2 * M_PI
                 clockwise:true];
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    anim.path = [path CGPath];
    anim.removedOnCompletion = false;
    anim.fillMode = kCAFillModeForwards;
    anim.calculationMode = kCAAnimationCubic;
    anim.repeatCount = 1;
    anim.duration = _duration;
    anim.autoreverses = NO;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_rightEyeLayer addAnimation:anim forKey:@"animation"];
    
    
    //左眼动
    UIBezierPath *path1 = [[UIBezierPath alloc] init];
    CGPoint leftP =  [self getLocaCnter:CGPointMake(self.bounds.size.width/2, self.bounds.size.width/2) radius:self.bounds.size.width/2.f angle:220];
    
    [path1 addArcWithCenter:CGPointMake((self.bounds.size.width/2.f-leftP.x), (self.bounds.size.width/2.f-leftP.y))
                     radius:self.bounds.size.width/2.f
                 startAngle:(1+(2/9.f)) * M_PI
                   endAngle:(4/3.f) * M_PI
                  clockwise:true];
    
    CAKeyframeAnimation *anim1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    anim1.path = [path1 CGPath];
    anim1.removedOnCompletion = false;
    anim1.fillMode = kCAFillModeForwards;
    anim1.calculationMode = kCAAnimationCubic;
    anim1.repeatCount = 1;
    anim1.duration = _duration/2.f;
    anim1.autoreverses = NO;
    anim1.delegate = self;
    anim1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_leftEyeLayer addAnimation:anim1 forKey:@"animation"];
    
    [self performSelector:@selector(loadingAnimation1) withObject:self afterDelay:_duration-0.5f];
    
    
}

//微笑转圈
- (void)loadingAnimation1 {
    
    self.leftEyeLayer.hidden = YES;
    self.rightEyeLayer.hidden = YES;
    //微笑
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAnimation.fromValue = @(0);
    basicAnimation.toValue = @(1.5 * M_PI);
    basicAnimation.duration = _duration;
    basicAnimation.repeatCount = 1;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    
    [_smileLayer addAnimation:basicAnimation forKey:@"loadingAnimation"];
    
    
    [self performSelector:@selector(loadingAnimation2) withObject:self afterDelay:_duration];
    
    [self performSelector:@selector(loadingAnimation3) withObject:self afterDelay:_duration];
}

- (void)loadingAnimation2 {
    
    _rightEyeLayer.hidden = NO;
    _leftEyeLayer.hidden = NO;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGPoint rightP =  [self getLocaCnter:CGPointMake(self.bounds.size.width/2, self.bounds.size.width/2) radius:self.bounds.size.width/2.f angle:320];
    
    [path addArcWithCenter:CGPointMake((self.bounds.size.width/2.f-rightP.x), (self.bounds.size.width/2.f-rightP.y))
                    radius:self.bounds.size.width/2.f
                startAngle: 0 * M_PI
                  endAngle:1.5 * M_PI
                 clockwise:true];
    CAKeyframeAnimation *anim1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    anim1.path = [path CGPath];
    anim1.removedOnCompletion = false;
    anim1.fillMode = kCAFillModeForwards;
    anim1.calculationMode = kCAAnimationCubic;
    anim1.repeatCount = 1;
    anim1.duration = 0.f;
    anim1.autoreverses = NO;
    anim1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_rightEyeLayer addAnimation:anim1 forKey:@"animation"];
    
    
    UIBezierPath *path1 = [[UIBezierPath alloc] init];
    CGPoint leftP =  [self getLocaCnter:CGPointMake(self.bounds.size.width/2, self.bounds.size.width/2) radius:self.bounds.size.width/2.f angle:220];
    
    [path1 addArcWithCenter:CGPointMake((self.bounds.size.width/2.f-leftP.x), (self.bounds.size.width/2.f-leftP.y))
                     radius:self.bounds.size.width/2.f
                 startAngle:(4/3.f) * M_PI
                   endAngle:1.5 * M_PI
                  clockwise:true];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    anim.path = [path1 CGPath];
    anim.removedOnCompletion = false;
    anim.fillMode = kCAFillModeForwards;
    anim.calculationMode = kCAAnimationCubic;
    anim.repeatCount = 1;
    anim.duration = 0.f;
    anim.autoreverses = NO;
    anim.delegate = self;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_leftEyeLayer addAnimation:anim forKey:@"animation"];
    
    [self loadingAnimation4];
    
}

- (void)loadingAnimation4 {
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGPoint rightP =  [self getLocaCnter:CGPointMake(self.bounds.size.width/2, self.bounds.size.width/2)
                                  radius:self.bounds.size.width/2.f
                                   angle:320];
    
    [path addArcWithCenter:CGPointMake((self.bounds.size.width/2.f-rightP.x), (self.bounds.size.width/2.f-rightP.y))
                    radius:self.bounds.size.width/2.f
                startAngle:1.5 * M_PI
                  endAngle:(2 - (2/9.f) + 2) *M_PI
                 clockwise:true];
    CAKeyframeAnimation *anim1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    anim1.path = [path CGPath];
    anim1.removedOnCompletion = false;
    anim1.fillMode = kCAFillModeForwards;
    anim1.calculationMode = kCAAnimationCubic;
    anim1.repeatCount = 1;
    anim1.duration = _duration + 1.f;
    anim1.autoreverses = NO;
    anim1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_rightEyeLayer addAnimation:anim1 forKey:@"animation"];
    
    
    UIBezierPath *path1 = [[UIBezierPath alloc] init];
    CGPoint leftP =  [self getLocaCnter:CGPointMake(self.bounds.size.width/2, self.bounds.size.width/2)
                                 radius:self.bounds.size.width/2.f
                                  angle:220];
    
    [path1 addArcWithCenter:CGPointMake((self.bounds.size.width/2.f-leftP.x), (self.bounds.size.width/2.f-leftP.y))
                     radius:self.bounds.size.width/2.f
                 startAngle:1.5 * M_PI
                   endAngle:(1+(2/9.f)) * M_PI
                  clockwise:true];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    anim.path = [path1 CGPath];
    anim.removedOnCompletion = false;
    anim.fillMode = kCAFillModeForwards;
    anim.calculationMode = kCAAnimationCubic;
    anim.repeatCount = 1;
    anim.duration = _duration + 1.f;
    anim.autoreverses = NO;
    anim.delegate = self;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_leftEyeLayer addAnimation:anim forKey:@"animation"];
    
    [self performSelector:@selector(loadingAnimation) withObject:self afterDelay:_duration + 1.f];
}


- (void)loadingAnimation3 {
    
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue         = @0;
    strokeStartAnimation.toValue           = @0.07;
    strokeStartAnimation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    strokeStartAnimation.removedOnCompletion = NO;
    strokeStartAnimation.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *strokeEndAnimation   = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue           = @0.75;
    strokeEndAnimation.toValue             = @0.43;
    strokeEndAnimation.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    strokeEndAnimation.removedOnCompletion = NO;
    strokeEndAnimation.fillMode = kCAFillModeForwards;
    
    
    CAAnimationGroup *strokeAniamtionGroup = [CAAnimationGroup animation];
    strokeAniamtionGroup.duration          = _duration;
    strokeAniamtionGroup.removedOnCompletion = NO;
    strokeAniamtionGroup.fillMode = kCAFillModeForwards;
    
    
    strokeAniamtionGroup.delegate          = self;
    strokeAniamtionGroup.animations        = @[strokeEndAnimation,strokeStartAnimation];
    [self.smileLayer addAnimation:strokeAniamtionGroup forKey:@"strokeAniamtionGroup"];
    
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAnimation.fromValue = @(0);
    basicAnimation.toValue = @(2 * M_PI);
    basicAnimation.duration = _duration;
    basicAnimation.repeatCount = 1;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    
    [_smileLayer addAnimation:basicAnimation forKey:@"loadingAnimation"];
    
}

- (CGPoint)getLocaCnter:(CGPoint)center radius:(CGFloat)radius angle:(float)angle{
    CGFloat x2 = radius*cosf(angle*M_PI/180);
    
    CGFloat y2 = radius*sinf(angle*M_PI/180);
    
    return CGPointMake(center.x+x2, center.y + y2);
}

- (UIBezierPath *)smaileBezierPath {
    CGFloat radius = self.bounds.size.height/2;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:CGPointMake(0,0)
                          radius:radius
                      startAngle:0
                        endAngle:1.999 *M_PI
                       clockwise:YES];
    return bezierPath;
}

- (UIBezierPath *)leftEyeBezierPath {
    CGPoint leftP = [self getLocaCnter:CGPointMake(self.bounds.size.width/2, self.bounds.size.width/2)
                                radius:self.bounds.size.width/2.f
                                 angle:220];
    UIBezierPath *leftPath = [UIBezierPath bezierPath];
    [leftPath appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(leftP.x-(boderW/2), leftP.y-(boderW/2), boderW, boderW)]];
    return leftPath;
}

- (UIBezierPath *)rightEyeBezierPath {
    CGPoint rightP =  [self getLocaCnter:CGPointMake(self.bounds.size.width/2, self.bounds.size.width/2)
                                  radius:self.bounds.size.width/2.f
                                   angle:320];
    UIBezierPath *rightPath = [UIBezierPath bezierPath];
    [rightPath appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(rightP.x-(boderW/2), rightP.y-(boderW/2), boderW, boderW)]];
    return rightPath;
}

- (CAShapeLayer *)smileLayer {
    if (!_smileLayer) {
        _smileLayer = [CAShapeLayer layer];
        _smileLayer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        _smileLayer.fillColor = [UIColor clearColor].CGColor;
        _smileLayer.strokeColor = [UIColor orangeColor].CGColor;
        _smileLayer.lineCap = kCALineCapRound;
        _smileLayer.lineWidth = boderW+0.5;
        _smileLayer.strokeStart = 0.07;
        _smileLayer.strokeEnd = 0.43;
    }
    return _smileLayer;
}

- (CAShapeLayer *)leftEyeLayer {
    if (!_leftEyeLayer) {
        _leftEyeLayer = [CAShapeLayer layer];
        _leftEyeLayer.strokeColor = [UIColor orangeColor].CGColor;
        _leftEyeLayer.fillColor = [UIColor orangeColor].CGColor;
    }
    return _leftEyeLayer;
}

- (CAShapeLayer *)rightEyeLayer {
    if (!_rightEyeLayer) {
        _rightEyeLayer = [CAShapeLayer layer];
        _rightEyeLayer.strokeColor = [UIColor orangeColor].CGColor;
        _rightEyeLayer.fillColor = [UIColor orangeColor].CGColor;
    }
    return _rightEyeLayer;
}

@end
