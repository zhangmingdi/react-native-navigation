#import "RNNElementView.h"
#import <React/RCTImageView.h>
#import <React/RCTTextView.h>

@implementation RNNElementView

- (instancetype)initWithView:(UIView *)view {
    self = [super init];
    _view = view;
    return self;
}

- (ViewType)viewType {
    if ([_view isKindOfClass:[RCTImageView class]]) {
        return ViewTypeImage;
    } else if ([_view isKindOfClass:[RCTTextView class]]) {
        return ViewTypeText;
    }
    
    return ViewTypeOther;
}

@end
