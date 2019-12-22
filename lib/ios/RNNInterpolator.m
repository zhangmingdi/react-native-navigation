#import "RNNInterpolator.h"

@implementation RNNInterpolator

+ (UIColor *)fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor precent:(CGFloat)precent {
    const CGFloat *components = CGColorGetComponents([self CGColorRefFromUIColor:fromColor]);
    CGFloat red = components[0];
    CGFloat green = components[1];
    CGFloat blue = components[2];
    CGFloat alpha = components[3];
    
    const CGFloat *toComponents = CGColorGetComponents([self CGColorRefFromUIColor:toColor]);
    CGFloat finalRed = toComponents[0];
    CGFloat finalGreen = toComponents[1];
    CGFloat finalBlue = toComponents[2];
    CGFloat finalAlpha = toComponents[3];
    
    CGFloat newRed   = (1.0f - precent) * red   + precent * finalRed;
    CGFloat newGreen = (1.0f - precent) * green + precent * finalGreen;
    CGFloat newBlue  = (1.0f - precent) * blue  + precent * finalBlue;
    return [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:RNNInterpolateFloat(alpha, finalAlpha, precent)];
}

+ (CGFloat)fromFloat:(CGFloat)from toFloat:(CGFloat)to precent:(CGFloat)precent {
    return from + RNNQuarticEaseInOut(precent) * (to - from);
}

+ (CGRect)fromRect:(CGRect)from toRect:(CGRect)to precent:(CGFloat)p {
    return CGRectMake(RNNInterpolateFloat(from.origin.x, to.origin.x, p),
    RNNInterpolateFloat(from.origin.y, to.origin.y, p),
    RNNInterpolateFloat(from.size.width, to.size.width, p),
    RNNInterpolateFloat(from.size.height, to.size.height, p));
}

+ (CGColorRef)CGColorRefFromUIColor:(UIColor*)newColor {
     CGFloat components[4] = {0.0,0.0,0.0,0.0};
     [newColor getRed:&components[0] green:&components[1] blue:&components[2] alpha:&components[3]];
     CGColorRef newRGB = CGColorCreate(CGColorSpaceCreateDeviceRGB(), components);
     return newRGB;
}

static CGFloat RNNInterpolateFloat(CGFloat from, CGFloat to, CGFloat p) {
    return from + RNNQuarticEaseInOut(p) * (to - from);
}

static CGFloat RNNQuarticEaseInOut(CGFloat p) {
    if(p < 0.5) {
        return 4 * p * p * p;
    } else {
        CGFloat f = ((2 * p) - 2);
        return 0.5 * f * f * f + 1;
    }
}

@end
