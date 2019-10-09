import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

///网络请求的入口
class RequestAPI {

  Future<dynamic> get(String action, {Map params}) async {
    var responseStr = await rootBundle.loadString('assets/mock/$action.json');
    var responseJson = json.decode(responseStr);
    return responseJson;
  }
}