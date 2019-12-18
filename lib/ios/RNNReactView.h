#import <React/RCTRootView.h>
#import <React/RCTRootViewDelegate.h>
#import "UIView+Utils.h"

typedef void (^RNNReactViewReadyCompletionBlock)(void);

@interface RNNReactView : RCTRootView

- (instancetype)initWithBridge:(RCTBridge *)bridge moduleName:(NSString *)moduleName initialProperties:(NSDictionary *)initialProperties  availableSize:(CGSize)availableSize reactViewReadyBlock:(RNNReactViewReadyCompletionBlock)reactViewReadyBlock;

@property (nonatomic, copy) RNNReactViewReadyCompletionBlock reactViewReadyBlock;
@property (nonatomic, strong) RNNEventEmitter* eventEmitter;

- (NSString *)componentId;

- (NSString *)componentType;

- (void)componentDidAppear;

- (void)componentDidDisappear;

@end
