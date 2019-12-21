#import <Foundation/Foundation.h>

static CGFloat RNNQuarticEaseInOut(CGFloat p)
{
    if(p < 0.5) {
        return 4 * p * p * p;
    } else {
        CGFloat f = ((2 * p) - 2);
        return 0.5 * f * f * f + 1;
    }
}

static CGFloat RNNInterpolate(CGFloat from, CGFloat to, CGFloat p) {
    return from + RNNQuarticEaseInOut(p) * (to - from);
}

static CGRect RNNInterpolateRect(CGRect from, CGRect to, CGFloat p) {
    return CGRectMake(RNNInterpolate(from.origin.x, to.origin.x, p),
    RNNInterpolate(from.origin.y, to.origin.y, p),
    RNNInterpolate(from.size.width, to.size.width, p),
    RNNInterpolate(from.size.height, to.size.height, p));
}

@interface RNNInterpolator : NSObject

+ (UIColor *)fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor precent:(CGFloat)precent;

@end
