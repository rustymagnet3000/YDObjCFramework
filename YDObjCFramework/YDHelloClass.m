#include "YDHelloClass.h"

@implementation YDHelloClass

-(NSInteger) getRandomNumber
{
    return arc4random_uniform(10000);
}

+(void) sayStaticHello
{
    puts("[+]A static hello. Foo.");
}
@end
