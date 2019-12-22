#import <UIKit/UIKit.h>
#import "RNNViewLocation.h"
#import "DisplayLinkAnimation.h"
#import "RNNInterpolator.h"

@interface RNNAnimatedView : NSObject <DisplayLinkAnimation>

- (instancetype)initWithView:(UIView *)view alpha:(CGFloat)alpha endAlpha:(CGFloat)endAlpha;

@end
