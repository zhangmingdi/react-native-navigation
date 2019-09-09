#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RNNButtonOptions.h"
#import "RNNComponentViewCreator.h"
#import "RNNReactComponentRegistry.h"

@interface RNNTopBarButtonPresenter : NSObject

- (instancetype)initWithViewController:(UIViewController *)viewController componentRegistry:(RNNReactComponentRegistry *)componentRegistry;

- (void)applyLeftButtons:(NSArray *)buttons defaultLeftButtonStyle:(RNNButtonOptions *)defaultButtonStyle;

- (void)applyRightButtons:(NSArray *)buttons defaultRightButtonStyle:(RNNButtonOptions *)defaultButtonStyle;

@end


