#import "ElementBaseTransition.h"

@implementation ElementBaseTransition {
    CGFloat _initialValue;
}

@synthesize duration = _duration;
@synthesize startDelay = _startDelay;

- (instancetype)initWithView:(UIView *)view transitionDetails:(TransitionDetailsOptions *)transitionDetails {
    self = [super init];
    _view = view;
    _transitionDetails = transitionDetails;
    _startDelay = [transitionDetails.startDelay getWithDefaultValue:0];
    _duration = [transitionDetails.duration getWithDefaultValue:[self defaultDuration]];
    _initialValue = self.initialValue;
    return self;
}

- (CGFloat)defaultDuration {
    return 300;
}

- (CGFloat)from {
    return _transitionDetails.from.hasValue ? _transitionDetails.from.get : _initialValue;
}

- (CGFloat)to {
    return _transitionDetails.to.hasValue ? _transitionDetails.to.get : _initialValue;
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

- (CGFloat)initialValue {
    return 0;
}

@end
