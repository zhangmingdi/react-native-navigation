#import "RNNElementView.h"
#import <React/RCTImageView.h>
#import <React/RCTTextView.h>

@implementation RNNElementView

- (ViewType)viewType {
    if ([self.subviews[0] isKindOfClass:[RCTImageView class]]) {
        return ViewTypeImage;
    } else if ([self.subviews[0] isKindOfClass:[RCTTextView class]]) {
        return ViewTypeText;
    }
    
    return ViewTypeOther;
}

- (UIView *)sourceView {
    switch (self.viewType) {
        case ViewTypeImage:
            return self.subviews[0].subviews[0];
        case ViewTypeText:
            return self.subviews[0];
        case ViewTypeOther:
            return self;
    }
}

- (UIView *)animateView {
    switch (self.viewType) {
        case ViewTypeImage:
            return self.sourceView;
        case ViewTypeText:
            return self;
        case ViewTypeOther:
            return self;
    }
}

@end
