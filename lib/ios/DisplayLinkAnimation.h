#import <Foundation/Foundation.h>

@protocol DisplayLinkAnimation <NSObject>

@required

- (void)animateWithProgress:(CGFloat)p;

- (void)end;

- (NSTimeInterval)duration;

- (NSTimeInterval)startDelay;

@end
