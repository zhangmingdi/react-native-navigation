#import "RNNViewLocation.h"
#import "RNNReactView.h"
#import <React/RCTSafeAreaView.h>

@implementation RNNViewLocation

- (instancetype)initWithFromElement:(RNNElementView *)fromElement toElement:(RNNElementView *)toElement {
	self = [super init];
    self.fromFrame = [self convertViewFrame:fromElement.sourceView];
    self.toFrame = [self convertViewFrame:toElement.sourceView];
	return self;
}

- (CGRect)convertViewFrame:(UIView *)view {
    UIView* topMostView = [self topMostView:view];
    CGRect frame = [topMostView convertRect:view.bounds fromView:view];
    CGFloat safeAreaTopOffset = [self safeAreaOffsetForView:view inView:topMostView];
    frame.origin.y += safeAreaTopOffset;

    return frame;
}

- (UIView *)topMostView:(UIView *)view {
    if ([view isKindOfClass:[RNNReactView class]]) {
        return view;
    } else {
        return [self topMostView:view.superview];
    }
}

- (CGFloat)safeAreaOffsetForView:(UIView *)view inView:(UIView *)inView {
    CGFloat safeAreaOffset = inView.layoutMarginsGuide.layoutFrame.origin.y;
    
    if ([view isKindOfClass:RCTSafeAreaView.class] && [[view valueForKey:@"currentSafeAreaInsets"] UIEdgeInsetsValue].top != safeAreaOffset) {
        return safeAreaOffset;
    } else if (view.superview) {
        return [self safeAreaOffsetForView:view.superview inView:inView];
    }
    
    return 0;
}

@end
