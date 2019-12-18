#import "FrameAnimator.h"

@implementation FrameAnimator {
	UIView* _view;
	CGRect _startFrame;
	CGRect _targetFrame;
	NSTimeInterval _duration;
	NSDate* _startDate;
	CADisplayLink* _displayLink;
}

+ (void)animateView:(UIView*)view toFrame:(CGRect)frame duration:(NSTimeInterval)duration {
	__unused id nrv = [[FrameAnimator alloc] initWithView:view targetFrame:frame duration:duration];
}

static CGFloat LNSmootherStep(double p) {
	return p * p * p * (p * (p * 6 - 15) + 10);
}

static CGFloat LNInterpolate(CGFloat from, CGFloat to, CGFloat p) {
	return from + LNSmootherStep(p) * (to - from);
}

- (instancetype)initWithView:(UIView*)view targetFrame:(CGRect)frame duration:(NSTimeInterval)duration {
	self = [super init];
	if (self) {
		_view = view;
		_startFrame = view.frame;
		_targetFrame = frame;
		_duration = duration;
		_startDate = NSDate.date;
		_displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(_displayLinkDidTick:)];
		[_displayLink addToRunLoop:NSRunLoop.mainRunLoop forMode:NSDefaultRunLoopMode];
	}
	return self;
}

- (void)_displayLinkDidTick:(CADisplayLink*)displayLink {
	NSTimeInterval elapsed = [NSDate.date timeIntervalSinceDate:_startDate];
	CGFloat p = elapsed/_duration;
	if(elapsed > _duration)
	{
		_view.frame = _targetFrame;
		[displayLink invalidate];
		return;
	}
	_view.frame = CGRectMake(LNInterpolate(_startFrame.origin.x, _targetFrame.origin.x, p),
							 LNInterpolate(_startFrame.origin.y, _targetFrame.origin.y, p),
							 LNInterpolate(_startFrame.size.width, _targetFrame.size.width, p),
							 LNInterpolate(_startFrame.size.height, _targetFrame.size.height, p));
}

@end
