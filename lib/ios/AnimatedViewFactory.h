#import <Foundation/Foundation.h>
#import "RNNAnimatedView.h"

@interface AnimatedViewFactory : NSObject

+ (RNNAnimatedView *)createFromElement:(RNNElementView *)element toElement:(RNNElementView *)toElement alpha:(CGFloat)alpha endAlpha:(CGFloat)endAlpha isSharedElement:(BOOL)isSharedElement;

@end
