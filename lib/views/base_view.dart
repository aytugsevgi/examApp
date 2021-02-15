import 'package:examapp/controllers/base_controller.dart';
import 'package:examapp/controllers/home_controller.dart';
import 'package:examapp/controllers/login_controller.dart';
import 'package:examapp/model/current_user.dart';
import 'package:examapp/model/instructor.dart';
import 'package:examapp/model/student.dart';
import 'package:examapp/routes/application.dart';
import 'package:examapp/service/auth_service.dart';
import 'package:examapp/utils/extension.dart';
import 'package:examapp/views/about_view.dart';
import 'package:examapp/views/classroom_view.dart';
import 'package:examapp/views/contact_view.dart';
import 'package:examapp/views/home_view/home_view.dart';
import 'package:examapp/widget/custom_slide_transition.dart';
import 'package:examapp/widget/fade_route.dart';
import 'package:examapp/widget/loading_view.dart';
import 'package:examapp/widget/responsive_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase/firebase.dart' as firebase;

class BaseView extends StatelessWidget {
  const BaseView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future:
          Provider.of<LoginController>(context, listen: false).currentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var user = snapshot.data;

          if (user != null) {
            CurrentUser.currentUser = user;
            if (user is Instructor) {
              Provider.of<HomeController>(context, listen: false)
                  .homeSelectedView = HomeSelectedView.Instructor;
            } else if (user is Student) {
              Provider.of<HomeController>(context, listen: false)
                  .homeSelectedView = HomeSelectedView.Student;
            }
          } else {
            if (Provider.of<HomeController>(context, listen: false)
                    .homeSelectedView ==
                null) {
              Provider.of<HomeController>(context, listen: false)
                  .homeSelectedView = HomeSelectedView.Welcome;
            }
          }
          return appBarAndBody(context);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }

  Stack appBarAndBody(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          top: ResponsiveWidget.isSmallScreen(context) ? 40 : 100,
          right: ResponsiveWidget.isSmallScreen(context) ? 10 : -50,
          duration: Duration(seconds: 1),
          child: AnimatedContainer(
              duration: Duration(seconds: 1),
              height: ResponsiveWidget.isSmallScreen(context)
                  ? 100
                  : ResponsiveWidget.isMediumScreen(context)
                      ? 500
                      : context.dynamicWidth(0.4),
              child: firebase.auth().currentUser == null
                  ? Image.asset(
                      "assets/background.jpg",
                      fit: BoxFit.contain,
                    )
                  : SizedBox.shrink()),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              buildAppBar(context),
              SizedBox(
                height: 50,
              ),
              Expanded(
                  child: SizedBox(
                      height: context.dynamicHeight(1),
                      width: context.dynamicWidth(1),
                      child: body(context))),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildAppBar(BuildContext context) {
    return CustomSlideTransition(
      child: ResponsiveWidget(
          largeScreen: _appBarLarge(context),
          mediumScreen: _appBarSmall(context),
          smallScreen: _appBarSmall(context)),
    );
  }

  SizedBox _appBarLarge(BuildContext context) {
    return SizedBox(
      height: 100,
      width: context.dynamicWidth(1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
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
                          style: context.themeData.textTheme.display1.copyWith(
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
          Spacer(flex: 1),
          firebase.auth().currentUser != null
              ? FlatButton(
                  onPressed: () async {
                    await signOut(context);
                  },
                  color: Color(0xFF444444),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: FittedBox(
                    child: Text("Sign Out",
                        style: context.themeData.textTheme.display3
                            .copyWith(color: Colors.white)),
                  ))
              : SizedBox.shrink(),
          Spacer(flex: 2),
        ],
      ),
    );
  }

  SizedBox _appBarSmall(BuildContext context) {
    return SizedBox(
      height: 100,
      width: context.dynamicWidth(1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
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
                          style: context.themeData.textTheme.display1.copyWith(
                            color: Color(0xFFFD7272),
                          ),
                        ),
                      ]),
                ),
              )),
          Spacer(flex: 27),
        ],
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
        child: FittedBox(
          child: Text(text,
              style: currentType == tabType
                  ? context.themeData.textTheme.display3.copyWith(
                      color: Colors.white,
                    )
                  : context.themeData.textTheme.display3),
        ));
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

  Future<void> signOut(BuildContext context) async {
    Navigator.of(context)
        .push(TransparentRoute(builder: (context) => LoadingView()));
    await AuthService().singOut();
    CurrentUser.currentUser = null;
    await Future.delayed(Duration(milliseconds: 300));
    Navigator.pop(context);

    context.read<BaseController>().selectedTab = TabType.Home;
    context.read<HomeController>().homeSelectedView = HomeSelectedView.Welcome;
  }
}
