#import "ElementAlphaTransition.h"

@implementation ElementAlphaTransition

- (void)animateWithProgress:(CGFloat)p {
    self.view.alpha = [RNNInterpolator fromFloat:self.from toFloat:self.to precent:p];
}

- (CGFloat)initialValue {
    return self.view.alpha;
}

@end
