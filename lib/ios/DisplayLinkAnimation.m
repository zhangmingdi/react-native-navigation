#import "DisplayLinkAnimation.h"
#import "UIView+Utils.h"

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

- (void)animateWithProgress:(CGFloat)p {
    if (_animateFrame) {
        _view.frame = CGRectMake(LNInterpolate(_startFrame.origin.x, _targetFrame.origin.x, p),
        LNInterpolate(_startFrame.origin.y, _targetFrame.origin.y, p),
        LNInterpolate(_startFrame.size.width, _targetFrame.size.width, p),
        LNInterpolate(_startFrame.size.height, _targetFrame.size.height, p));
    }
    
    if (_animateAlpha) {
        _view.alpha = p;
    }
    
    [_view layout:p];
}

static CGFloat LNSmootherStep(double p) {
	return p * p * p * (p * (p * 6 - 15) + 10);
}

static CGFloat LNInterpolate(CGFloat from, CGFloat to, CGFloat p) {
	return from + QuarticEaseInOut(p) * (to - from);
}

CGFloat QuarticEaseInOut(CGFloat p)
{
    if(p < 0.5) {
        return 4 * p * p * p;
    } else {
        CGFloat f = ((2 * p) - 2);
        return 0.5 * f * f * f + 1;
    }
}

- (void)end {
	_view.frame = _targetFrame;
	_view.alpha = _targetAlpha;
}

@end
