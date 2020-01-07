#import "ElementTransitionsCreator.h"
#import "RNNElementFinder.h"

@implementation ElementTransitionsCreator {
	NSArray<SharedElementTransitionOptions *>* _elementTransitions;
}

- (instancetype)initWithElementTransitions:(NSArray<SharedElementTransitionOptions *> *)elementTransitions {
    self = [super init];
	_elementTransitions = elementTransitions;
    return self;
}

- (NSArray<ElementTransition *>*)createFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC containerView:(UIView *)containerView {
    NSMutableArray* transitions = [NSMutableArray new];
    for (SharedElementTransitionOptions* transitionOptions in _elementTransitions) {
        UIView* elementView = [RNNElementFinder findElementForId:transitionOptions.fromId inView:toVC.view];
        ElementTransition* elementTransition = [[ElementTransition alloc] initWithTransitionOptions:transitionOptions];
        [transitions addObjectsFromArray:[elementTransition createWithView:elementView containerView:containerView]];
        
    }
//    for (SharedElementTransitionOptions* transitionOptions in _sharedElementTransitions) {
//        AnimatedReactView* animatedView = [self createAnimatedView:transitionOptions fromVC:fromVC toVC:toVC];
//        [transitions addObject:animatedView];
//    }
//	
//	[self addSharedElementViews:transitions toContainerView:containerView];
    
    return transitions;
}

@end
