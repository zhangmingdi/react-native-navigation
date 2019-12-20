#import "AnimatedViewFactory.h"
#import "AnimatedImageView.h"
#import "AnimatedTextView.h"
#import "UIVIew+Utils.h"

@implementation AnimatedViewFactory

+ (RNNAnimatedView *)createFromElement:(UIView *)element toElement:(UIView *)toElement alpha:(CGFloat)alpha endAlpha:(CGFloat)endAlpha isSharedElement:(BOOL)isSharedElement {
    switch (element.viewType) {
        case ViewTypeImage:
            return [[AnimatedImageView alloc] initElement:element toElement:toElement alpha:alpha endAlpha:endAlpha isSharedElement:isSharedElement];
        case ViewTypeText:
            return [[AnimatedTextView alloc] initElement:element toElement:toElement alpha:alpha endAlpha:endAlpha isSharedElement:isSharedElement];
        case ViewTypeOther:
        default:
            return [[RNNAnimatedView alloc] initElement:element toElement:toElement alpha:alpha endAlpha:endAlpha isSharedElement:isSharedElement];
    }
}

@end
