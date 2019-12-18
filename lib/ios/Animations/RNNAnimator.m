#import "RNNAnimator.h"
#import "RNNTransition.h"
#import "RNNReactView.h"
#import <React/RCTUIManagerUtils.h>

@interface  RNNAnimator()
@property (nonatomic, strong) RNNSharedElementAnimationOptions* transitionOptions;
@property (nonatomic) BOOL backwardTransition;
@property (nonatomic, weak) UIViewController* fromVC;
@property (nonatomic, weak) UIViewController* toVC;
@property (nonatomic, weak) RCTUIManager* uiManager;
@end

@implementation RNNAnimator

-(instancetype)initWithTransitionOptions:(RNNSharedElementAnimationOptions *)transitionOptions uiManager:(RCTUIManager *)uiManager {
	self = [super init];
    _uiManager = uiManager;
	if (transitionOptions.animations) {
		[self setupTransition:transitionOptions];
	} else {
		return nil;
	}
	
	return self;
}

-(void)setupTransition:(RNNSharedElementAnimationOptions *)transitionOptions {
	self.transitionOptions = transitionOptions;
	if (!transitionOptions.animations) {
		[[NSException exceptionWithName:NSInvalidArgumentException reason:@"No animations" userInfo:nil] raise];
	}
}

-(NSArray*)prepareSharedElementTransitionWithComponentView:(UIView*)componentView {
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
        return [[RNNTransition alloc] initFromVC:self.toVC toVC:self.fromVC fromElementId:transitionStateHolder.toId toElementId:transitionStateHolder.fromId transitionOptions:transitionStateHolder startPoint:transitionStateHolder.endPoint endPoint:transitionStateHolder.startPoint startAlpha:transitionStateHolder.endAlpha endAlpha:transitionStateHolder.startAlpha];
    } else {
        return [[RNNTransition alloc] initFromVC:self.fromVC toVC:self.toVC fromElementId:transitionStateHolder.fromId toElementId:transitionStateHolder.toId transitionOptions:transitionStateHolder startPoint:transitionStateHolder.startPoint endPoint:transitionStateHolder.endPoint startAlpha:transitionStateHolder.startAlpha endAlpha:transitionStateHolder.endAlpha];
    }
}

-(void)animateTransitions:(NSArray*)transitions {
	for (RNNTransition* transition in transitions ) {
		[transition animate];
	}
}

-(void)animateCompletion:(NSArray*)transitions fromVCSnapshot:(UIView*)fromSnapshot andTransitioningContext:(id<UIViewControllerContextTransitioning>)transitionContext {
	[UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:[self.transitionOptions.springDamping doubleValue] initialSpringVelocity:[self.transitionOptions.springVelocity doubleValue] options:UIViewAnimationOptionLayoutSubviews  animations:^{
				self.toVC.view.alpha = 1;
			} completion:^(BOOL finished) {
				for (RNNTransition* transition in transitions ) {
					[transition transitionCompleted];
				}
				
				[fromSnapshot removeFromSuperview];
				if (![transitionContext transitionWasCancelled]) {
					self.toVC.view.alpha = 1;
					[transitionContext completeTransition:![transitionContext transitionWasCancelled]];
					self.backwardTransition = true;
				}
			}];
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
	[containerView addSubview:toVC.view];
    
    NSArray* transitions = [self prepareSharedElementTransitionWithComponentView:containerView];
    [self animateCompletion:transitions fromVCSnapshot:fromSnapshot andTransitioningContext:transitionContext];
    [self animateTransitions:transitions];
}

@end
