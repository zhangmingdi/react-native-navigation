#import "RNNOptions.h"

@interface TransitionOptions : RNNOptions

@property (nonatomic, strong) Double* from;
@property (nonatomic, strong) Double* to;
@property (nonatomic, strong) TimeInterval* duration;
@property (nonatomic, strong) TimeInterval* startDelay;

- (BOOL)hasAnimation;

@end
