#import "ElementAlphaTransition.h"

@implementation ElementAlphaTransition {
    UIView* _view;
    CGFloat _startAlpha;
    CGFloat _targetAlpha;
    CGFloat _duration;
}

- (instancetype)initWithView:(UIView *)view transitionOptions:(TransitionOptions *)transitionOptions {
    self = [super init];
    _startAlpha = [transitionOptions.from getWithDefaultValue:view.alpha];
    _targetAlpha = [transitionOptions.to getWithDefaultValue:1];
    _duration = [transitionOptions.duration getWithDefaultValue:1];
    _view = view;
    
	return self;
}

- (void)animateWithProgress:(CGFloat)p {
    _view.alpha = [RNNInterpolator fromFloat:_startAlpha toFloat:_targetAlpha precent:p];
}

- (CGFloat)duration {
    return _duration;
}

- (void)end {
    _view.alpha = _targetAlpha;
}

@end
