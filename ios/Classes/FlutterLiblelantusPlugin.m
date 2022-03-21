#import "FlutterLiblelantusPlugin.h"
#if __has_include(<flutter_liblelantus/flutter_liblelantus-Swift.h>)
#import <flutter_liblelantus/flutter_liblelantus-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_liblelantus-Swift.h"
#endif

@implementation FlutterLiblelantusPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterLiblelantusPlugin registerWithRegistrar:registrar];
}
@end
