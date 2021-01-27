import 'package:examapp/controllers/base_controller.dart';
import 'package:examapp/routes/application.dart';
import 'package:examapp/utils/extension.dart';
import 'package:examapp/views/about_view.dart';
import 'package:examapp/views/classroom_view.dart';
import 'package:examapp/views/contact_view.dart';
import 'package:examapp/views/home_view.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView extends StatelessWidget {
  const BaseView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 100,
            right: -context.dynamicWidth(0.08),
            child: Image.asset(
              "assets/background.jpg",
              fit: BoxFit.contain,
              width: context.dynamicWidth(0.72),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                appBar(context),
                Expanded(child: body(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox appBar(BuildContext context) {
    return SizedBox(
      height: 150,
      width: context.dynamicWidth(1),
      child: Center(
        child: Row(
          children: [
            Spacer(flex: 2),
            SizedBox(
                width: 130,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/");
                  },
                  child: RichText(
                    maxLines: 1,
                    text: TextSpan(
                        style: context.themeData.textTheme.display1,
                        children: [
                          TextSpan(text: "E"),
                          TextSpan(text: "G"),
                          TextSpan(text: "E"),
                          TextSpan(
                            text: "xam",
                            style:
                                context.themeData.textTheme.display1.copyWith(
                              color: Color(0xFFFD7272),
                            ),
                          ),
                        ]),
                  ),
                )),
            Spacer(flex: 22),
            tabButton(
              context: context,
              tabType: TabType.Home,
              text: "Home",
            ),
            Spacer(flex: 1),
            tabButton(
              context: context,
              tabType: TabType.Classroom,
              text: "Classroom",
            ),
            Spacer(flex: 1),
            tabButton(
              context: context,
              tabType: TabType.Contact,
              text: "Contact",
            ),
            Spacer(flex: 1),
            tabButton(
              context: context,
              tabType: TabType.About,
              text: "About",
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Widget tabButton({BuildContext context, TabType tabType, String text}) {
    TabType currentType =
        Provider.of<BaseController>(context, listen: true).selectedTab;
    return FlatButton(
        onPressed: () {
          Provider.of<BaseController>(context, listen: false).selectedTab =
              tabType;
        },
        color: currentType == tabType
            ? context.themeData.accentColor
            : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Text(text,
            style: currentType == tabType
                ? context.themeData.textTheme.display3.copyWith(
                    color: Colors.white,
                  )
                : context.themeData.textTheme.display3));
  }

  Widget body(BuildContext context) {
    TabType currentType =
        Provider.of<BaseController>(context, listen: true).selectedTab;
    switch (currentType) {
      case TabType.Home:
        return HomeView();
        break;
      case TabType.Classroom:
        return ClassroomView();
        break;
      case TabType.Contact:
        return ContactView();
        break;
      case TabType.About:
        return AboutView();
        break;
      default:
        return HomeView();
    }
  }
}
