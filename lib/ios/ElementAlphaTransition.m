#import "ElementAlphaTransition.h"

@implementation ElementAlphaTransition {
    CGFloat _startAlpha;
    CGFloat _targetAlpha;
}

- (instancetype)initWithView:(UIView *)view transitionOptions:(TransitionOptions *)transitionOptions {
    self = [super initWithView:view transitionOptions:transitionOptions];
    
    self.view.alpha = _startAlpha = [transitionOptions.from getWithDefaultValue:view.alpha];
    _targetAlpha = [transitionOptions.to getWithDefaultValue:1];

	return self;
}

- (void)animateWithProgress:(CGFloat)p {
    self.view.alpha = [RNNInterpolator fromFloat:_startAlpha toFloat:_targetAlpha precent:p];
}

- (void)end {
    self.view.alpha = _targetAlpha;
}

@end
