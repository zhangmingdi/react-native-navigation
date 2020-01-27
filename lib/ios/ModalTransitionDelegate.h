#import "TransitionDelegate.h"
#import "TransitionOptions.h"

@interface ModalTransitionDelegate : TransitionDelegate

- (instancetype)initWithContentTransition:(TransitionOptions *)contentTransition uiManager:(RCTUIManager *)uiManager;

@end
