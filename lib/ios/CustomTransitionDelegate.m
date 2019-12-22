#import "CustomTransitionDelegate.h"
#import "RNNTransition.h"
#import "RNNReactView.h"
#import "DisplayLinkAnimator.h"
#import "RNNAnimatedView.h"
#import "RNNElementFinder.h"
#import "AnimatedViewFactory.h"

@interface  CustomTransitionDelegate()
@property (nonatomic, strong) RNNSharedElementAnimationOptions* transitionOptions;
@property (nonatomic) BOOL backwardTransition;
@property (nonatomic, weak) UIViewController* fromVC;
@property (nonatomic, weak) UIViewController* toVC;
@end

@implementation CustomTransitionDelegate

- (instancetype)initWithTransitionOptions:(RNNSharedElementAnimationOptions *)transitionOptions {
    self = [super init];
    if (transitionOptions.animations) {
        self.transitionOptions = transitionOptions;
    } else {
        return nil;
    }
    
    return self;
}

- (NSArray<AnimatedReactView *>*)createSharedElementViews {
    NSMutableArray* transitions = [NSMutableArray new];
    for (NSDictionary* transitionOptions in self.transitionOptions.animations) {
        AnimatedReactView* animatedView = [self createAnimatedView:transitionOptions];
        [transitions addObject:animatedView];
    }
    
    return transitions;
}

- (void)addSharedElementViews:(NSArray<AnimatedReactView *> *)views toContainerView:(UIView *)containerView {
    for (AnimatedReactView* view in views) {
        [containerView addSubview:view];
        [containerView bringSubviewToFront:view];
    }
}

- (AnimatedReactView *)createAnimatedView:(NSDictionary *)transitionOptions {
    RNNTransitionStateHolder* transitionStateHolder = [[RNNTransitionStateHolder alloc] initWithDict:transitionOptions];
    if (self.backwardTransition) {
        UIView *fromElement = [RNNElementFinder findElementForId:transitionStateHolder.toId inView:self.fromVC.view];
        UIView *toElement = [RNNElementFinder findElementForId:transitionStateHolder.fromId inView:self.toVC.view];
        return [AnimatedViewFactory createFromElement:fromElement toElement:toElement alpha:transitionStateHolder.startAlpha endAlpha:transitionStateHolder.endAlpha isSharedElement:YES];
    } else {
        UIView *fromElement = [RNNElementFinder findElementForId:transitionStateHolder.fromId inView:self.fromVC.view];
        UIView *toElement = [RNNElementFinder findElementForId:transitionStateHolder.toId inView:self.toVC.view];
        return [AnimatedViewFactory createFromElement:fromElement toElement:toElement alpha:transitionStateHolder.startAlpha endAlpha:transitionStateHolder.endAlpha isSharedElement:YES];
    }
}

- (void)animateTransitions:(NSArray<id<DisplayLinkAnimation>>*)animations andTransitioningContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    double duration = self.transitionOptions.duration.doubleValue;
    DisplayLinkAnimator* displayLinkAnimator = [[DisplayLinkAnimator alloc] initWithDisplayLinkAnimations:animations duration:duration];
    
    [displayLinkAnimator setCompletion:^{
        if (![transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            self.backwardTransition = true;
        }
    }];
    
    [displayLinkAnimator start];
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return [self.transitionOptions.duration doubleValue];
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [transitionContext.containerView addSubview:self.toVC.view];
    
    NSMutableArray<id<DisplayLinkAnimation>>* animations = [NSMutableArray new];
    
    NSArray* sharedElementViews = [self createSharedElementViews];
    [self addSharedElementViews:sharedElementViews toContainerView:transitionContext.containerView];
    
    [animations addObjectsFromArray:sharedElementViews];
    [animations addObject:[[RNNAnimatedView alloc] initWithView:self.toVC.view alpha:0 endAlpha:1]];
    
    
    [self animateTransitions:animations andTransitioningContext:transitionContext];
}

@end
