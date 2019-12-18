#import "AnimatedSnapshotView.h"

@implementation AnimatedSnapshotView {
    UIView* _snapshotView;
}

- (instancetype)initElement:(RNNElementView *)element toElement:(RNNElementView *)toElement alpha:(CGFloat)alpha endAlpha:(CGFloat)endAlpha isSharedElement:(BOOL)isSharedElement {
    self = [super initElement:element toElement:toElement alpha:alpha endAlpha:endAlpha isSharedElement:isSharedElement];
    _snapshotView = [element.sourceView snapshotViewAfterScreenUpdates:NO];
    _snapshotView.frame = self.bounds;
    [self addSubview:_snapshotView];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _snapshotView.frame = self.bounds;
}

@end
