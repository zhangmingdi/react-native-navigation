#import <Foundation/Foundation.h>
#import "RNNTransitionStateHolder.h"
#import "RNNAnimatedView.h"

@interface RNNTransition : NSObject

@property (nonatomic, strong) RNNAnimatedView* animatedView;
@property (nonatomic, strong) RNNTransitionStateHolder* options;

- (instancetype)initFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromElementId:(NSString *)fromElementId toElementId:(NSString *)toElementId transitionOptions:(RNNTransitionStateHolder *)transitionOptions startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint startAlpha:(CGFloat)startAlpha endAlpha:(CGFloat)endAlpha;

- (void)animate;

- (void)transitionCompleted;

@end
