#import "ElementTransitionsCreator.h"

@implementation ElementTransitionsCreator {
	NSArray<ElementTransitionOptions *>* _elementTransitions;
}

- (instancetype)initWithElementTransitions:(NSArray<ElementTransitionOptions *> *)elementTransitions {
    self = [super init];
	_elementTransitions = elementTransitions;
    return self;
}

- (NSArray<ElementTransition *>*)createFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC containerView:(UIView *)containerView {
    NSMutableArray* transitions = [NSMutableArray new];
    for (ElementTransitionOptions* transitionOptions in _elementTransitions) {
        ElementTransition* elementTransition = [[ElementTransition alloc] initWithTransitionOptions:transitionOptions
                                                                                             fromVC:fromVC
                                                                                               toVC:toVC
                                                                                      containerView:containerView];
        [transitions addObjectsFromArray:[elementTransition create]];
    }
    
    return transitions;
}

@end
