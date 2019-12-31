#import "SharedElementTransitionOptions.h"
#import "RNNUtils.h"

@implementation SharedElementTransitionOptions

- (instancetype)initWithDict:(NSDictionary *)transition {
	self = [super init];
	
	self.duration = [TimeIntervalParser parse:transition key:@"duration"];
	self.startAlpha = [RNNUtils getDoubleOrKey:transition withKey:@"startAlpha" withDefault:1];
	self.endAlpha = [RNNUtils getDoubleOrKey:transition withKey:@"endAlpha" withDefault:1];
	self.fromId = [transition objectForKey:@"fromId"];
	self.toId = [transition objectForKey:@"toId"];
//	self.interpolation = [self animationOptionsFromString:transition[@"interpolation"]];
	
	
	return self;
}

@end
