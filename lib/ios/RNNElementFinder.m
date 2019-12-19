#import "RNNElementFinder.h"

@implementation RNNElementFinder

+ (UIView *)findInView:(UIView *)view byAccessibilityId:(NSString *)accessibilityId {
    NSArray* allSubviews = [self allSubViewsForView:view];
    for (UIView* subView in allSubviews) {
        if ([subView.accessibilityIdentifier isEqualToString:accessibilityId]) {
            return subView;
        }
    }
    
    return nil;
}

+ (NSArray *)allSubViewsForView:(UIView *)view {
   NSMutableArray *arr = [[NSMutableArray alloc] init];
    [arr addObject:view];
   for (UIView *subview in view.subviews) {
     [arr addObjectsFromArray:(NSArray*)[self allSubViewsForView:subview]];
   }
   return arr;
}

+ (RNNElementView *)findElementForId:(NSString *)elementId inView:(UIView *)view {
    UIView* v = [self findInView:view byAccessibilityId:elementId];
    if (!v) {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"elementId %@ does not exist", elementId] userInfo:nil] raise];
    }
    RNNElementView* element = [[RNNElementView alloc] initWithView:v];
    
    return element;
}

@end
