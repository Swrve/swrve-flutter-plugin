#import "SwrvePlugin.h"
#import "SwrveSDK.h"

@implementation SwrvePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"swrve_plugin"
            binaryMessenger:[registrar messenger]];
  SwrvePlugin* instance = [[SwrvePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  // if ([@"getPlatformVersion" isEqualToString:call.method]) {
  //   result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  // } else {
  //   result(FlutterMethodNotImplemented);
  // }
  NSString* method = call.method;
  if ([@"event" isEqualToString:method]) {
    [self event:call];
  } else if ([@"userUpdate" isEqualToString:method]) {
    [self userUpdate:call];
  } else if ([@"purchase" isEqualToString:method]) {
    [self purchase:call];
  } else if ([@"currencyGiven" isEqualToString:method]) {
    [self currencyGiven:call];
  } else if ([@"identify" isEqualToString:method]) {
    [self identify:call];
  } else if ([@"start" isEqualToString:method]) {
    [self start:call];
  } else if ([@"attributeAsString" isEqualToString:method]) {
    result([self attributeAsString:call]);
  } else if ([@"attributeAsInt" isEqualToString:method]) {
    result([NSNumber numberWithInt:[self attributeAsInt:call]]);
//  } else if ([@"attributeAsFloat" isEqualToString:method]) {
//    result([NSNumber numberWithDouble:[self attributeAsFloat:call]]);
  } else if ([@"attributeAsBool" isEqualToString:method]) {
      result([NSNumber numberWithBool:[self attributeAsBool:call]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

-(void) event:(FlutterMethodCall *)call {
  NSString *event_name = call.arguments[@"name"];
  NSDictionary *payload = call.arguments[@"payload"];
  [SwrveSDK event:event_name payload:payload];
}

-(void) userUpdate:(FlutterMethodCall *)call {
  NSDictionary *attributes = call.arguments;
  [SwrveSDK userUpdate:attributes];
}

-(void) identify:(FlutterMethodCall *) call {
  NSString *external_id = call.arguments[@"external_user_id"];
  [SwrveSDK identify:external_id onSuccess:^(NSString *status, NSString *swrveUserId) {
      // Success, continue with your logic
  } onError:^(NSInteger httpCode, NSString *errorMessage){
      // Error should be handled
  }];
}

-(void) start:(FlutterMethodCall *) call {
  NSString *custom_id = call.arguments[@"custom_id"];
  [SwrveSDK startWithUserId:custom_id];
}

-(void) purchase:(FlutterMethodCall *) call {
  NSString *item = call.arguments[@"item"];
  NSString *currency = call.arguments[@"currency"];
  int cost = [call.arguments[@"cost"] intValue];
  int quantity = [call.arguments[@"quantity"] intValue];
  [SwrveSDK purchaseItem:item currency:currency cost:cost quantity:quantity];
}

-(void) currencyGiven:(FlutterMethodCall *)call {
  NSString *currency = call.arguments[@"currency"];
  double amount = [call.arguments[@"amount"] doubleValue];
  [SwrveSDK currencyGiven:currency givenAmount:amount];
}

-(void) iap:(FlutterMethodCall *)call {
  double localCost = [call.arguments[@"localCost"] doubleValue];
  NSString *localCurrency = call.arguments[@"localCurrency"];
  NSString *productId = call.arguments[@"productId"];
  int productIdQuantity = [call.arguments[@"productIdQuantity"] intValue];

  SwrveIAPRewards* rewards = [[SwrveIAPRewards alloc] init];
  [rewards addItem:productId withQuantity:1];

  [SwrveSDK unvalidatedIap:rewards
            localCost:localCost
            localCurrency:localCurrency
            productId:productId
            productIdQuantity:productIdQuantity];
}

-(NSString*) attributeAsString:(FlutterMethodCall *) call {
  SwrveResourceManager* resourceManager = [SwrveSDK resourceManager];
  NSString* attributeValue = [resourceManager attributeAsString:call.arguments[@"attributeId"] fromResourceWithId:call.arguments[@"resourceId"] withDefault:call.arguments[@"default"]];
  return attributeValue;
}

-(int) attributeAsInt:(FlutterMethodCall *) call {
  SwrveResourceManager* resourceManager = [SwrveSDK resourceManager];
  int attributeValue = [resourceManager attributeAsInt:call.arguments[@"attributeId"] fromResourceWithId:call.arguments[@"resourceId"] withDefault:[call.arguments[@"default"] intValue]];
  return attributeValue;
}

-(float) attributeAsFloat:(FlutterMethodCall *) call {
   SwrveResourceManager* resourceManager = [SwrveSDK resourceManager];
   float attributeValue = [resourceManager attributeAsFloat:call.arguments[@"attributeId"] fromResourceWithId:call.arguments[@"resourceId"] withDefault:[call.arguments[@"default"] floatValue]];
   return attributeValue;
}

-(BOOL) attributeAsBool:(FlutterMethodCall *) call {
  SwrveResourceManager* resourceManager = [SwrveSDK resourceManager];
    BOOL attributeValue = [resourceManager attributeAsBool:call.arguments[@"attributeId"] fromResourceWithId:call.arguments[@"resourceId"] withDefault:[call.arguments[@"default"] boolValue]];
    return attributeValue;
}


@end
