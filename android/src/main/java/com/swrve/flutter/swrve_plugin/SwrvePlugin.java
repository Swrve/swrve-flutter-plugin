package com.swrve.flutter.swrve_plugin;

import androidx.annotation.NonNull;

import com.swrve.sdk.SwrveResourceManager;
import com.swrve.sdk.SwrveIdentityResponse;
import com.swrve.sdk.SwrveSDK;

import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** SwrvePlugin */
public class SwrvePlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "swrve_plugin");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch(call.method) {
      case "identify":
        SwrveSDK.identify((String) call.argument("external_user_id"), new SwrveIdentityResponse() {
          @Override
          public void onSuccess(String status, String swrveId) {
            // Success, continue with your logic
          }
          @Override
          public void onError(int responseCode, String errorMessage) {
            // Error should be handled.
          }
        });
        break;
//      case "start":
//        String custom_id = call.argument("custom_id");
//        SwrveSDK.start(custom_id);
//        break;
      case "event":
        String name = call.argument("name");
        Map<String, String> payload = call.argument("payload");
        SwrveSDK.event(name, payload);
        break;
      case "userUpdate":
        Map<String, String> attributes = call.arguments();
        SwrveSDK.userUpdate(attributes);
        break;
      case "purchase":
        String item = call.argument("item");
        String currency = call.argument("currency");
        int cost = call.argument("cost");
        int itemQuantity = call.argument("quantity");
        SwrveSDK.purchase(item, currency, cost, itemQuantity);
        break;
      case "currencyGiven":
        String givenCurrency = call.argument("currency");
        double givenAmount = call.argument("amount");
        SwrveSDK.currencyGiven(givenCurrency, givenAmount);
        break;
      case "iap":
        int quantity = call.argument("quantity");
        String productId = call.argument("productId");
        double productPrice = call.argument("productPrice");
        String localCurrency = call.argument("currency");
        SwrveSDK.iap(quantity, productId, productPrice, localCurrency);
        break;
      case "attributeAsString":
        result.success(SwrveSDK.getResourceManager().getAttributeAsString((String) call.argument("attributeId"), (String) call.argument("resourceId"), (String) call.argument("default")));
        break;
      case "attributeAsInt":
        result.success(SwrveSDK.getResourceManager().getAttributeAsInt((String) call.argument("attributeId"), (String) call.argument("resourceId"), (int) call.argument("default")));
        break;
      case "attributeAsFloat":
        result.success(SwrveSDK.getResourceManager().getAttributeAsFloat((String) call.argument("attributeId"), (String) call.argument("resourceId"), (float) call.argument("default")));
        break;
      case "attributeAsBool":
        result.success(SwrveSDK.getResourceManager().getAttributeAsBoolean((String) call.argument("attributeId"), (String) call.argument("resourceId"), (boolean) call.argument("default")));
        break;
      default:
        result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
