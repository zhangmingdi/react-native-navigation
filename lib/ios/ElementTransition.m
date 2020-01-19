#import "ElementTransition.h"
#import "ElementAlphaTransition.h"
#import "ElementVerticalTransition.h"
#import "ElementHorizontalTransition.h"
#import "HorizontalTranslationTransition.h"
#import "VerticalTranslationTransition.h"
#import "Transition.h"
#import "RNNElementFinder.h"

@implementation ElementTransition {
    ElementTransitionOptions* _transitionOptions;
    UIViewController* _toVC;
    UIViewController* _fromVC;
    UIView* _containerView;
    UIView* _view;
    BOOL _from;
}

- (instancetype)initWithTransitionOptions:(ElementTransitionOptions *)transitionOptions fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC containerView:(UIView *)containerView {
    self = [super init];
    _transitionOptions = transitionOptions;
    _fromVC = fromVC;
    _toVC = toVC;
    _containerView = containerView;
    _view = [self findElementById:transitionOptions.elementId];
    return self;
}

- (instancetype)initWithTransitionOptions:(ElementTransitionOptions *)transitionOptions fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC containerView:(UIView *)containerView view:(UIView *)view {
    self = [self initWithTransitionOptions:transitionOptions fromVC:fromVC toVC:toVC containerView:containerView];
    _view = view;
    return self;
}

- (NSArray<id<DisplayLinkAnimation>>*)create {
    NSMutableArray* transitions = [NSMutableArray new];
    if (_transitionOptions.alpha.hasAnimation) {
        [transitions addObject:self.alpha];
    }
    
    if (_transitionOptions.y.hasAnimation) {
        [transitions addObject:self.y];
    }
    
    if (_transitionOptions.x.hasAnimation) {
        [transitions addObject:self.x];
    }
    
    if (_transitionOptions.translationX.hasAnimation) {
        [transitions addObject:self.translationX];
    }
    
    if (_transitionOptions.translationY.hasAnimation) {
        [transitions addObject:self.translationY];
    }
    
    return transitions;
}

- (UIView *)findElementById:(NSString *)elementId {
    UIView* viewInSourceView = [RNNElementFinder findElementForId:elementId inView:_fromVC.view];
    if (viewInSourceView) {
        return viewInSourceView;
    }
    
    UIView* viewInDestinationView = [RNNElementFinder findElementForId:elementId inView:_toVC.view];
    if (viewInDestinationView) {
        _from = YES;
        return viewInDestinationView;
    }
    
    return nil;
}

- (ElementAlphaTransition *)alpha {
    return [[ElementAlphaTransition alloc] initWithView:_view transitionDetails:_transitionOptions.alpha];
}

- (ElementVerticalTransition *)y {
    return [[ElementVerticalTransition alloc] initWithView:_view transitionDetails:_transitionOptions.y];
}

- (ElementHorizontalTransition *)x {
    return [[ElementHorizontalTransition alloc] initWithView:_view transitionDetails:_transitionOptions.x];
}

- (ElementHorizontalTransition *)translationX {
    return [[ElementHorizontalTransition alloc] initWithView:_view transitionDetails:_transitionOptions.translationX];
}

- (VerticalTranslationTransition *)translationY {
    return [[VerticalTranslationTransition alloc] initWithView:_view transitionDetails:_transitionOptions.translationY];
}


@end
