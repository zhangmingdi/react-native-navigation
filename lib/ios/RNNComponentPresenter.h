#import "RNNBasePresenter.h"
#import "RNNTopBarButtons.h"
#import "RNNReactComponentRegistry.h"

@interface RNNComponentPresenter : RNNBasePresenter

- (instancetype)initWithComponentRegistry:(RNNReactComponentRegistry *)componentRegistry:(RNNNavigationOptions *)defaultOptions;

- (void)renderComponents:(RNNNavigationOptions *)options perform:(RNNReactViewReadyCompletionBlock)readyBlock;

@property (nonatomic, strong) RNNTopBarButtons* navigationButtons;

@end
