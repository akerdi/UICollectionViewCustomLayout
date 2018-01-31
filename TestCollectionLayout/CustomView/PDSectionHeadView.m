//
//  PDSectionHeadView.m
//  PinkDiary
//
//  Created by aKerdi on 2018/1/31.
//

#import "PDSectionHeadView.h"

@implementation PDSectionHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.opaque = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat rectHeight = CGRectGetHeight(rect);
    CGFloat rectWidth = CGRectGetWidth(rect);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    UIColor *bgColor = [UIColor clearColor];
    [bgColor setFill];
    UIRectFill(rect);
    CGContextSaveGState(contextRef);
    
    CGFloat pinkLineLeft = 15;
    CGFloat pinkLineHeight = 15;
    CGFloat pinkLineWidth = 2.;
    CGFloat pinkTop = (rectHeight-pinkLineHeight)/2.;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, pinkLineLeft, pinkTop);
    CGPathAddLineToPoint(path, nil, pinkLineLeft, pinkTop+pinkLineHeight);
    CGContextAddPath(contextRef, path);
    
    CGContextSetLineWidth(contextRef, pinkLineWidth);
    CGContextSetLineCap(contextRef, kCGLineCapRound);
    UIColor *pinkLineColor = C1;
    [pinkLineColor setFill];
    CGContextSetFillColorWithColor(contextRef, pinkLineColor.CGColor);
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    
    CGPathRelease(path);
    
    CGFloat textLayerHeight = 20;
    CGFloat textLayerPadding = 8;
    CGFloat textLayerTop = (rectHeight-20)/2.;
    CGFloat textLayerLeft = pinkLineLeft+pinkLineWidth+textLayerPadding;
    CGContextTranslateCTM(contextRef, textLayerLeft, textLayerTop);

    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.string = @"姨妈圈子";
    UIFont *font = [UIFont systemFontOfSize:14];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = 14;

    CGFloat width = stringSizeCustomBreakMode(textLayer.string, CGSizeMake(CGFLOAT_MAX, textLayerHeight), font, NSLineBreakByWordWrapping).width;
    textLayer.frame = CGRectMake(textLayerLeft, textLayerTop, width, textLayerHeight);
    textLayer.foregroundColor = C1.CGColor;
    [textLayer drawInContext:contextRef];
    CGContextSaveGState(contextRef);
    
    CGFloat rightPadding = 12;
    CGFloat rightAccessoryWidth = 20;
    CGFloat rightAccessoryHeight = 20;
    CGFloat rightAccessoryTop = (rectHeight-rightAccessoryHeight)/2.0;
    CALayer *rightAccessoryLayer = [CALayer layer];
    rightAccessoryLayer.contents = (id)[UIImage imageNamed:@"writediary_addaccessory"].CGImage;
    rightAccessoryLayer.frame = CGRectMake(rectWidth-rightPadding-rightAccessoryWidth, rightAccessoryTop, rightAccessoryWidth, rightAccessoryHeight);
    [rightAccessoryLayer drawInContext:contextRef];
    CGContextSaveGState(contextRef);
    
    NSString *moreStr = @"更多";
    CGFloat moreLayerHeight = 12;
    CGFloat moreLayerFontSize = 12;
    CGSize moreSize = stringSizeCustomBreakMode(moreStr, CGSizeMake(CGFLOAT_MAX, moreLayerHeight), [UIFont systemFontOfSize:moreLayerFontSize], NSLineBreakByWordWrapping);
    CGFloat moreLayerTop = (rectHeight-moreLayerHeight)/2.;
    CGFloat moreLayerLeft = rectWidth-rightPadding-rightAccessoryWidth-textLayerPadding-moreSize.width;
    CGAffineTransform trans = CGAffineTransformMakeScale(1, -1);
    CGContextSetTextMatrix(contextRef, trans);
    CGContextTranslateCTM(contextRef, moreLayerLeft-textLayerLeft, moreLayerTop-textLayerTop);
    CATextLayer *moreLayer = [CATextLayer layer];
    moreLayer.string = moreStr;
    moreLayer.contentsScale = [UIScreen mainScreen].scale;
    moreLayer.font = fontRef;
    moreLayer.fontSize = moreLayerFontSize;
    moreLayer.foregroundColor = C3.CGColor;
    moreLayer.frame = CGRectMake(moreLayerLeft, moreLayerTop, moreSize.width, moreLayerHeight);
    [moreLayer drawInContext:contextRef];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.SectionHeadViewBlock) {
        self.SectionHeadViewBlock(self);
    }
}

@end
