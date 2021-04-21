#import "MyHelloPlugin.h"
#if __has_include(<my_hello/my_hello-Swift.h>)
#import <my_hello/my_hello-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "my_hello-Swift.h"
#endif

@implementation MyHelloPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMyHelloPlugin registerWithRegistrar:registrar];
}
@end
