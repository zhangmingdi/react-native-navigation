#import "RNNAnimatedView.h"
#import <React/RCTImageView.h>

@implementation RNNAnimatedView {
    CGFloat _endAlpha;
    BOOL _isSharedElement;
    UIView* _originalParent;
    CGRect _originalFrame;
}

- (instancetype)initElement:(UIView *)element toElement:(UIView *)toElement alpha:(CGFloat)alpha endAlpha:(CGFloat)endAlpha isSharedElement:(BOOL)isSharedElement {
    self.location = [[RNNViewLocation alloc] initWithFromElement:element toElement:toElement];
    self = [super initWithFrame:self.location.fromFrame];
    
    _reactView = element;
    _endAlpha = endAlpha;
    _isSharedElement = isSharedElement;
    _originalFrame = _reactView.frame;
    self.frame = self.location.fromFrame;
    _originalParent = _reactView.superview;
    _reactView.frame = self.bounds;
    [self addSubview:_reactView];
    self.alpha = alpha;
    
	return self;
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
