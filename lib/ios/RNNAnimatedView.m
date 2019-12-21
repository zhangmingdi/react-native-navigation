#import "RNNAnimatedView.h"
#import <React/RCTImageView.h>

@implementation RNNAnimatedView {
    UIView* _originalParent;
    UIView* _hijackedView;
    CGFloat _startAlpha;
    CGFloat _targetAlpha;
}

- (instancetype)initWithView:(UIView *)view alpha:(CGFloat)alpha endAlpha:(CGFloat)endAlpha {
    self = [super initWithFrame:view.bounds];
    [self hijackView:view];
    
	return self;
}

- (void)hijackView:(UIView *)view {
    _hijackedView = view;
    _originalParent = view.superview;
    [self addSubview:view];
}

- (void)animateWithProgress:(CGFloat)p {
//    self.frame = RNNInterpolateRect(self.location.fromFrame, self.location.toFrame, p);
}

- (void)end {
    
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
//    _hijackedView.alpha = _originalFrame;
    [_originalParent addSubview:_hijackedView];
}

@end
