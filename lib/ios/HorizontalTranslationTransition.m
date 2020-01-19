#import "HorizontalTranslationTransition.h"

@implementation HorizontalTranslationTransition

- (void)animateWithProgress:(CGFloat)p {
    CGFloat x = [RNNInterpolator fromFloat:self.from toFloat:self.to precent:p];
    self.view.frame = CGRectMake(x, self.view.frame.origin.y, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
}

- (CGFloat)initialValue {
    return self.view.frame.origin.x + self.from;
}

@end
