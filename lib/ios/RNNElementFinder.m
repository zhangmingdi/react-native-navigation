#import "RNNElementFinder.h"
#import <React/RCTRootView.h>
#import <React/RCTUIManager.h>

@implementation RNNElementFinder

+ (UIView *)findElementForId:(NSString *)elementId inView:(RCTRootView *)view {
    UIView* subView = [view.bridge.uiManager viewForNativeID:elementId withRootTag:view.reactTag];
    if (!subView) {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"elementId %@ does not exist", elementId] userInfo:nil] raise];
    }
    
    return subView;
}

@end
