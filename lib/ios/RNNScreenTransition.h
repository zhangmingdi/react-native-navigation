#import "RNNOptions.h"
#import "RNNElementTransitionOptions.h"

@interface RNNScreenTransition : RNNOptions

@property (nonatomic, strong) RNNElementTransitionOptions* topBar;
@property (nonatomic, strong) RNNElementTransitionOptions* content;
@property (nonatomic, strong) RNNElementTransitionOptions* bottomTabs;
@property (nonatomic, strong) NSArray* elements;

@property (nonatomic, strong) Bool* enable;
@property (nonatomic, strong) Bool* waitForRender;
@property (nonatomic, strong) Number* duration;

- (BOOL)hasCustomAnimation;
- (BOOL)shouldWaitForRender;
- (double)maxDuration;


@end
