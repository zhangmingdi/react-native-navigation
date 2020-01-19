#import "ElementVerticalTransition.h"

@implementation ElementVerticalTransition

- (void)animateWithProgress:(CGFloat)p {
    CGFloat y = [RNNInterpolator fromFloat:self.from toFloat:self.to precent:p];
    self.view.frame = CGRectMake(self.view.frame.origin.x, y, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
}

- (CGFloat)initialValue {
    return self.view.frame.origin.y;
}

@end
