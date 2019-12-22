#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RNNSharedElementAnimationOptions.h"
#import <React/RCTUIManager.h>

@interface CustomTransitionDelegate : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithTransitionOptions:(RNNSharedElementAnimationOptions *)transitionOptions;

@end
