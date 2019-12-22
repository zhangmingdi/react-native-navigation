#import "RNNAnimator.h"
#import "RNNTransition.h"
#import "RNNReactView.h"
#import "DisplayLinkAnimator.h"
#import "RNNAnimatedView.h"

@interface  RNNAnimator()
@property (nonatomic, strong) RNNSharedElementAnimationOptions* transitionOptions;
@property (nonatomic) BOOL backwardTransition;
@property (nonatomic, weak) UIViewController* fromVC;
@property (nonatomic, weak) UIViewController* toVC;
@end

@implementation RNNAnimator

- (instancetype)initWithTransitionOptions:(RNNSharedElementAnimationOptions *)transitionOptions {
    self = [super init];
    if (transitionOptions.animations) {
        [self setupTransition:transitionOptions];
    } else {
        return nil;
    }
    
    return self;
}

- (void)setupTransition:(RNNSharedElementAnimationOptions *)transitionOptions {
    self.transitionOptions = transitionOptions;
    if (!transitionOptions.animations) {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"No animations" userInfo:nil] raise];
    }
}

- (NSArray*)prepareSharedElementTransitionWithComponentView:(UIView*)componentView {
    NSMutableArray* transitions = [NSMutableArray new];
    for (NSDictionary* transitionOptions in self.transitionOptions.animations) {
        
        RNNTransition* transition = [self createTransition:transitionOptions];
        
        [componentView addSubview:transition.animatedView];
        [componentView bringSubviewToFront:transition.animatedView];
        
        [transitions addObject:transition];
    }
    
    return transitions;
}

- (RNNTransition *)createTransition:(NSDictionary *)transitionOptions {
    RNNTransitionStateHolder* transitionStateHolder = [[RNNTransitionStateHolder alloc] initWithDict:transitionOptions];
    if (self.backwardTransition) {
        return [[RNNTransition alloc] initFromVC:self.fromVC toVC:self.toVC fromElementId:transitionStateHolder.toId toElementId:transitionStateHolder.fromId transitionOptions:transitionStateHolder startPoint:transitionStateHolder.endPoint endPoint:transitionStateHolder.startPoint startAlpha:transitionStateHolder.endAlpha endAlpha:transitionStateHolder.startAlpha];
    } else {
        return [[RNNTransition alloc] initFromVC:self.fromVC toVC:self.toVC fromElementId:transitionStateHolder.fromId toElementId:transitionStateHolder.toId transitionOptions:transitionStateHolder startPoint:transitionStateHolder.startPoint endPoint:transitionStateHolder.endPoint startAlpha:transitionStateHolder.startAlpha endAlpha:transitionStateHolder.endAlpha];
    }
}

- (void)animateTransitions:(NSArray<RNNTransition *>*)transitions fromVCSnapshot:(UIView*)fromSnapshot toSnapshot:(UIView *)toSnapshot andTransitioningContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    double duration = self.transitionOptions.duration.doubleValue;
    NSMutableArray<id<DisplayLinkAnimation>>* animations = [NSMutableArray new];
    for (RNNTransition* transition in transitions) {
        [animations addObject:transition.animatedView];
    }
    
    [animations addObject:[[RNNAnimatedView alloc] initWithView:self.toVC.view alpha:0 endAlpha:1]];
    
    DisplayLinkAnimator* displayLinkAnimator = [[DisplayLinkAnimator alloc] initWithDisplayLinkAnimations:animations duration:duration];
    
    [displayLinkAnimator setCompletion:^{
        for (RNNTransition* transition in transitions) {
            [transition completeAnimation];
        }

        [fromSnapshot removeFromSuperview];
        [toSnapshot removeFromSuperview];
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
    UIViewController* toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromVC  = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView* containerView = [transitionContext containerView];
    self.fromVC = fromVC;
    self.toVC = toVC;
    
    
    UIView* fromSnapshot = [fromVC.view snapshotViewAfterScreenUpdates:true];
    
    toVC.view.alpha = 0;
    
    [containerView addSubview:fromSnapshot];
    [transitionContext.containerView addSubview:toVC.view];
    
    NSArray* transitions = [self prepareSharedElementTransitionWithComponentView:containerView];
    [self animateTransitions:transitions fromVCSnapshot:fromSnapshot toSnapshot:nil andTransitioningContext:transitionContext];
}

@end
