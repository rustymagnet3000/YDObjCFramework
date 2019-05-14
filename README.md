#  ObjC Framework for Debugger Challenge
This simple repo was written to support the iOS Debugger Challenge [repo][f8af4e74].  

  [f8af4e74]: https://github.com/rustymagnet3000/debugger_challenge "debugger_challenge_repo"

It included two Targets.  These were pieces of code to mimic a Alice's `SDK` and an Bob's `Swizzle`.

##### Alice's SDK
Alice's SDK was super simple.  It was built for iOS device, simulator and macOS.   
```
@interface YDHelloClass : NSObject
+(void)sayStaticHello;
-(NSInteger) getRandomNumber;
```
Alice's APIs were made available to an iOS / macOS app, by making her SDK header file `public`. If Alice didn't do this, anybody embedding the SDK inside a Swift project would get compiler errors.

##### Bob's Swizzle
```

```



##### TO DO
Change to a universal framework (`arm64` and `x86/64`)
