#import "AnimatedTextView.h"
#import <React/RCTComponentData.h>
#import <React/RCTTextView.h>
#import "FrameAnimator.h"

@implementation AnimatedTextView {
    RCTTextView* _tv;
    NSTextContainer* _origTextContainer;
    NSTextContainer* _endTextContainer;
    NSTextStorage* _textStorage;
    NSTextStorage* _endTextStorage;
    CGSize _origSize;
    UIView* _origParent;
    CGRect _origFrame;
    CGRect _endFrame;
    NSDate* _fireDate;
    CGFloat _duration;
}

- (instancetype)initElement:(RNNElementView *)element toElement:(RNNElementView *)toElement frame:(CGRect)frame endFrame:(CGRect)endFrame alpha:(CGFloat)alpha endAlpha:(CGFloat)endAlpha isSharedElement:(BOOL)isSharedElement {
    self = [super initElement:element toElement:toElement frame:frame endFrame:endFrame alpha:alpha endAlpha:endAlpha isSharedElement:isSharedElement];
    
    _origTextContainer = [self container:[element.sourceView valueForKey:@"textStorage"]];
    _endTextContainer = [self container:[toElement.sourceView valueForKey:@"textStorage"]];
    _textStorage = _origTextContainer.layoutManager.textStorage;
    _endTextStorage = _endTextContainer.layoutManager.textStorage;
    _origSize = _origTextContainer.size;
    _origFrame = frame;
    _endFrame = endFrame;
    
    _tv = element.sourceView;
    _origParent = _tv.superview;
    [_tv removeFromSuperview];
    
    [self addSubview:_tv];
    
    return self;
}

- (void)animateWithDuration:(CGFloat)duration delay:(CGFloat)delay usingSpringWithDamping:(CGFloat)springDamping initialSpringVelocity:(CGFloat)springVelocity options:(UIViewAnimationOptions)options {
    [FrameAnimator animateView:self toFrame:_endFrame duration:duration];
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
    [_tv setTextStorage:_textStorage contentFrame:_tv.frame descendantViews:@[]];
    [_tv removeFromSuperview];
    [_origParent addSubview:_tv];
}

- (NSTextContainer *)container:(NSTextStorage *)fromTextStorage {
    return fromTextStorage.layoutManagers.firstObject.textContainers.firstObject;
}

@end
