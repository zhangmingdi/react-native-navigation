#import <Foundation/Foundation.h>
#import "AnimatedReactView.h"

@interface AnimatedViewFactory : NSObject

+ (AnimatedReactView *)createFromElement:(UIView *)element toElement:(UIView *)toElement alpha:(CGFloat)alpha endAlpha:(CGFloat)endAlpha isSharedElement:(BOOL)isSharedElement;

@end
