#import "AnimatedTextView.h"
#import "FrameAnimator.h"
#import <React/RCTTextView.h>

@implementation AnimatedTextView {
    RCTTextView* _tv;
    NSTextContainer* _origTextContainer;
    CGSize _origSize;
    UIView* _origParent;
}

- (instancetype)initElement:(RNNElementView *)element toElement:(RNNElementView *)toElement alpha:(CGFloat)alpha endAlpha:(CGFloat)endAlpha isSharedElement:(BOOL)isSharedElement {
    self = [super initElement:element toElement:toElement alpha:alpha endAlpha:endAlpha isSharedElement:isSharedElement];
    
    _origTextContainer = [self container:[element.sourceView valueForKey:@"textStorage"]];
    _origSize = _origTextContainer.size;
    
    [self hijackReactTextView:(RCTTextView *)element.sourceView];
    
    return self;
}

- (void)hijackReactTextView:(RCTTextView *)reactTextView {
    _tv = reactTextView;
    _origParent = _tv.superview;
    [_tv removeFromSuperview];
    [self addSubview:_tv];
}

- (void)animateWithDuration:(CGFloat)duration delay:(CGFloat)delay usingSpringWithDamping:(CGFloat)springDamping initialSpringVelocity:(CGFloat)springVelocity options:(UIViewAnimationOptions)options {
    [FrameAnimator animateView:self toFrame:self.location.toFrame duration:duration];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _tv.frame = self.bounds;
    _origTextContainer.size = self.frame.size;
}

- (void)setAnimatedViewFinalProperties {
    
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    [self restoreHijackedElements];
}

- (void)restoreHijackedElements {
    _origTextContainer.size = _origSize;
    [_tv setFrame:CGRectMake(_tv.frame.origin.x, _tv.frame.origin.y, _origSize.width, _origSize.height)];
    [_tv removeFromSuperview];
    [_origParent addSubview:_tv];
}

- (NSTextContainer *)container:(NSTextStorage *)fromTextStorage {
    return fromTextStorage.layoutManagers.firstObject.textContainers.firstObject;
}

@end
