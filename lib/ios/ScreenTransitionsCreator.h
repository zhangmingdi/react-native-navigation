#import <Foundation/Foundation.h>
#import "RNNScreenTransition.h"
#import "DisplayLinkAnimation.h"

@interface ScreenTransitionsCreator : NSObject

- (instancetype)initWithScreenTransition:(RNNScreenTransition *)screenTransition;

- (NSArray<id<DisplayLinkAnimation>> *)createFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC containerView:(UIView *)containerView;

- (NSTimeInterval)minDuration;

@end
