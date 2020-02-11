#import "ElementFrameTransition.h"

@implementation ElementFrameTransition

- (CGAffineTransform)animateWithProgress:(CGFloat)p {
    self.view.frame = [RNNInterpolator fromRect:self.from toRect:self.to precent:p interpolation:self.interpolation];
    return CGAffineTransformIdentity;
}

@end
