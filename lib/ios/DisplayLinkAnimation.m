#import "DisplayLinkAnimation.h"

@implementation DisplayLinkAnimation {
	UIView* _view;
	CGRect _startFrame;
	CGRect _targetFrame;
    CGFloat _startAlpha;
    CGFloat _targetAlpha;
    BOOL _animateAlpha;
    BOOL _animateFrame;
}

- (instancetype)initWithView:(UIView*)view targetFrame:(CGRect)frame targetAlpha:(CGFloat)targetAlpha {
	self = [super init];
	if (self) {
		_view = view;
		_startFrame = view.frame;
		_targetFrame = frame;
        _startAlpha = view.alpha;
        _targetAlpha = targetAlpha;
        _animateAlpha = _startAlpha != _targetAlpha;
        _animateFrame = !CGRectEqualToRect(_startFrame, _targetFrame);
	}
	return self;
}

- (void)layout:(CGFloat)p {
    if (_animateFrame) {
        _view.frame = CGRectMake(LNInterpolate(_startFrame.origin.x, _targetFrame.origin.x, p),
        LNInterpolate(_startFrame.origin.y, _targetFrame.origin.y, p),
        LNInterpolate(_startFrame.size.width, _targetFrame.size.width, p),
        LNInterpolate(_startFrame.size.height, _targetFrame.size.height, p));
    }
    
    if (_animateAlpha) {
        _view.alpha = p;
    }
}

static CGFloat LNSmootherStep(double p) {
	return p * p * p * (p * (p * 6 - 15) + 10);
}

static CGFloat LNInterpolate(CGFloat from, CGFloat to, CGFloat p) {
	return from + LNSmootherStep(p) * (to - from);
}

- (void)end {
	_view.frame = _targetFrame;
	_view.alpha = _targetAlpha;
}

@end
