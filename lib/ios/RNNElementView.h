#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ViewType) {
    ViewTypeImage,
    ViewTypeText,
    ViewTypeOther
};

@interface RNNElementView : NSObject

- (instancetype)initWithView:(UIView *)view;

@property (nonatomic, strong) UIView* view;
@property (nonatomic, strong) NSString* elementId;

- (ViewType)viewType;

@end
