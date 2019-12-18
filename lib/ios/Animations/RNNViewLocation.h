#import <Foundation/Foundation.h>
#import "RNNElementView.h"

@interface RNNViewLocation : NSObject

@property (nonatomic) CGRect fromFrame;
@property (nonatomic) CGRect toFrame;

- (instancetype)initWithFromElement:(RNNElementView*)fromElement toElement:(RNNElementView*)toElement;

@end
