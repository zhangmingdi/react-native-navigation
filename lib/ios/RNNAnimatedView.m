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
    _view.alpha = RNNInterpolate(_startAlpha, _targetAlpha, p);
}

- (void)end {
    
}

@end
