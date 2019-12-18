#import <Foundation/Foundation.h>

@interface FrameAnimator : NSObject

+ (void)animateView:(UIView*)view toFrame:(CGRect)frame duration:(NSTimeInterval)duration;

@end
