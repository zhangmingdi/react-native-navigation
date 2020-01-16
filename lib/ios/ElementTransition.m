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
        [transitions addObject:[[ElementAlphaTransition alloc] initWithView:_view transitionDetails:_transitionOptions.alpha]];
    }
    
    if (_transitionOptions.x.hasAnimation) {
        [transitions addObject:[[ElementVerticalTransition alloc] initWithView:_view transitionDetails:_transitionOptions.x]];
    }
    
    if (_transitionOptions.y.hasAnimation) {
        [transitions addObject:[[ElementHorizontalTransition alloc] initWithView:_view transitionDetails:_transitionOptions.y]];
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
        return viewInDestinationView;
    }
    
    return nil;
}

//- (TransitionDetailsOptions *)alpha {
//    TransitionDetailsOptions* transition = [[TransitionDetailsOptions alloc] init];
//    transition.to
//    _to = [transitionDetails.to getWithDefaultValue:0];
//    NSAssert(transitionDetails.from.hasValue, @"Transitioning elements in current visible screen `from` value is taken from the element initial values, `from` value should be removed");
//    _from = self.initialValue;
//}

//- (TransitionDetailsOptions *)alpha {
////    _to = [transitionDetails.to getWithDefaultValue:0];
////    NSAssert(transitionDetails.from.hasValue, @"Transitioning elements in current visible screen `from` value is taken from the element initial values, `from` value should be removed");
////    _from = self.initialValue;
//}


@end
