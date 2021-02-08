import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examapp/controllers/base_controller.dart';
import 'package:examapp/controllers/classroom_controller.dart';
import 'package:examapp/controllers/home_controller.dart';
import 'package:examapp/controllers/login_controller.dart';
import 'package:examapp/controllers/register_controller.dart';
import 'package:examapp/routes/application.dart';
import 'package:examapp/routes/routes.dart';
import 'package:examapp/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final route = FluroRouter();
  Application.router = route;
  Routes.configureRoutes(route);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => BaseController()),
    ChangeNotifierProvider(create: (_) => HomeController()),
    ChangeNotifierProvider(create: (_) => RegisterController()),
    ChangeNotifierProvider(create: (_) => LoginController()),
    ChangeNotifierProvider(create: (_) => ClassroomController()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: themeLight,
      onGenerateRoute: Application.router.generator,
    );
  }
}
