import 'package:examapp/views/base_view.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Routes {
  static String root = "/";

  static Handler rootHandler =
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return BaseView();
  });

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: rootHandler);
  }
}
