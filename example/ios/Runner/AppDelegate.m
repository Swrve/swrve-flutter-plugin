#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "SwrveSDK.h"
#import <swrve_plugin/SwrvePlugin.h>

@interface AppDelegate() <SwrvePushResponseDelegate>
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  SwrveConfig* config = [[SwrveConfig alloc] init];
  // To use the EU stack, include this in your config.
  // config.stack = SWRVE_STACK_EU;
  config.pushEnabled = YES;
  config.pushResponseDelegate = self;

  [SwrveSDK sharedInstanceWithAppID: <app id>
      apiKey:@"<api key>"
      config:config];

  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
