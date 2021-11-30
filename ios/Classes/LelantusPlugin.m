#import "LelantusPlugin.h"
#if __has_include(<lelantus/lelantus-Swift.h>)
#import <lelantus/lelantus-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "lelantus-Swift.h"
#endif

@implementation LelantusPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLelantusPlugin registerWithRegistrar:registrar];
}
@end
