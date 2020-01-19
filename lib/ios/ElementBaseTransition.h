#import <Foundation/Foundation.h>
#import "TransitionDetailsOptions.h"
#import "DisplayLinkAnimation.h"
#import "RNNInterpolator.h"

@interface ElementBaseTransition : NSObject <DisplayLinkAnimation>

- (instancetype)initToView:(UIView *)view transitionDetails:(TransitionDetailsOptions *)transitionDetails;

- (instancetype)initFromView:(UIView *)view transitionDetails:(TransitionDetailsOptions *)transitionDetails;

- (CGFloat)initialValue;

@property (readonly, strong) UIView* view;
@property (readonly, nonatomic) NSTimeInterval startDelay;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) CGFloat from;
@property (nonatomic) CGFloat to;

@end
