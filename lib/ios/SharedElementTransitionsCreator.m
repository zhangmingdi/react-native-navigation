#import "SharedElementTransitionsCreator.h"
#import "RNNElementFinder.h"
#import "AnimatedViewFactory.h"

@implementation SharedElementTransitionsCreator {
	NSArray<SharedElementTransitionOptions *>* _sharedElementTransitions;
}

- (instancetype)initWithSharedElementTransitions:(NSArray<SharedElementTransitionOptions *>*)sharedElementTransitions {
    self = [super init];
	_sharedElementTransitions = sharedElementTransitions;
    return self;
}

- (NSArray<AnimatedReactView *>*)createFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC containerView:(UIView *)containerView {
    NSMutableArray* transitions = [NSMutableArray new];
    for (SharedElementTransitionOptions* transitionOptions in _sharedElementTransitions) {
        AnimatedReactView* animatedView = [self createAnimatedView:transitionOptions fromVC:fromVC toVC:toVC];
        [transitions addObject:animatedView];
    }
	
	[self addSharedElementViews:transitions toContainerView:containerView];
    
    return transitions;
}

- (void)addSharedElementViews:(NSArray<AnimatedReactView *> *)views toContainerView:(UIView *)containerView {
    for (AnimatedReactView* view in views) {
        [containerView addSubview:view];
        [containerView bringSubviewToFront:view];
    }
}

- (AnimatedReactView *)createAnimatedView:(SharedElementTransitionOptions *)transitionOptions fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC {
    UIView *fromElement = [RNNElementFinder findElementForId:transitionOptions.fromId inView:fromVC.view];
    UIView *toElement = [RNNElementFinder findElementForId:transitionOptions.toId inView:toVC.view];
    return [AnimatedViewFactory createFromElement:fromElement toElement:toElement transitionOptions:transitionOptions];
}


@end
