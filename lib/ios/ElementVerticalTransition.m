#import "ElementVerticalTransition.h"

@implementation ElementVerticalTransition

- (CGAffineTransform)animateWithProgress:(CGFloat)p {
    CGFloat y = [RNNInterpolator fromFloat:self.from toFloat:self.to precent:p];
    return CGAffineTransformMakeTranslation(0, y);
}

- (CGFloat)initialValue {
    return self.view.frame.origin.y;
}

@end
