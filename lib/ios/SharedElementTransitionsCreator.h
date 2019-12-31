#import <Foundation/Foundation.h>
#import "AnimatedReactView.h"

@interface SharedElementTransitionsCreator : NSObject

- (NSArray<AnimatedReactView *>*)createFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC containerView:(UIView *)containerView;

- (instancetype)initWithSharedElementTransitions:(NSArray<SharedElementTransitionOptions *>*)sharedElementTransitions;

@end
