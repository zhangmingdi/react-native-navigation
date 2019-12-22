#import "AnimatedReactView.h"

@implementation AnimatedReactView {
    UIView* _originalParent;
    CGRect _originalFrame;
    UIView* _toElement;
}

- (instancetype)initElement:(UIView *)element toElement:(UIView *)toElement alpha:(CGFloat)alpha endAlpha:(CGFloat)endAlpha isSharedElement:(BOOL)isSharedElement {
    self.location = [[RNNViewLocation alloc] initWithFromElement:element toElement:toElement];
    self = [super initWithFrame:self.location.fromFrame];
    _toElement = toElement;
    _toElement.hidden = YES;
    [self hijackReactElement:element];
    
    return self;
}

- (void)hijackReactElement:(UIView *)element {
    _reactView = element;
    _originalFrame = _reactView.frame;
    self.frame = self.location.fromFrame;
    _originalParent = _reactView.superview;
    _reactView.frame = self.bounds;
    [self addSubview:_reactView];
}

- (void)animateWithProgress:(CGFloat)p {
    self.frame = [RNNInterpolator fromRect:self.location.fromFrame toRect:self.location.toFrame precent:p];
}

- (void)end {
    _reactView.frame = _originalFrame;
    [_originalParent addSubview:_reactView];
    _toElement.hidden = NO;
    [self removeFromSuperview];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _reactView.frame = self.bounds;
}

@end
