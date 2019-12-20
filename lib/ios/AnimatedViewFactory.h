#import <Foundation/Foundation.h>
#import "RNNAnimatedView.h"

@interface AnimatedViewFactory : NSObject

+ (RNNAnimatedView *)createFromElement:(UIView *)element toElement:(UIView *)toElement alpha:(CGFloat)alpha endAlpha:(CGFloat)endAlpha isSharedElement:(BOOL)isSharedElement;

@end
