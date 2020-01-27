#import "SharedElementTransitionsCreator.h"
#import "RNNElementFinder.h"
#import "AnimatedViewFactory.h"
#import "BaseAnimator.h"
#import "NSArray+utils.h"

@implementation SharedElementTransitionsCreator

+ (NSArray<DisplayLinkAnimatorDelegate>*)create:(NSArray<SharedElementTransitionOptions *>*)sharedElementTransitions
                                                           fromVC:(UIViewController *)fromVC
                                                             toVC:(UIViewController *)toVC
                                                    containerView:(UIView *)containerView {
    NSMutableArray<DisplayLinkAnimatorDelegate>* transitions = [NSMutableArray<DisplayLinkAnimatorDelegate> new];
    for (SharedElementTransitionOptions* transitionOptions in sharedElementTransitions) {
        AnimatedReactView* animatedView = [self createAnimatedView:transitionOptions fromVC:fromVC toVC:toVC];
        BaseAnimator* animator = [[BaseAnimator alloc] init];
        animator.animations = [NSMutableArray arrayWithArray:@[animatedView]];
        animator.view = animatedView;
        [transitions addObject:animator];
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

+ (AnimatedReactView *)createAnimatedView:(SharedElementTransitionOptions *)transitionOptions fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC {
    UIView *fromElement = [RNNElementFinder findElementForId:transitionOptions.fromId inView:fromVC.view];
    UIView *toElement = [RNNElementFinder findElementForId:transitionOptions.toId inView:toVC.view];
    return [AnimatedViewFactory createFromElement:fromElement toElement:toElement transitionOptions:transitionOptions];
}


@end
