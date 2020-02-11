#import "SharedElementAnimator.h"
#import "AnimatedViewFactory.h"
#import "RectTransition.h"
#import "ColorTransition.h"
#import "AnimatedTextView.h"
#import "TextStorageTransition.h"
#import "AnchorTransition.h"

@implementation SharedElementAnimator {
    SharedElementTransitionOptions* _transitionOptions;
    UIViewController* _toVC;
    UIViewController* _fromVC;
    UIView* _fromView;
    UIView* _toView;
    UIView* _containerView;
}

- (instancetype)initWithTransitionOptions:(SharedElementTransitionOptions *)transitionOptions fromView:(UIView *)fromView toView:(UIView *)toView fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC containerView:(UIView *)containerView {
    self = [super init];
    _transitionOptions = transitionOptions;
    _fromVC = fromVC;
    _toVC = toVC;
    _fromView = fromView;
    _toView = toView;
    _containerView = containerView;
    self.view = [self createAnimatedView:transitionOptions fromView:fromView toView:toView];
    self.animations = [self createAnimations];
    return self;
}

- (AnimatedReactView *)createAnimatedView:(SharedElementTransitionOptions *)transitionOptions fromView:(UIView *)fromView toView:(UIView *)toView {
    return [AnimatedViewFactory createFromElement:fromView toElement:toView transitionOptions:transitionOptions];
}

- (NSMutableArray<id<DisplayLinkAnimation>> *)createAnimations {
    NSMutableArray* animations = [NSMutableArray new];
    CGFloat startDelay = [_transitionOptions.startDelay getWithDefaultValue:0];
    CGFloat duration = [_transitionOptions.duration getWithDefaultValue:300];
    Text* interpolation = [_transitionOptions.interpolation getWithDefaultValue:@"accelerateDecelerate"];
    
    if (!CGSizeEqualToSize(self.view.location.fromFrame.size, self.view.location.toFrame.size)) {
        [animations addObject:[[RectTransition alloc] initWithView:self.view from:self.view.location.fromFrame to:self.view.location.toFrame startDelay:startDelay duration:duration interpolation:interpolation]];
    } else if (!CGPointEqualToPoint(self.view.location.fromFrame.origin, self.view.location.toFrame.origin)) {
        [animations addObject:[[AnchorTransition alloc] initWithView:self.view from:self.view.location.fromFrame.origin to:self.view.location.toFrame.origin startDelay:startDelay duration:duration interpolation:interpolation]];
    }
    
    if (![_fromView.backgroundColor isEqual:_toView.backgroundColor]) {
        [animations addObject:[[ColorTransition alloc] initWithView:self.view from:_fromView.backgroundColor to:_toView.backgroundColor startDelay:startDelay duration:duration interpolation:interpolation]];
    }
    
    if ([self.view isKindOfClass:AnimatedTextView.class]) {
        [animations addObject:[[TextStorageTransition alloc] initWithView:self.view from:((AnimatedTextView *)self.view).fromTextStorage to:((AnimatedTextView *)self.view).toTextStorage startDelay:startDelay duration:duration interpolation:interpolation]];
    }
    
    return animations;
}

- (void)end {
    [super end];
    [self.view reset];
}


@end
