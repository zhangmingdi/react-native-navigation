#import <Foundation/Foundation.h>
#import "DisplayLinkAnimatorDelegate.h"

@interface BaseAnimator : NSObject<DisplayLinkAnimatorDelegate>

@property (nonatomic, strong) UIView* view;

@property (nonatomic, strong) NSMutableArray<id<DisplayLinkAnimation>> * animations;

@end
