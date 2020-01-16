#import "ElementBaseTransition.h"

@implementation ElementBaseTransition {
    BOOL _viewIsAppearing;
}

@synthesize duration = _duration;
@synthesize startDelay = _startDelay;

- (instancetype)initWithView:(UIView *)view transitionDetails:(TransitionDetailsOptions *)transitionDetails {
	self = [super init];
	_view = view;
	_startDelay = [transitionDetails.startDelay getWithDefaultValue:0];
	_duration = [transitionDetails.duration getWithDefaultValue:1000];
    _from = [transitionDetails.from getWithDefaultValue:0];
    _to = [transitionDetails.to getWithDefaultValue:0];
	return self;
}

//- (instancetype)initWithAppearingView:(UIView *)view transitionDetails:(TransitionDetailsOptions *)transitionDetails {
//    self = [self initWithView:view transitionDetails:transitionDetails];
//    _to = [transitionDetails.to getWithDefaultValue:0];
//    NSAssert(transitionDetails.from.hasValue, @"Transitioning elements in current visible screen `from` value is taken from the element initial values, `from` value should be removed");
//    _from = self.initialValue;
//    return self;
//}
//
//- (instancetype)initWithDisappearingView:(UIView *)view transitionDetails:(TransitionDetailsOptions *)transitionDetails {
//    self = [self initWithView:view transitionDetails:transitionDetails];
//    _from = [transitionDetails.from getWithDefaultValue:0];
//    NSAssert(transitionDetails.from.hasValue, @"Transitioning elements in destination screen `to` value is taken from the element final values, `to` value should be removed");
//    _to = self.initialValue;
//    return self;
//}

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
