import 'package:examapp/controllers/home_controller.dart';
import 'package:examapp/service/auth_service.dart';
import 'package:examapp/widget/fade_route.dart';
import 'package:examapp/widget/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text(
              "Student Home View",
            ),
            FlatButton(
              onPressed: () async {
                Navigator.of(context).push(
                    TransparentRoute(builder: (context) => LoadingView()));
                bool isSignOut = await AuthService().singOut();
                Navigator.pop(context);
                if (isSignOut) {
                  context.read<HomeController>().homeSelectedView =
                      HomeSelectedView.Welcome;
                }
              },
              child: Text(
                "EXIT",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
