#import "RNNAnimatedView.h"
#import <React/RCTImageView.h>

@implementation RNNAnimatedView {
    UIView* _originalParent;
    UIView* _view;
    CGFloat _startAlpha;
    CGFloat _targetAlpha;
}

- (instancetype)initWithView:(UIView *)view alpha:(CGFloat)alpha endAlpha:(CGFloat)endAlpha {
    self = [super init];
    _startAlpha = alpha;
    _targetAlpha = endAlpha;
    _view = view;
    
	return self;
}

- (void)animateWithProgress:(CGFloat)p {
    _view.alpha = [RNNInterpolator fromFloat:_startAlpha toFloat:_targetAlpha precent:p];
}

- (void)end {
    _view.alpha = _targetAlpha;
}

@end
