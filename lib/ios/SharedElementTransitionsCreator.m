#import "SharedElementTransitionsCreator.h"
#import "RNNElementFinder.h"
#import "AnimatedViewFactory.h"
#import "BaseAnimator.h"
#import "NSArray+utils.h"
#import "SharedElementAnimator.h"

@implementation SharedElementTransitionsCreator

+ (NSArray<DisplayLinkAnimatorDelegate>*)create:(NSArray<SharedElementTransitionOptions *>*)sharedElementTransitions
                                         fromVC:(UIViewController *)fromVC
                                           toVC:(UIViewController *)toVC
                                  containerView:(UIView *)containerView {
    NSMutableArray<DisplayLinkAnimatorDelegate>* transitions = [NSMutableArray<DisplayLinkAnimatorDelegate> new];
    for (SharedElementTransitionOptions* transitionOptions in sharedElementTransitions) {
        UIView *fromView = [RNNElementFinder findElementForId:transitionOptions.fromId inView:fromVC.view];
        UIView *toView = [RNNElementFinder findElementForId:transitionOptions.toId inView:toVC.view];
        SharedElementAnimator* sharedElementAnimator = [[SharedElementAnimator alloc] initWithTransitionOptions:transitionOptions
                                                                                                       fromView:fromView
                                                                                                         toView:toView
                                                                                                         fromVC:fromVC
                                                                                                           toVC:toVC
                                                                                                  containerView:containerView];
        [transitions addObject:sharedElementAnimator];
    }
    
    [self addSharedElementViews:transitions toContainerView:containerView];
    
    return transitions;
}

+ (void)addSharedElementViews:(NSArray<BaseAnimator *> *)animators toContainerView:(UIView *)containerView {
    NSMutableArray<AnimatedReactView *> * sharedElementViews = [NSMutableArray<AnimatedReactView *> new];
    for (BaseAnimator* animator in animators) {
        [sharedElementViews addObject:(AnimatedReactView *)animator.view];
    }
    
    for (UIView* sharedElementView in [sharedElementViews sortByPropertyName:@"reactZIndex"]) {
        [containerView addSubview:sharedElementView];
    }
}


@end
