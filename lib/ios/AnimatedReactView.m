#import "AnimatedReactView.h"

@implementation AnimatedReactView {
    UIView* _originalParent;
    CGRect _originalFrame;
    UIView* _toElement;
    SharedElementTransitionOptions* _transitionOptions;
}

- (instancetype)initElement:(UIView *)element toElement:(UIView *)toElement transitionOptions:(SharedElementTransitionOptions *)transitionOptions {
    self.location = [[RNNViewLocation alloc] initWithFromElement:element toElement:toElement];
    self = [super initWithFrame:self.location.fromFrame];
    _transitionOptions = transitionOptions;
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

- (CGAffineTransform)animateWithProgress:(CGFloat)p {
    self.frame = [RNNInterpolator fromRect:self.location.fromFrame toRect:self.location.toFrame precent:p];
    return CGAffineTransformIdentity;
}

- (void)end {
    _reactView.frame = _originalFrame;
    [_originalParent addSubview:_reactView];
    _toElement.hidden = NO;
    [self removeFromSuperview];
}

- (NSTimeInterval)duration {
    return [_transitionOptions.duration getWithDefaultValue:0.7];
}

- (NSTimeInterval)startDelay {
    return [_transitionOptions.startDelay getWithDefaultValue:0.0];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _reactView.frame = self.bounds;
}

@end
