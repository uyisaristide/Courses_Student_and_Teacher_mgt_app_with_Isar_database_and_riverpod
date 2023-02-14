import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class JsonAssetLoader extends AssetLoader {
  final Map<String, dynamic> data;
  const JsonAssetLoader({this.data = const {}});

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) async {
    return Future.value(data);
  }
}