#import "NSArray+RNNUtils.h"

@implementation NSArray (RNNUtils)
- (NSArray *)subtract:(NSArray *)other {
    NSMutableArray *array = [NSMutableArray arrayWithArray:self];
    [array removeObjectsInArray:other];
    return array;
}

@end