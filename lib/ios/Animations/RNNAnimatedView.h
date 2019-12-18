#import <UIKit/UIKit.h>
#import "RNNViewLocation.h"
#import "VICMAImageView.h"


@interface RNNAnimatedView : UIView

- (instancetype)initElement:(RNNElementView*)element toElement:(RNNElementView *)toElement frame:(CGRect)frame endFrame:(CGRect)endFrame alpha:(CGFloat)alpha endAlpha:(CGFloat)endAlpha isSharedElement:(BOOL)isSharedElement;

- (void)setAnimatedViewFinalProperties;

- (void)animateWithDuration:(CGFloat)duration delay:(CGFloat)delay usingSpringWithDamping:(CGFloat)springDamping initialSpringVelocity:(CGFloat)springVelocity options:(UIViewAnimationOptions)options;

@end
