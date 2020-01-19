#import "ElementAlphaTransition.h"

@implementation ElementAlphaTransition

- (CGAffineTransform)animateWithProgress:(CGFloat)p {
    self.view.alpha = [RNNInterpolator fromFloat:self.from toFloat:self.to precent:p];
    return CGAffineTransformIdentity;
}

- (CGFloat)initialValue {
    return self.view.alpha;
}

@end
