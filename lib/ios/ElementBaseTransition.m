#import "ElementBaseTransition.h"

@implementation ElementBaseTransition

@synthesize duration = _duration;
@synthesize startDelay = _startDelay;

- (instancetype)initWithView:(UIView *)view transitionDetails:(TransitionDetailsOptions *)transitionDetails {
    self = [super init];
    _view = view;
    _startDelay = [transitionDetails.startDelay getWithDefaultValue:0];
    _duration = [transitionDetails.duration getWithDefaultValue:1000];
    return self;
}

- (instancetype)initToView:(UIView *)view transitionDetails:(TransitionDetailsOptions *)transitionDetails {
	self = [self initWithView:view transitionDetails:transitionDetails];
    _from = [transitionDetails.from getWithDefaultValue:0];
    _to = [transitionDetails.to getWithDefaultValue:0];
	return self;
}

- (instancetype)initFromView:(UIView *)view transitionDetails:(TransitionDetailsOptions *)transitionDetails {
    self = [self initWithView:view transitionDetails:transitionDetails];
    _from = self.initialValue;
    _to = self.initialValue;
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

- (CGFloat)initialValue {
    return 0;
}

@end
