#import "RNNViewLocation.h"
#import <React/RCTSafeAreaView.h>

@implementation RNNViewLocation

- (instancetype)initWithFromElement:(RNNElementView *)fromElement toElement:(RNNElementView *)toElement startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint andVC:(UIViewController *)vc toVC:(UIViewController *)toVC {
	self = [super init];
	
    UIView *fromView = fromElement.sourceView;
    UIView *toView = toElement.sourceView;
    
    self.fromFrame = [self frameFromSuperViewController:fromView andView:vc.view];
    self.toFrame = [self frameFromSuperViewController:toView andView:toVC.view];
	
	return self;
}

- (CGRect)frameFromSuperViewController:(UIView *)view andView:(UIView *)su {
    CGRect frame = [su convertRect:view.bounds fromView:view];
    CGFloat safeAreaTopOffset = [self safeAreaOffsetForView:view inView:su];
    frame.origin.y += safeAreaTopOffset;

    return frame;
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
