#import "RNNAnimatedView.h"
#import "RNNElementView.h"
#import <React/RCTImageView.h>

@implementation RNNAnimatedView {
    CGFloat _endAlpha;
    CGRect _endFrame;
    UIView* _animatedView;
}

- (instancetype)initElement:(RNNElementView *)element toElement:(RNNElementView *)toElement frame:(CGRect)frame endFrame:(CGRect)endFrame alpha:(CGFloat)alpha endAlpha:(CGFloat)endAlpha isSharedElement:(BOOL)isSharedElement {
    self = [super initWithFrame:frame];
    _endFrame = endFrame;
    _endAlpha = endAlpha;
    
    self.frame = frame;
    self.alpha = alpha;
    
	return self;
}

- (void)animateWithDuration:(CGFloat)duration delay:(CGFloat)delay usingSpringWithDamping:(CGFloat)springDamping initialSpringVelocity:(CGFloat)springVelocity options:(UIViewAnimationOptions)options {
    [UIView animateWithDuration:duration animations:^{
        [self setAnimatedViewFinalProperties];
        [self layoutSubviews];
    }];
//    [UIView animateWithDuration:duration delay:delay usingSpringWithDamping:springDamping initialSpringVelocity:springVelocity options:UIViewAnimationOptionLayoutSubviews animations:^{
//        [self setAnimatedViewFinalProperties];
//    } completion:^(BOOL finished) {
//
//    }];
}

- (void)setAnimatedViewFinalProperties {
    self.alpha = _endAlpha;
    self.frame = _endFrame;
}


@end
