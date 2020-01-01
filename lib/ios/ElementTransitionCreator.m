#import "ElementTransitionCreator.h"
#import "ElementAlphaTransition.h"
#import "ElementVerticalTransition.h"

@implementation ElementTransitionCreator {
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
		[transitions addObject:[[ElementAlphaTransition alloc] initWithView:view transitionOptions:_transitionOptions.alpha]];
	}
    
    if (_transitionOptions.x.hasAnimation) {
        [transitions addObject:[[ElementVerticalTransition alloc] initWithView:view transitionOptions:_transitionOptions.x]];
    }
	
	return transitions;
}

@end
