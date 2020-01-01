#import <UIKit/UIKit.h>
#import "DisplayLinkAnimation.h"
#import "TransitionOptions.h"
#import "ElementBaseTransition.h"

@interface ElementAlphaTransition : ElementBaseTransition <DisplayLinkAnimation>

- (instancetype)initWithView:(UIView *)view transitionOptions:(TransitionOptions *)transitionOptions;

@end
