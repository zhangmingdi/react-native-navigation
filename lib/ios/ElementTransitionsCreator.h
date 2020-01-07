#import <Foundation/Foundation.h>
#import "SharedElementTransitionOptions.h"
#import "ElementTransition.h"

@interface ElementTransitionsCreator : NSObject

- (instancetype)initWithElementTransitions:(NSArray<SharedElementTransitionOptions *>*)elementTransitions;

- (NSArray<ElementTransition *>*)createFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC containerView:(UIView *)containerView;

@end
