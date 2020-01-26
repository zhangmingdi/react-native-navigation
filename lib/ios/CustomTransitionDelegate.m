#import "CustomTransitionDelegate.h"
#import "SharedElementTransitionsCreator.h"
#import "ElementTransitionsCreator.h"
#import "DisplayLinkAnimator.h"
#import "ContentTransitionCreator.h"

@implementation CustomTransitionDelegate {
    RCTUIManager* _uiManager;
    id <UIViewControllerContextTransitioning> _transitionContext;
    RNNScreenTransition* _screenTransition;
    BOOL _animate;
}

- (instancetype)initWithScreenTransition:(RNNScreenTransition *)screenTransition uiManager:(RCTUIManager *)uiManager {
    self = [super init];
    _screenTransition = screenTransition;
    _uiManager = uiManager;
    [_uiManager.observerCoordinator addObserver:self];
    return self;
}

- (void)animateTransitions:(NSArray<id<DisplayLinkAnimatorDelegate>>*)animators andTransitioningContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    DisplayLinkAnimator* displayLinkAnimator = [[DisplayLinkAnimator alloc] initWithDisplayLinkAnimators:animators duration:[self transitionDuration:transitionContext]];
    
    [displayLinkAnimator setCompletion:^{
        if (![transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }
    }];
    
    [displayLinkAnimator start];
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return _screenTransition.maxDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    _animate = YES;
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    _transitionContext = transitionContext;
    [_transitionContext.containerView addSubview:toVC.view];
    toVC.view.alpha = 0;
    
    if (![fromVC.navigationController.childViewControllers containsObject:fromVC]) {
        [self performAnimationOnce];
    }
}

- (NSArray *)createTransitionsFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC containerView:(UIView *)containerView {
    ContentTransitionCreator* contentTransition = [ContentTransitionCreator createTransition:_screenTransition.content view:toVC.view fromVC:fromVC toVC:toVC containerView:containerView];
    
    NSArray* elementTransitions = [ElementTransitionsCreator create:_screenTransition.elementTransitions fromVC:fromVC toVC:toVC containerView:containerView];
    NSArray* sharedElementTransitions = [SharedElementTransitionsCreator create:_screenTransition.sharedElementTransitions fromVC:fromVC toVC:toVC containerView:containerView];
    
    
    return [[[NSArray arrayWithObject:contentTransition] arrayByAddingObjectsFromArray:elementTransitions] arrayByAddingObjectsFromArray:sharedElementTransitions];
}

- (void)performAnimationOnce {
    if (_animate) {
        _animate = NO;
        RCTExecuteOnMainQueue(^{
            id<UIViewControllerContextTransitioning> transitionContext = self->_transitionContext;
            UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
            UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
            NSArray* transitions = [self createTransitionsFromVC:fromVC toVC:toVC containerView:transitionContext.containerView];
            [self animateTransitions:transitions andTransitioningContext:transitionContext];
        });
    }
}

- (void)uiManagerDidPerformMounting:(RCTUIManager *)manager {
    [self performAnimationOnce];
}

@end
