#import <Foundation/Foundation.h>

@interface RNNInterpolator : NSObject

+ (UIColor *)fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor precent:(CGFloat)precent;

+ (CGFloat)fromFloat:(CGFloat)fromFloat toFloat:(CGFloat)toFloat precent:(CGFloat)precent;

+ (CGRect)fromRect:(CGRect)from toRect:(CGRect)toRect precent:(CGFloat)precent;

@end
