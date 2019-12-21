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
    return [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:RNNInterpolate(alpha, finalAlpha, precent)];
}

+ (CGColorRef)CGColorRefFromUIColor:(UIColor*)newColor {
     CGFloat components[4] = {0.0,0.0,0.0,0.0};
     [newColor getRed:&components[0] green:&components[1] blue:&components[2] alpha:&components[3]];
     CGColorRef newRGB = CGColorCreate(CGColorSpaceCreateDeviceRGB(), components);
     return newRGB;
}

@end
