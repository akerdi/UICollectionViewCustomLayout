//
//  PopAnimationViewController.m
//  TestCollectionLayout
//
//  Created by aKerdi on 2018/1/10.
//  Copyright © 2018年 XXT. All rights reserved.
//

#import "PopAnimationViewController.h"

#import "UIBezierPath+Points.h"
#import "pop.h"

@interface PopAnimationViewController ()

@property (nonatomic, strong) POPAnimatableProperty *pop;
@property (nonatomic, strong) POPBasicAnimation *animation;

@property (nonatomic, strong) CAShapeLayer *lineLayer;

@property (nonatomic, assign) CGFloat endPoint;

@end

@implementation PopAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createLineLayer];
    [self createPop];
}

- (void)createLineLayer {
    self.lineLayer = [CAShapeLayer layer];
    self.lineLayer.lineWidth = 15.f;
    self.lineLayer.frame = CGRectMake(0, 0, 10, 10);
    self.lineLayer.strokeColor = [UIColor cyanColor].CGColor;
    self.lineLayer.position = CGPointMake(100, 100);
    [self.view.layer addSublayer:self.lineLayer];
}

- (void)createPop {
    POPAnimatableProperty *property = [POPAnimatableProperty propertyWithName:@"com.TestCollectionLayout.pop" initializer:^(POPMutableAnimatableProperty *prop) {
        prop.readBlock = ^(CAShapeLayer *obj, CGFloat *values) {
            CGPoint point = CGPathGetCurrentPoint(obj.path);
            NSLog(@"kkkkkkk %@", NSStringFromCGPoint(point));
            NSLog(@"----- %f    %f",values[0], values[1]);
//            CGPoint point = CGPathGetCurrentPoint(obj.path);
//            values[0] = point.x;
//            values[1] = point.y;
        };
        prop.writeBlock = ^(CAShapeLayer *obj, const CGFloat *values) {
            CGPoint point = CGPathGetCurrentPoint(obj.path);
            NSLog(@"========= %@", NSStringFromCGPoint(point));
            NSLog(@"+++++ %f    %f",values[0], values[1]);
            obj.position = point;
        };
        prop.threshold = 0.01;
    }];
    _animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewSize];
    _animation.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 400)];
    _animation.duration = 0.4;
    _animation.property = property;
    [self.lineLayer pop_addAnimation:_animation forKey:@"animation"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (self.lineLayer) {
        UITouch *touch = [[event allTouches] anyObject];
        CGPoint location = [touch locationInView:touch.view];
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGPoint startPoint = CGPointMake(100, 100);
        [path moveToPoint:startPoint];
        CGPoint controlPoint = CGPointMake(startPoint.x+location.x, startPoint.y+location.y);
        [path addQuadCurveToPoint:location controlPoint:controlPoint];
        
        NSLog(@"ppppppp  \n%@",[path points]);
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    if (self.lineLayer) {
        UITouch *touch = [[event allTouches] anyObject];
        CGPoint location = [touch locationInView:touch.view];
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGPoint startPoint = CGPointMake(100, 100);
        [path moveToPoint:startPoint];
        CGPoint controlPoint = CGPointMake(startPoint.x+location.x, startPoint.y+location.y);
        [path addQuadCurveToPoint:location controlPoint:controlPoint];
        
        self.lineLayer.path = path.CGPath;
        self.lineLayer.strokeStart = 0;
        self.lineLayer.strokeEnd = 0;
        _animation.toValue = [NSValue valueWithCGPoint:location];
        [self.lineLayer pop_addAnimation:_animation forKey:@"animation"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
