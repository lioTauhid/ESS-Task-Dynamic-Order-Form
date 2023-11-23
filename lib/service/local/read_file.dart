import 'dart:convert';

import 'package:flutter/material.dart';

class ReadFile {
  Future<dynamic> readAssetsJson(context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/Fruit Prices.json");
    final jsonResult = jsonDecode(data); //latest Dart
    return jsonResult;
  }
}
