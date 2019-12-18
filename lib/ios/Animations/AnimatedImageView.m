#import "AnimatedImageView.h"

@implementation AnimatedImageView {
    UIImageView* _imageView;
}

- (instancetype)initElement:(RNNElementView *)element toElement:(RNNElementView *)toElement alpha:(CGFloat)alpha endAlpha:(CGFloat)endAlpha isSharedElement:(BOOL)isSharedElement {
    self = [super initElement:element toElement:toElement alpha:alpha endAlpha:endAlpha isSharedElement:isSharedElement];
    _imageView = [self createImageViewFromElement:element];
    [self addSubview:_imageView];
    return self;
}

- (UIImageView*)createImageViewFromElement:(RNNElementView*)element {
    UIImageView* originalImageView = [self findElementImageView:element];
    UIImageView* animatedView = [[UIImageView alloc] initWithImage:originalImageView.image];
    animatedView.frame = self.bounds;
    animatedView.contentMode = originalImageView.contentMode;
    animatedView.clipsToBounds = YES;
    return animatedView;
}

- (UIImageView *)findElementImageView:(UIView *)element {
    UIImageView* imageView;
    for (UIView* view in element.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            return (UIImageView *)view;
        }
        
        imageView = [self findElementImageView:view];
    }
    
    return imageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
}

@end
