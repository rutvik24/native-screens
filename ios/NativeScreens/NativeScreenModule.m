#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(NativeScreenModule, NSObject)

RCT_EXTERN_METHOD(openNativeScreen:(NSString *)title callback:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(openNativeSwiftUIScreen:(NSString *)title callback:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(openNativeModalScreen:(NSString *)title callback:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(openNativeSwiftUIModalScreen:(NSString *)title callback:(RCTResponseSenderBlock)callback)

@end
