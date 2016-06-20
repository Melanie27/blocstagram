//
//  CircleSpinnerView.m
//  Blocstagram
//
//  Created by MELANIE MCGANNEY on 6/17/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "CircleSpinnerView.h"


@interface CircleSpinnerView ()
//add property for CAShapeLayer
@property (nonatomic, strong) CAShapeLayer *circleLayer;

@end

@implementation CircleSpinnerView



- (id)initWithFrame:(CGRect)frame
{
    
    //set default values
    self = [super initWithFrame:frame];
    if (self) {
        self.strokeThickness = 1;
        self.radius = 12;
        self.strokeColor = [UIColor purpleColor];
    }
    return self;
}

//provide hint about size
- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake((self.radius+self.strokeThickness/2+5)*2, (self.radius+self.strokeThickness/2+5)*2);
}

//create circleLayer by overriding the getter and creating it the first time it's called (lazy instantiation)

-(CAShapeLayer*) circleLayer {
    if (!_circleLayer) {
        //calculate point at center of the arc
        CGPoint arcCenter = CGPointMake(self.radius+self.strokeThickness/2+5, self.radius+self.strokeThickness/2+5);
        //spinning circle will fit inside this rectangle
        CGRect rect = CGRectMake(0, 0, arcCenter.x*2, arcCenter.y*2);
        
        //a bezier path can have straight and curved line segments
        UIBezierPath* smoothedPath = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                                    radius:self.radius
                                                                startAngle:M_PI*3/2
                                                                  endAngle:M_PI/2+M_PI*5
                                                                 clockwise:YES];
        
        //shape layer = core animation layer made from bezier path
        _circleLayer = [CAShapeLayer layer];
        _circleLayer.contentsScale = [[UIScreen mainScreen] scale];
        _circleLayer.frame = rect;
        _circleLayer.fillColor = [UIColor clearColor].CGColor;
        _circleLayer.strokeColor = self.strokeColor.CGColor;
        _circleLayer.lineWidth = self.strokeThickness;
        //lineCap specifies the shape of the ends of the line
        _circleLayer.lineCap = kCALineCapRound;
        _circleLayer.lineJoin = kCALineJoinBevel;
        _circleLayer.path = smoothedPath.CGPath;
        
        //mask layer -- assign the circular path to the layer
        CALayer *maskLayer = [CALayer layer];
        maskLayer.contents = (id)[[UIImage imageNamed:@"angle-mask"] CGImage];
        maskLayer.frame = _circleLayer.bounds;
        _circleLayer.mask = maskLayer;
        
        
        //animate the mask in a circular motion
        CFTimeInterval animationDuration = 1;
        CAMediaTimingFunction *linearCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        //specify rotation from 0 to π * 2 (one full circle turn)
        animation.fromValue = @0;
        animation.toValue = @(M_PI*2);
        animation.duration = animationDuration;
        animation.timingFunction = linearCurve;
        animation.removedOnCompletion = NO;
        animation.repeatCount = INFINITY;
        //fillmode specifies what happens when animation is complete
        animation.fillMode = kCAFillModeForwards;
        animation.autoreverses = NO;
        [_circleLayer.mask addAnimation:animation forKey:@"rotate"];
        
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        animationGroup.duration = animationDuration;
        animationGroup.repeatCount = INFINITY;
        animationGroup.timingFunction = linearCurve;
        
        CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        strokeStartAnimation.fromValue = @0.015;
        strokeStartAnimation.toValue = @0.515;
        
        CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        strokeEndAnimation.fromValue = @0.485;
        strokeEndAnimation.toValue = @0.985;
        
        animationGroup.animations = @[strokeStartAnimation, strokeEndAnimation];
        [_circleLayer addAnimation:animationGroup forKey:@"progress"];
        
    }
    
    return _circleLayer;
}

//position the animation properly

-(void)layoutAnimatedLayer {
    [self.layer addSublayer:self.circleLayer];
    //position the circle layer in th ecenter of the view
    self.circleLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}


//when we add a subview to another view this method will perform the reaction
- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview != nil) {
        [self layoutAnimatedLayer];
    } else {
        [self.circleLayer removeFromSuperlayer];
        self.circleLayer = nil;
    }
}

//update the position of the layer if the frame changes
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    if (self.superview != nil) {
        [self layoutAnimatedLayer];
    }
}

//if we change the radius of the circle it will affect positioning. update positioning by overriding the setter(setRadius:) to create the circle layer

- (void)setRadius:(CGFloat)radius {
    _radius = radius;
    
    [_circleLayer removeFromSuperlayer];
    _circleLayer = nil;
    
    [self layoutAnimatedLayer];
}

- (void)setStrokeColor:(UIColor *)strokeColor {
    _strokeColor = strokeColor;
    _circleLayer.strokeColor = strokeColor.CGColor;
}

- (void)setStrokeThickness:(CGFloat)strokeThickness {
    _strokeThickness = strokeThickness;
    _circleLayer.lineWidth = _strokeThickness;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




@end
