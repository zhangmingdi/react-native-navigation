#import "AnimatedImageView.h"

@implementation AnimatedImageView

- (instancetype)initElement:(UIView *)element toElement:(UIView *)toElement alpha:(CGFloat)alpha endAlpha:(CGFloat)endAlpha isSharedElement:(BOOL)isSharedElement {
    self = [super initElement:element toElement:toElement alpha:alpha endAlpha:endAlpha isSharedElement:isSharedElement];
    self.contentMode = element.contentMode;

    return self;
}

@end
