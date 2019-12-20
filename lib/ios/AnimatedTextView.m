#import "AnimatedTextView.h"
#import <React/RCTTextView.h>

@implementation AnimatedTextView {
    RCTTextView* _tv;
    NSTextContainer* _origTextContainer;
    CGSize _origSize;
    UIView* _origParent;
}

- (instancetype)initElement:(UIView *)element toElement:(UIView *)toElement alpha:(CGFloat)alpha endAlpha:(CGFloat)endAlpha isSharedElement:(BOOL)isSharedElement {
    self = [super initElement:element toElement:toElement alpha:alpha endAlpha:endAlpha isSharedElement:isSharedElement];
    
//    _origTextContainer = [self container:[element.view valueForKey:@"textStorage"]];
//    _origSize = _origTextContainer.size;
        
    return self;
}

- (NSTextContainer *)container:(NSTextStorage *)fromTextStorage {
    return fromTextStorage.layoutManagers.firstObject.textContainers.firstObject;
}

@end
