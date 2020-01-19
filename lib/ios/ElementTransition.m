#import "ElementTransition.h"
#import "ElementAlphaTransition.h"
#import "ElementVerticalTransition.h"
#import "ElementHorizontalTransition.h"
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
    if (_from) {
        return [[ElementAlphaTransition alloc] initFromView:_view transitionDetails:_transitionOptions.alpha];
    } else {
        return [[ElementAlphaTransition alloc] initToView:_view transitionDetails:_transitionOptions.alpha];
    }
}

- (ElementVerticalTransition *)y {
    if (_from) {
        return [[ElementVerticalTransition alloc] initFromView:_view transitionDetails:_transitionOptions.y];
    } else {
        return [[ElementVerticalTransition alloc] initToView:_view transitionDetails:_transitionOptions.y];
    }
}

- (ElementHorizontalTransition *)x {
    if (_from) {
        return [[ElementHorizontalTransition alloc] initFromView:_view transitionDetails:_transitionOptions.x];
    } else {
        return [[ElementHorizontalTransition alloc] initToView:_view transitionDetails:_transitionOptions.x];
    }
}


@end
