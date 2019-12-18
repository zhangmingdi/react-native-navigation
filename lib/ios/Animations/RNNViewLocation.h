#import <Foundation/Foundation.h>
#import "RNNElementView.h"

@interface RNNViewLocation : NSObject

@property (nonatomic) CGRect fromFrame;
@property (nonatomic) CGRect toFrame;

-(instancetype)initWithFromElement:(RNNElementView*)fromElement toElement:(RNNElementView*)toElement startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint andVC:(UIViewController*)vc toVC:(UIViewController*)toVC ;

@end
