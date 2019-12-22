#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RNNScreenTransition.h"
#import <React/RCTUIManager.h>

@interface CustomTransitionDelegate : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithScreenTransition:(RNNScreenTransition *)screenTransition;

@end
