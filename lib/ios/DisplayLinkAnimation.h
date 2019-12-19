#import <Foundation/Foundation.h>

@interface DisplayLinkAnimation : NSObject

- (instancetype)initWithView:(UIView*)view targetFrame:(CGRect)frame targetAlpha:(CGFloat)targetAlpha;

- (void)layout:(CGFloat)p;

- (void)end;

@end
