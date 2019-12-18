#import "AnimatedSnapshotView.h"

@implementation AnimatedSnapshotView {
    UIView* _snapshotView;
}

- (instancetype)initElement:(RNNElementView *)element toElement:(RNNElementView *)toElement frame:(CGRect)frame endFrame:(CGRect)endFrame alpha:(CGFloat)alpha endAlpha:(CGFloat)endAlpha isSharedElement:(BOOL)isSharedElement {
    self = [super initElement:element toElement:toElement frame:frame endFrame:endFrame alpha:alpha endAlpha:endAlpha isSharedElement:isSharedElement];
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
