#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ViewType) {
    ViewTypeImage,
    ViewTypeText,
    ViewTypeOther
};

@interface RNNElementView : UIView

@property (nonatomic, strong) NSString* elementId;
@property (nonatomic, strong) NSString* type;
@property (nonatomic, strong) NSString* resizeMode;
@property (nonatomic, strong) NSNumber* interactive;
@property (nonatomic, strong) UIViewController* vc;
@property (nonatomic) CGPoint originalCenter;

- (ViewType)viewType;

- (UIView *)sourceView;

- (UIView *)animateView;

@end
