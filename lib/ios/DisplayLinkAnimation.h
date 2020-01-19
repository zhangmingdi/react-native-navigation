#import <Foundation/Foundation.h>

@protocol DisplayLinkAnimation <NSObject>

@required

- (CGAffineTransform)animateWithProgress:(CGFloat)p;

- (void)end;

- (NSTimeInterval)duration;

- (NSTimeInterval)startDelay;

@end
