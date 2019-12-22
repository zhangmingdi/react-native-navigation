#import "RNNViewLocation.h"
#import "DisplayLinkAnimation.h"
#import "RNNInterpolator.h"

@interface AnimatedReactView : UIView <DisplayLinkAnimation>

@property (nonatomic, strong) RNNViewLocation* location;
@property (nonatomic, strong) UIView* reactView;

- (instancetype)initElement:(UIView*)element toElement:(UIView *)toElement alpha:(CGFloat)alpha endAlpha:(CGFloat)endAlpha isSharedElement:(BOOL)isSharedElement;

@end
