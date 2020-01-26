#import "BaseAnimator.h"

@implementation BaseAnimator

- (void)updateAnimations:(NSTimeInterval)elapsed {
    CGAffineTransform transform = CGAffineTransformIdentity;
    for (id<DisplayLinkAnimation> animation in _animations) {
        if (elapsed < animation.duration + animation.startDelay && elapsed > animation.startDelay) {
            CGFloat p = (elapsed-animation.startDelay)/(animation.duration-animation.startDelay);
            transform = CGAffineTransformConcat(transform, [animation animateWithProgress:p]);
        } else if (elapsed > animation.duration + animation.startDelay) {
            transform = CGAffineTransformConcat(transform, [animation animateWithProgress:1]);
            [_animations removeObject:animation];
        }
    }
    
    self.view.transform = transform;
}


- (NSTimeInterval)maxDuration {
    CGFloat maxDuration = 0;
    for (id<DisplayLinkAnimation> animation in _animations) {
        if (animation.duration + animation.startDelay > maxDuration) {
            maxDuration = animation.duration;
        }
    }
    
    return maxDuration;
}

- (void)end {
    for (id<DisplayLinkAnimatorDelegate> animation in _animations) {
        [animation end];
    }
}

@end
