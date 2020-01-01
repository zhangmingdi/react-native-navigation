#import "ScreenTransitionsCreator.h"
#import "SharedElementTransitionsCreator.h"
#import "ElementTransitionCreator.h"

@implementation ScreenTransitionsCreator {
	RNNScreenTransition* _screenTransition;
	SharedElementTransitionsCreator* _sharedElementTransitionsCreator;
	ElementTransitionCreator* _contentTransitionCreator;
}

- (instancetype)initWithScreenTransition:(RNNScreenTransition *)screenTransition {
    self = [super init];
    _screenTransition = screenTransition;
	_sharedElementTransitionsCreator = [[SharedElementTransitionsCreator alloc] initWithSharedElementTransitions:screenTransition.sharedElementTransitions];
	_contentTransitionCreator = [[ElementTransitionCreator alloc] initWithTransitionOptions:screenTransition.content];
    return self;
}

- (NSArray<id<DisplayLinkAnimation>> *)createFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC containerView:(UIView *)containerView {
	NSMutableArray* transitions = [NSMutableArray new];
	
    [transitions addObjectsFromArray:[_contentTransitionCreator createWithView:toVC.view containerView:containerView]];
    [transitions addObjectsFromArray:[_sharedElementTransitionsCreator createFromVC:fromVC toVC:toVC containerView:containerView]];
	
	return transitions;
}

- (NSTimeInterval)minDuration {
    return _screenTransition.minDuration;
}

@end
