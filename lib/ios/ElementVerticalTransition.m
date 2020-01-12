#import "ElementVerticalTransition.h"

@implementation ElementVerticalTransition {
    CGFloat _fromX;
    CGFloat _toX;
}

- (instancetype)initWithView:(UIView *)view transitionDetails:(TransitionDetailsOptions *)transitionDetails {
    self = [super initWithView:view transitionDetails:transitionDetails];
    
    _fromX = [transitionDetails.from getWithDefaultValue:0];
    _toX = [transitionDetails.to getWithDefaultValue:0];
    
    return self;
}

- (void)animateWithProgress:(CGFloat)p {
    CGFloat x = [RNNInterpolator fromFloat:_fromX toFloat:_toX precent:p];
    self.view.frame = CGRectMake(x, self.view.frame.origin.y, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
}

@end
