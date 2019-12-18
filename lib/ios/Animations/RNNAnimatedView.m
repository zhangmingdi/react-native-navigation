#import "RNNAnimatedView.h"
#import <React/RCTImageView.h>

@implementation RNNAnimatedView {
    CGFloat _endAlpha;
    UIView* _animatedView;
    BOOL _isSharedElement;
}

- (instancetype)initElement:(RNNElementView *)element toElement:(RNNElementView *)toElement alpha:(CGFloat)alpha endAlpha:(CGFloat)endAlpha isSharedElement:(BOOL)isSharedElement {
    self = [super init];
    
    self.location = [[RNNViewLocation alloc] initWithFromElement:element toElement:toElement];
    self.frame = self.location.fromFrame;
    _endAlpha = endAlpha;
    _isSharedElement = isSharedElement;

    self.alpha = alpha;
    
	return self;
}

- (void)animateWithDuration:(CGFloat)duration delay:(CGFloat)delay usingSpringWithDamping:(CGFloat)springDamping initialSpringVelocity:(CGFloat)springVelocity options:(UIViewAnimationOptions)options {
    if (_isSharedElement) {
        [UIView animateWithDuration:duration animations:^{
            [self setAnimatedViewFinalProperties];
            [self layoutSubviews];
        }];
    } else {
        [UIView animateWithDuration:duration delay:delay usingSpringWithDamping:springDamping initialSpringVelocity:springVelocity options:UIViewAnimationOptionLayoutSubviews animations:^{
            [self setAnimatedViewFinalProperties];
        } completion:^(BOOL finished) {
    
        }];
    }
}

- (void)setAnimatedViewFinalProperties {
    self.alpha = _endAlpha;
    self.frame = self.location.toFrame;
}


@end
