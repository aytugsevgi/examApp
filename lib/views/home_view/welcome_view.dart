import 'package:examapp/controllers/base_controller.dart';
import 'package:examapp/controllers/home_controller.dart';
import 'package:examapp/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      height: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 25,
            child: FittedBox(
              child: Text(
                "Welcome!\nEge Examination System",
                maxLines: 2,
                style: context.themeData.textTheme.display3
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 45),
              ),
            ),
          ),
          Spacer(flex: 2),
          Expanded(
            flex: 10,
            child: FittedBox(
              child: RichText(
                  maxLines: 2,
                  text: TextSpan(
                      style: context.themeData.textTheme.display1.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                            text: "Build or start your online exam today.\n"),
                        TextSpan(text: "Also first month is "),
                        TextSpan(
                          text: "free!",
                          style: context.themeData.textTheme.display1.copyWith(
                              fontWeight: FontWeight.w600,
                              color: context.themeData.primaryColor),
                        ),
                      ])),
            ),
          ),
          Spacer(flex: 18),
          Expanded(
            flex: 15,
            child: Container(
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 20,
                    child: RaisedButton(
                      color: context.themeData.primaryColor,
                      onPressed: () {
                        Provider.of<HomeController>(context, listen: false)
                            .homeSelectedView = HomeSelectedView.Login;
                      },
                      child: FittedBox(
                        child: Text(
                          "GET STARTED",
                          style: context.themeData.textTheme.display1.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 2),
                  Expanded(
                    flex: 20,
                    child: OutlinedButton(
                      style: ButtonStyle(
                          side: MaterialStateProperty.all(BorderSide(
                        color: context.themeData.accentColor,
                        width: 4,
                      ))),
                      onPressed: () {
                        Provider.of<BaseController>(context, listen: false)
                            .selectedTab = TabType.About;
                      },
                      child: FittedBox(
                        child: Text(
                          "Learn More",
                          style: context.themeData.textTheme.display1.copyWith(
                            color: context.themeData.accentColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 30),
                ],
              ),
            ),
          ),
          Spacer(
            flex: 15,
          ),
        ],
      ),
    );
  }
}
