import 'package:examapp/views/base_view.dart';
import 'package:examapp/views/exam_view.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Routes {
  static String root = "/";
  static String exam = "/exam/:id";
  static Handler rootHandler =
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return BaseView();
  });
  static Handler examHandler =
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return ExamView(
      params["id"][0],
      isPreview: false,
    );
  });

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(exam, handler: examHandler);
    router.define(root, handler: rootHandler);
  }
}
