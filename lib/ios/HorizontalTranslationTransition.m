#import "HorizontalTranslationTransition.h"

@implementation HorizontalTranslationTransition

- (CGAffineTransform)animateWithProgress:(CGFloat)p {
    CGFloat x = [RNNInterpolator fromFloat:self.from + self.to toFloat:self.to precent:p interpolation:self.interpolation];
    return CGAffineTransformMakeTranslation(x - self.to, 0);
}

- (CGFloat)initialValue {
    return self.view.frame.origin.x;
}

@end
