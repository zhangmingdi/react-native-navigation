#import "VerticalTranslationTransition.h"

@implementation VerticalTranslationTransition

- (void)animateWithProgress:(CGFloat)p {
    CGFloat y = [RNNInterpolator fromFloat:self.from toFloat:self.to precent:p];
    self.view.frame = CGRectMake(self.view.frame.origin.x, y, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
}

@end
