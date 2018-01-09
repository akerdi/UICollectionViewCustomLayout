//
//  CGView0.m
//  TestNetProject
//
//  Created by aKerdi on 2018/1/9.
//  Copyright © 2018年 XXT. All rights reserved.
//

#import "CGView0.h"

@implementation CGView0

/*method0
- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    [[UIColor blueColor] setFill];
    [path fill];
}*/

//- (void)drawRect:(CGRect)rect {
//    CGContextRef con = UIGraphicsGetCurrentContext();
//    CGContextAddEllipseInRect(con, CGRectMake(0, 0, 100, 100));
//    CGContextSetFillColorWithColor(con, [UIColor blueColor].CGColor);
//    CGContextFillPath(con);
//}

//https://www.jianshu.com/p/be38212c0f79
- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor redColor] setStroke];
    
    CGContextSaveGState(ctx);
    
    CGContextAddEllipseInRect(ctx, CGRectMake(100, 100, 50, 50));
    CGContextSetLineWidth(ctx, 20);
    [[UIColor yellowColor] setStroke];
    CGContextStrokePath(ctx);
    
    CGContextRestoreGState(ctx);
    
    CGContextAddEllipseInRect(ctx, CGRectMake(200, 100, 50, 50));
    CGContextStrokePath(ctx);
    
}

@end
