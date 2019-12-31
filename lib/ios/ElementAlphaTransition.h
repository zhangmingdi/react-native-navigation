#import <UIKit/UIKit.h>
#import "DisplayLinkAnimation.h"
#import "RNNInterpolator.h"
#import "TransitionOptions.h"

@interface ElementAlphaTransition : NSObject <DisplayLinkAnimation>

- (instancetype)initWithView:(UIView *)view transitionOptions:(TransitionOptions *)transitionOptions;

@end
