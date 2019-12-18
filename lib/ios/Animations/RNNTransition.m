#import "RNNTransition.h"
#import "RNNElementFinder.h"
#import "RNNTransitionStateHolder.h"
#import "AnimatedViewFactory.h"
#import "AnimatedImageView.h"
#import "AnimatedViewFactory.h"

@interface RNNTransition ()
@property (nonatomic, strong) RNNElementView* fromElement;
@property (nonatomic, strong) RNNElementView* toElement;
@end

@implementation RNNTransition

- (instancetype)initFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromElementId:(NSString *)fromElementId toElementId:(NSString *)toElementId transitionOptions:(RNNTransitionStateHolder *)transitionOptions startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint startAlpha:(CGFloat)startAlpha endAlpha:(CGFloat)endAlpha {
	self = [super init];
	self.options = transitionOptions;
	
	RNNElementFinder* elementFinder = [[RNNElementFinder alloc] initWithToVC:toVC andfromVC:fromVC];
	self.fromElement = [elementFinder findElementForId:fromElementId];
	self.toElement = [elementFinder findElementForId:toElementId];

    self.animatedView = [AnimatedViewFactory createFromElement:self.fromElement toElement:self.toElement alpha:startAlpha endAlpha:endAlpha isSharedElement:transitionOptions.isSharedElementTransition];
	
	if (transitionOptions.isSharedElementTransition) {
		[self.toElement setHidden: YES];
	}
	
	[self.fromElement setHidden:YES];
	
	return self;
}

- (void)animate {
    [self.animatedView animateWithDuration:self.options.duration delay:self.options.startDelay usingSpringWithDamping:self.options.springDamping initialSpringVelocity:self.options.springVelocity options:self.options.interpolation];
}

- (void)transitionCompleted {
	[self.fromElement setHidden:NO];
	if (self.options.isSharedElementTransition) {
		[self.toElement setHidden:NO];
	}
	
	[self.animatedView removeFromSuperview];
}

@end
