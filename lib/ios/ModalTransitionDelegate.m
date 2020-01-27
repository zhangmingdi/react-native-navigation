#import "ModalTransitionDelegate.h"
#import "ContentTransitionCreator.h"

@implementation ModalTransitionDelegate {
    TransitionOptions* _contentTransitionOptions;
}

- (instancetype)initWithContentTransition:(TransitionOptions *)contentTransitionOptions uiManager:(RCTUIManager *)uiManager {
    self = [super initWithUIManager:uiManager];
    _contentTransitionOptions = contentTransitionOptions;
    return self;
}

- (NSArray *)createTransitionsFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC containerView:(UIView *)containerView {
    ContentTransitionCreator* contentTransition = [ContentTransitionCreator createTransition:_contentTransitionOptions view:toVC.view fromVC:fromVC toVC:toVC containerView:containerView];
    
    return @[contentTransition];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}

@end
