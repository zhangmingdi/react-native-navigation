#import "ElementTransitionCreator.h"
#import "ElementAlphaTransition.h"

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
	
	return transitions;
}

@end
