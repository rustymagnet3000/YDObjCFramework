#import <Foundation/Foundation.h>
#import <objc/message.h>

@interface YDGoodbyeClass: NSObject
- (NSInteger)fakeRandomNumber;
@end

@implementation YDGoodbyeClass

- (NSInteger)fakeRandomNumber
{
    if ([self respondsToSelector:@selector(fakeRandomNumber)]) {
        NSInteger result = [self fakeRandomNumber];
        NSLog(@"[+] 🍭 swizzled.Original return value: %ld", result);
    }
    else {
        NSLog(@"[+] 🍭 swizzled.");
    }
    
    return 42;
}

+ (void)load
{
    Class targetClass = objc_getClass("YDHelloClass");
    
    if (targetClass != nil) {
        NSLog(@"[+] 🎣 Found YDHelloClass\n");
        NSLog(@"[+] 🎣 Placing hook on getRandomNumber\n");
        Class orignalClass = objc_getClass("YDHelloClass");
        Method original, swizzled;
        original = class_getInstanceMethod(orignalClass, @selector(getRandomNumber));
        swizzled = class_getInstanceMethod(self, @selector(fakeRandomNumber));
        method_exchangeImplementations(original, swizzled);
    }
}

@end
