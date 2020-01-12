#import "ElementAlphaTransition.h"

@implementation ElementAlphaTransition {
    CGFloat _startAlpha;
    CGFloat _targetAlpha;
}

- (instancetype)initWithView:(UIView *)view transitionDetails:(TransitionDetailsOptions *)transitionDetails  {
    self = [super initWithView:view transitionDetails:transitionDetails];
    
    self.view.alpha = _startAlpha = [transitionDetails.from getWithDefaultValue:view.alpha];
    _targetAlpha = [transitionDetails.to getWithDefaultValue:1];

	return self;
}

- (void)animateWithProgress:(CGFloat)p {
    self.view.alpha = [RNNInterpolator fromFloat:_startAlpha toFloat:_targetAlpha precent:p];
}

- (void)end {
    self.view.alpha = _targetAlpha;
}

@end
