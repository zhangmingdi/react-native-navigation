#import <Foundation/Foundation.h>
#import "ElementTransitionOptions.h"
#import "DisplayLinkAnimation.h"

@interface ElementTransitionCreator : NSObject

- (instancetype)initWithTransitionOptions:(ElementTransitionOptions *)transitionOptions;

- (NSArray<id<DisplayLinkAnimation>>*)createWithView:(UIView *)view containerView:(UIView *)containerView;

@end
