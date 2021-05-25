
import 'dart:async';

import 'package:flutter/services.dart';

class SwrvePlugin {
  static const MethodChannel _channel = const MethodChannel('swrve_plugin');

  Future<void> identify(String externalUserId) async {
    final Map<String, String> params = <String, String>{
      "external_user_id": externalUserId
    };
    await _channel.invokeMethod('identify', params);
  }

  Future<void> start(String customId) async {
    final Map<String, String> params = <String, String>{
      "custom_id": customId
    };
    await _channel.invokeMethod('start', params);
  }

  Future<void> event(String name, {Map<String, String> payload}) async {
    final Map<String, dynamic> params = <String, dynamic>{
      "name": name,
      "payload": payload
    };
    await _channel.invokeMethod('event', params);
  }

  Future<void> purchase(String item, String currency, int cost, int quantity) async {
    final Map<String, dynamic> params = <String, dynamic>{
      "item": item,
      "currency": currency,
      "cost": cost,
      "quantity": quantity
    };
    await _channel.invokeMethod('purchase', params);
  }

  Future<void> currencyGiven(String currency, double amount) async {
    final Map<String, dynamic> params = <String, dynamic>{
      "currency": currency,
      "amount": amount
    };
    await _channel.invokeMethod('currencyGiven', params);
  }

  Future<void> userUpdate(Map<String, String> attributes) async {
    await _channel.invokeMethod('userUpdate', attributes);
  }

  Future<void> iap(int quantity, String productId, double productPrice, String currency) async {
    final Map<String, dynamic> params = <String, dynamic>{
      "quantity": quantity,
      "productId": productId,
      "productPrice": productPrice,
      "currency": currency
    };
    await _channel.invokeMethod('iap', params);
  }

  Future<String> attributeAsString(String attributeId, String resourceId, String defaultValue) async {
    final Map<String, String> params = <String, String>{
      "attributeId":attributeId,
      "resourceId":resourceId,
      "default":defaultValue
    };
    final String result = await _channel.invokeMethod('attributeAsString', params);
    return result;
  }

  Future<int> attributeAsInt(String attributeId, String resourceId, int defaultValue) async {
    final Map<String, dynamic> params = <String, dynamic>{
      "attributeId":attributeId,
      "resourceId":resourceId,
      "default":defaultValue
    };
    final int result = await _channel.invokeMethod('attributeAsInt', params);
    return result;
  }

  Future<double> attributeAsFloat(String attributeId, String resourceId, double defaultValue) async {
    final Map<String, dynamic> params = <String, dynamic>{
      "attributeId":attributeId,
      "resourceId":resourceId,
      "default":defaultValue
    };
    final double result = await _channel.invokeMethod('attributeAsFloat', params);
    return result;
  }

  Future<bool> attributeAsBool(String attributeId, String resourceId, bool defaultValue) async {
    final Map<String, dynamic> params = <String, dynamic>{
      "attributeId":attributeId,
      "resourceId":resourceId,
      "default":defaultValue
    };
    final bool result = await _channel.invokeMethod('attributeAsBool', params);
    return result;
  }
}
