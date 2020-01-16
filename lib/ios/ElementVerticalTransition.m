#import "ElementVerticalTransition.h"

@implementation ElementVerticalTransition

- (void)animateWithProgress:(CGFloat)p {
    CGFloat x = [RNNInterpolator fromFloat:self.to toFloat:self.from precent:p];
    self.view.frame = CGRectMake(x, self.view.frame.origin.y, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
}

@end
