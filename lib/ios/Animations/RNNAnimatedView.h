#import <UIKit/UIKit.h>
#import "RNNViewLocation.h"

@interface RNNAnimatedView : UIView


@property (nonatomic, strong) RNNViewLocation* location;


- (instancetype)initElement:(RNNElementView*)element toElement:(RNNElementView *)toElement alpha:(CGFloat)alpha endAlpha:(CGFloat)endAlpha isSharedElement:(BOOL)isSharedElement;

- (void)setAnimatedViewFinalProperties;

- (void)animateWithDuration:(CGFloat)duration delay:(CGFloat)delay usingSpringWithDamping:(CGFloat)springDamping initialSpringVelocity:(CGFloat)springVelocity options:(UIViewAnimationOptions)options;

@end
