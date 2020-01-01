#import <Foundation/Foundation.h>
#import "TransitionOptions.h"
#import "DisplayLinkAnimation.h"
#import "RNNInterpolator.h"

@interface ElementBaseTransition : NSObject <DisplayLinkAnimation>

- (instancetype)initWithView:(UIView *)view transitionOptions:(TransitionOptions *)transitionOptions;

@property (readonly, strong) UIView* view;
@property (readonly, nonatomic) NSTimeInterval startDelay;
@property (readonly, nonatomic) NSTimeInterval duration;

@end
