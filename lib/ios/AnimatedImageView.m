#import "AnimatedImageView.h"

@implementation AnimatedImageView

- (instancetype)initElement:(RNNElementView *)element toElement:(RNNElementView *)toElement alpha:(CGFloat)alpha endAlpha:(CGFloat)endAlpha isSharedElement:(BOOL)isSharedElement {
    self = [super initElement:element toElement:toElement alpha:alpha endAlpha:endAlpha isSharedElement:isSharedElement];
    self.contentMode = element.view.contentMode;

    return self;
}

@end
