#import <UIKit/UIKit.h>
#import "RNNViewLocation.h"
#import "DisplayLinkAnimation.h"
#import "RNNInterpolator.h"

@interface RNNAnimatedView : DisplayLinkAnimation

- (instancetype)initWithView:(UIView *)view alpha:(CGFloat)alpha endAlpha:(CGFloat)endAlpha;

@end
