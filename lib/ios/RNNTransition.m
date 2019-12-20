#import "RNNTransition.h"
#import "RNNElementFinder.h"
#import "RNNTransitionStateHolder.h"
#import "AnimatedViewFactory.h"
#import "AnimatedImageView.h"
#import "AnimatedViewFactory.h"
#import "RNNInteractivePopAnimator.h"

@interface RNNTransition ()
@property (nonatomic, strong) UIView* fromElement;
@property (nonatomic, strong) UIView* toElement;
@end

@implementation RNNTransition {
    UIViewController* _toVC;
}

- (instancetype)initFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromElementId:(NSString *)fromElementId toElementId:(NSString *)toElementId transitionOptions:(RNNTransitionStateHolder *)transitionOptions startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint startAlpha:(CGFloat)startAlpha endAlpha:(CGFloat)endAlpha {
	self = [super init];
	self.options = transitionOptions;
    _toVC = toVC;
	self.fromElement = [RNNElementFinder findElementForId:fromElementId inView:fromVC.view];
	self.toElement = [RNNElementFinder findElementForId:toElementId inView:toVC.view];

    self.animatedView = [AnimatedViewFactory createFromElement:self.fromElement toElement:self.toElement alpha:startAlpha endAlpha:endAlpha isSharedElement:transitionOptions.isSharedElementTransition];
	
//	if (transitionOptions.isSharedElementTransition) {
		[self.toElement setHidden:YES];
//	}
	
	return self;
}

- (void)completeAnimation {
//	if (self.options.isSharedElementTransition) {
		[self.toElement setHidden:NO];
//	}

	[self.animatedView removeFromSuperview];
    
//    if (self.options.interactivePop) {
//        RNNInteractivePopAnimator* interactivePopAnimator = [[RNNInteractivePopAnimator alloc] initWithTopView:self.toElement andBottomView:self.fromElement andOriginFrame:self.animatedView.location.fromFrame andViewController:_toVC];
//        UIPanGestureRecognizer* gesture = [[UIPanGestureRecognizer alloc] initWithTarget:interactivePopAnimator
//                                                                                  action:@selector(handleGesture:)];
//        [self.toElement addGestureRecognizer:gesture];
//    }
}

@end
