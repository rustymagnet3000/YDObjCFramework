# ObjC Framework

## for iOS_debugger_challenge

This repo was written to support the iOS Debugger Challenge [repo][f8af4e74].  

  [f8af4e74]: https://github.com/rustymagnet3000/ios_debugger_challenge "ios_debugger_challenge_repo"

### Target 1 : Alice's SDK

Alice's super simple SDK.  You could drag this Framework into a real OR simulator `iOS XCode project`.

```objective-c
@interface YDHelloClass : NSObject

+(void)sayStaticHello;
-(NSInteger) getRandomNumber;
```

Alice's `public` APIs were inside a header file.  If Alice didn't make this header file `public` anybody embedding the SDK inside a Swift project would get compiler errors.  Since xCode 12.x, it was required to rebuild the framework as 

```bash
xcodebuild archive \
 -scheme YDAliceSDK-iOS \
 -archivePath ~/Desktop/iOS.xcarchive \
 -destination "generic/platform=iOS"

xcodebuild archive \
 -scheme YDAliceSDK-iOS \
 -archivePath ~/Desktop/sim.xcarchive \
 -destination "generic/platform=iOS Simulator"
```

### Target 2 : Malloc Gobbler

I wanted to request gigabytes of memory, until the O/S said "no".  I injected this code into the start-up on an iOS app.  The idea was to provoke exhausted devices to fault when loading SDKs.  But an iPhone 7 would crash the app after 1.4GB.

Next step: slowdown `Gobbler` and put the code onto a Background thread. At the moment the code was blocking the rest of the app from loading.
