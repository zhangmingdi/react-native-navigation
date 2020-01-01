#import "TransitionOptions.h"

@implementation TransitionOptions

- (instancetype)initWithDict:(NSDictionary *)dict {
	self = [super init];
	
	self.from = [DoubleParser parse:dict key:@"from"];
	self.to = [DoubleParser parse:dict key:@"to"];
	self.startDelay = [TimeIntervalParser parse:dict key:@"startDelay"];
	self.duration = [TimeIntervalParser parse:dict key:@"duration"];
	
	return self;
}

- (BOOL)hasAnimation {
	return self.from.hasValue && self.to.hasValue;
}

@end
