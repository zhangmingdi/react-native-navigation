#import "ElementTransition.h"
#import "ElementAlphaTransition.h"
#import "ElementVerticalTransition.h"
#import "ElementHorizontalTransition.h"

@implementation ElementTransition {
	ElementTransitionOptions* _transitionOptions;
}

- (instancetype)initWithTransitionOptions:(ElementTransitionOptions *)transitionOptions {
	self = [super init];
	_transitionOptions = transitionOptions;
	return self;
}

- (NSArray<id<DisplayLinkAnimation>>*)createWithView:(UIView *)view containerView:(UIView *)containerView {
	NSMutableArray* transitions = [NSMutableArray new];
	if (_transitionOptions.alpha.hasAnimation) {
		[transitions addObject:[[ElementAlphaTransition alloc] initWithView:view transitionDetails:_transitionOptions.alpha]];
	}
    
    if (_transitionOptions.x.hasAnimation) {
        [transitions addObject:[[ElementVerticalTransition alloc] initWithView:view transitionDetails:_transitionOptions.x]];
    }
    
    if (_transitionOptions.y.hasAnimation) {
        [transitions addObject:[[ElementHorizontalTransition alloc] initWithView:view transitionDetails:_transitionOptions.y]];
    }
	
	return transitions;
}

@end
