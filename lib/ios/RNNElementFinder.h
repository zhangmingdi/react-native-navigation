#import <Foundation/Foundation.h>
#import "RNNElementView.h"

@interface RNNElementFinder : NSObject

+ (RNNElementView *)findElementForId:(NSString *)elementId inView:(UIView *)view;

@end
