#import "ElementVerticalTransition.h"

@implementation ElementVerticalTransition {
    CGFloat _fromX;
    CGFloat _toX;
}

- (instancetype)initWithView:(UIView *)view transitionOptions:(TransitionOptions *)transitionOptions {
    self = [super initWithView:view transitionOptions:transitionOptions];
    
    _fromX = [transitionOptions.from getWithDefaultValue:0];
    _toX = [transitionOptions.to getWithDefaultValue:0];
    
    return self;
}

- (void)animateWithProgress:(CGFloat)p {
    CGFloat x = [RNNInterpolator fromFloat:_fromX toFloat:_toX precent:p];
    self.view.frame = CGRectMake(x, self.view.frame.origin.y, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
}

@end
