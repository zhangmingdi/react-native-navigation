#import "RNNInterpolator.h"

@implementation RNNInterpolator

+ (UIColor *)fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor precent:(CGFloat)precent {
    CGFloat fromHue, fromSaturation, fromBrightness, fromAlpha;
    [fromColor getHue:&fromHue saturation:&fromSaturation brightness:&fromBrightness alpha:&fromAlpha];

    CGFloat toHue, toSaturation, toBrightness, toAlpha;
    [toColor getHue:&toHue saturation:&toSaturation brightness:&toBrightness alpha:&toAlpha];
    
    CGFloat finalHue = RNNInterpolateFloat(fromHue, toHue, precent);
    CGFloat finalSaturation = RNNInterpolateFloat(fromSaturation, toSaturation, precent);
    CGFloat finalBrightness = RNNInterpolateFloat(fromBrightness, toBrightness, precent);
    CGFloat finalAlpha = RNNInterpolateFloat(fromAlpha, toAlpha, precent);
    
    return [UIColor colorWithHue:finalHue saturation:finalSaturation brightness:finalBrightness alpha:finalAlpha];
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
