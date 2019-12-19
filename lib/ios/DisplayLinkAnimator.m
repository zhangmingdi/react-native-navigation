#import "DisplayLinkAnimator.h"

@implementation DisplayLinkAnimator {
    NSArray<DisplayLinkAnimation *>* _animations;
    CADisplayLink* _displayLink;
    NSDate* _startDate;
    CGFloat _duration;
}

- (instancetype)initWithDisplayLinkAnimations:(NSArray<DisplayLinkAnimation *> *)displayLinkAnimations duration:(CGFloat)duration {
    self = [super init];
    _animations = displayLinkAnimations;
    _duration = duration;
    return self;
}

- (instancetype)initWithDisplayLinkAnimation:(DisplayLinkAnimation *)displayLinkAnimation duration:(CGFloat)duration {
	self = [self initWithDisplayLinkAnimations:@[displayLinkAnimation] duration:duration];
    return self;
}

- (void)start {
    _startDate = NSDate.date;
	_displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(_displayLinkDidTick:)];
	[_displayLink addToRunLoop:NSRunLoop.mainRunLoop forMode:NSDefaultRunLoopMode];
}

- (void)_displayLinkDidTick:(CADisplayLink*)displayLink {
	NSTimeInterval elapsed = [NSDate.date timeIntervalSinceDate:_startDate];
	CGFloat p = elapsed/_duration;
	if(elapsed > _duration) {
		[self end];
		[displayLink invalidate];
        if (_completion) {
            _completion();
            _completion = nil;
        }
		return;
	}
	
	[self updateAnimations:p];
}

- (void)updateAnimations:(CGFloat)p {
	for (DisplayLinkAnimation* animation in _animations) {
		[animation layout:p];
	}
}

- (void)end {
    for (DisplayLinkAnimation* animation in _animations) {
        [animation end];
    }
}

@end
