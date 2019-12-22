#import <Foundation/Foundation.h>
#import "DisplayLinkAnimation.h"

typedef void (^CompletionBlock)(void);

@interface DisplayLinkAnimator : NSObject

@property (nonatomic, copy) CompletionBlock completion;

- (instancetype)initWithDisplayLinkAnimations:(NSArray<id<DisplayLinkAnimation>> *)displayLinkAnimations duration:(CGFloat)duration;

- (instancetype)initWithDisplayLinkAnimation:(id<DisplayLinkAnimation>)displayLinkAnimation duration:(CGFloat)duration;

- (void)start;

@end
