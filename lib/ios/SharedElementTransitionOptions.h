#import <Foundation/Foundation.h>
#import "RNNOptions.h"

@interface SharedElementTransitionOptions : RNNOptions

@property (nonatomic) double startAlpha;
@property (nonatomic) double endAlpha;
@property (nonatomic) TimeInterval* duration;
@property (nonatomic) TimeInterval* startDelay;
@property (nonatomic, strong) NSString* fromId;
@property (nonatomic, strong) NSString* toId;

@end
