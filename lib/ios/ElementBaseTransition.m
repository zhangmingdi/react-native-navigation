#import "ElementBaseTransition.h"

@implementation ElementBaseTransition
@synthesize duration = _duration;
@synthesize startDelay = _startDelay;

- (instancetype)initWithView:(UIView *)view transitionDetails:(TransitionDetailsOptions *)transitionDetails {
	self = [super init];
	_view = view;
	_startDelay = [transitionDetails.startDelay getWithDefaultValue:0];
	_duration = [transitionDetails.duration getWithDefaultValue:0.6];
	return self;
}

- (NSTimeInterval)startDelay {
    return _startDelay;
}

- (CGFloat)duration {
    return _duration;
}

- (void)animateWithProgress:(CGFloat)p { 

}

- (void)end { 

}



@end
