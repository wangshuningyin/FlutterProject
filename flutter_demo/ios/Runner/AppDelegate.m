#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "PigeonService.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    FlutterViewController *controller = (FlutterViewController *)self.window.rootViewController;
    
    FLTApiSetup(controller.binaryMessenger, [PigeonService new]);
    FLTCallBluetoothSDKSetup(controller.binaryMessenger, [PigeonService new]);
    
    [GeneratedPluginRegistrant registerWithRegistry:self];
    // Override point for customization after application launch.
    self._flutterApi = [[FLTMyApi alloc] initWithBinaryMessenger:controller.binaryMessenger];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self._flutterApi sessionInValidWithCompletion:^(NSError * err) {
            NSLog(@"===Native Call flutter func!===");
        }];
    });
    
    
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
