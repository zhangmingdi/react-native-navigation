#import "ElementHorizontalTransition.h"

@implementation ElementHorizontalTransition {
    CGFloat _fromY;
    CGFloat _toY;
}

- (instancetype)initWithView:(UIView *)view transitionDetails:(TransitionDetailsOptions *)transitionDetails {
    self = [super initWithView:view transitionDetails:transitionDetails];
    
    _fromY = [transitionDetails.from getWithDefaultValue:0];
    _toY = [transitionDetails.to getWithDefaultValue:0];
    
    return self;
}

- (void)animateWithProgress:(CGFloat)p {
    CGFloat y = [RNNInterpolator fromFloat:_fromY toFloat:_toY precent:p];
    self.view.frame = CGRectMake(self.view.frame.origin.x, y, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
}

@end
