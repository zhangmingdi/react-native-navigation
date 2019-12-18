#import "RNNTransition.h"
#import "RNNElementFinder.h"
#import "RNNTransitionStateHolder.h"
#import "RNNViewLocation.h"
#import "RNNInteractivePopAnimator.h"
#import "AnimatedViewFactory.h"
#import "AnimatedImageView.h"
#import "AnimatedViewFactory.h"

@interface RNNTransition () {
	UIViewController* _toVC;
	UIViewController* _fromVC;
}

@property (nonatomic, strong) RNNElementView* fromElement;
@property (nonatomic, strong) RNNElementView* toElement;
@property (nonatomic, strong) RNNViewLocation* locations;

@end

@implementation RNNTransition

- (instancetype)initFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromElementId:(NSString *)fromElementId toElementId:(NSString *)toElementId transitionOptions:(RNNTransitionStateHolder *)transitionOptions startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint startAlpha:(CGFloat)startAlpha endAlpha:(CGFloat)endAlpha {
	self = [super init];
	
	_toVC = toVC;
	_fromVC = fromVC;
    
	self.options = transitionOptions;
	
	RNNElementFinder* elementFinder = [[RNNElementFinder alloc] initWithToVC:toVC andfromVC:fromVC];
	self.fromElement = [elementFinder findElementForId:fromElementId];
	self.toElement = [elementFinder findElementForId:toElementId];
    self.locations = [[RNNViewLocation alloc] initWithFromElement:self.fromElement toElement:self.toElement startPoint:startPoint endPoint:endPoint andVC:fromVC toVC:toVC];
	
    self.animatedView = [AnimatedViewFactory createFromElement:self.fromElement toElement:self.toElement frame:self.locations.fromFrame endFrame:self.locations.toFrame alpha:startAlpha endAlpha:endAlpha isSharedElement:transitionOptions.isSharedElementTransition];
	
	if (transitionOptions.isSharedElementTransition) {
		[self.toElement setHidden: YES];
	}
	
	[self.fromElement setHidden:YES];
	
	return self;
}

- (void)animate {
    [self.animatedView animateWithDuration:self.options.duration delay:self.options.startDelay usingSpringWithDamping:self.options.springDamping initialSpringVelocity:self.options.springVelocity options:UIViewAnimationOptionLayoutSubviews];
}

- (void)transitionCompleted {
	[self.fromElement setHidden:NO];
	if (self.options.isSharedElementTransition) {
		[self.toElement setHidden:NO];
	}
	
	[self.animatedView removeFromSuperview];
	
	if (self.options.interactivePop) {
		RNNInteractivePopAnimator* interactivePopAnimator = [[RNNInteractivePopAnimator alloc] initWithTopView:self.toElement andBottomView:self.fromElement andOriginFrame:self.locations.fromFrame andViewController:_toVC];
		UIPanGestureRecognizer* gesture = [[UIPanGestureRecognizer alloc] initWithTarget:interactivePopAnimator
																				  action:@selector(handleGesture:)];
		[self.toElement addGestureRecognizer:gesture];
	}
}

@end
