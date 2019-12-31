#import "RNNOptions.h"
#import "TransitionOptions.h"

@interface ElementTransitionOptions : RNNOptions

@property (nonatomic, strong) TransitionOptions* alpha;
@property (nonatomic, strong) TransitionOptions* x;
@property (nonatomic, strong) TransitionOptions* y;
@property (nonatomic, strong) TransitionOptions* scaleX;
@property (nonatomic, strong) TransitionOptions* scaleY;
@property (nonatomic, strong) TransitionOptions* rotationX;
@property (nonatomic, strong) TransitionOptions* rotationY;
@property (nonatomic, strong) Bool* waitForRender;

- (NSTimeInterval)minDuration;
- (BOOL)hasAnimation;

@end
