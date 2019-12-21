#import "AnimatedReactView.h"

@implementation AnimatedReactView {
    UIView* _originalParent;
    CGRect _originalFrame;
}

- (instancetype)initElement:(UIView *)element toElement:(UIView *)toElement alpha:(CGFloat)alpha endAlpha:(CGFloat)endAlpha isSharedElement:(BOOL)isSharedElement {
    self.location = [[RNNViewLocation alloc] initWithFromElement:element toElement:toElement];
    self = [super initWithFrame:self.location.fromFrame];
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
    self.frame = RNNInterpolateRect(self.location.fromFrame, self.location.toFrame, p);
}

- (void)end {
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _reactView.frame = self.bounds;
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    _reactView.frame = _originalFrame;
    [_originalParent addSubview:_reactView];
}

@end
