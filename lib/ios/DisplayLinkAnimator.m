#import "DisplayLinkAnimator.h"

@implementation DisplayLinkAnimator {
    NSArray<id<DisplayLinkAnimation>>* _animations;
    CADisplayLink* _displayLink;
    NSDate* _startDate;
    CGFloat _duration;
}

- (instancetype)initWithDisplayLinkAnimations:(NSArray<id<DisplayLinkAnimation>> *)displayLinkAnimations duration:(CGFloat)duration {
    self = [super init];
    _animations = displayLinkAnimations;
    _duration = [self maxDuration:displayLinkAnimations];
    return self;
}

- (instancetype)initWithDisplayLinkAnimation:(id<DisplayLinkAnimation>)displayLinkAnimation duration:(CGFloat)duration {
	self = [self initWithDisplayLinkAnimations:@[displayLinkAnimation] duration:duration];
    return self;
}

- (void)start {
    _startDate = NSDate.date;
	_displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(_displayLinkDidTick:)];
	[_displayLink addToRunLoop:NSRunLoop.mainRunLoop forMode:NSDefaultRunLoopMode];
}

- (CGFloat)maxDuration:(NSArray<id<DisplayLinkAnimation>> *)displayLinkAnimations {
    CGFloat maxDuration = 0;
    for (id<DisplayLinkAnimation> animation in displayLinkAnimations) {
        if (animation.duration > maxDuration) {
            maxDuration = animation.duration;
        }
    }
    
    return maxDuration;
}

- (void)_displayLinkDidTick:(CADisplayLink*)displayLink {
	NSTimeInterval elapsed = [NSDate.date timeIntervalSinceDate:_startDate];
	if(elapsed > _duration) {
		[self end];
		[displayLink invalidate];
        if (_completion) {
            _completion();
            _completion = nil;
        }
		return;
	}
	
    [self updateAnimations:elapsed];
}

- (void)updateAnimations:(NSTimeInterval)elapsed {
	for (id<DisplayLinkAnimation> animation in _animations) {
        CGFloat p = elapsed/animation.duration;
		[animation animateWithProgress:p];
	}
}

- (void)end {
    for (id<DisplayLinkAnimation> animation in _animations) {
        [animation end];
    }
}

@end
