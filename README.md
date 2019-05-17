#  ObjC Framework for Debugger Challenge
This repo was written to support the iOS Debugger Challenge [repo][f8af4e74].  

  [f8af4e74]: https://github.com/rustymagnet3000/debugger_challenge "debugger_challenge_repo"

It included two pieces of code. In `XCode` lingo, you could see two `Targets` inside the `XCode` project.  One `Target` was Alice's `Objective-C SDK`.  The other target was a `Swizzle` written by Bob in `Objective-C` code.

### Target 1 : Alice's SDK
Alice's super simple SDK.  You could drag this Framework into a real OR simulator `iOS XCode project`.   
```
@interface YDHelloClass : NSObject

+(void)sayStaticHello;
-(NSInteger) getRandomNumber;
```
Alice's `public` APIs were inside a header file.  If Alice didn't make this header file `public` anybody embedding the SDK inside a Swift project would get compiler errors.

### Target 2 : Bob's Swizzle
Bob's code looked to exploit the dynamic nature of Objective-C.  It used a `constructor` to exchange a method Bob's code with Alice's code.
```     
    Method original, swizzled;
    original = class_getInstanceMethod(orignalClass, @selector(getRandomNumber));
    swizzled = class_getInstanceMethod(self, @selector(fakeRandomNumber));
    method_exchangeImplementations(original, swizzled);
```

### Target 3 : Malloc Gobbler
I wanted to request gigabytes of memory, until the O/S said "no".  I injected this code into the start-up on an iOS app.  The idea was to provoke exhausted devices to fault when loading SDKs.  But an iPhone 7 would crash the app after 1.4GB.

Next step: slowdown `Gobbler` and put the code onto a Background thread. At the moment the code was blocking the rest of the app from loading.
