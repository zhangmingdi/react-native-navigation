#import <Foundation/Foundation.h>
#import "ElementTransitionOptions.h"
#import "DisplayLinkAnimation.h"

@interface ElementTransition : NSObject

- (instancetype)initWithTransitionOptions:(ElementTransitionOptions *)transitionOptions fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC containerView:(UIView *)containerView;

- (instancetype)initWithTransitionOptions:(ElementTransitionOptions *)transitionOptions fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC containerView:(UIView *)containerView view:(UIView *)view;

- (NSArray<id<DisplayLinkAnimation>>*)create;

@end
