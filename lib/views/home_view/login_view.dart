import 'package:examapp/controllers/base_controller.dart';
import 'package:examapp/controllers/home_controller.dart';
import 'package:examapp/controllers/login_controller.dart';
import 'package:examapp/model/current_user.dart';
import 'package:examapp/model/instructor.dart';
import 'package:examapp/model/student.dart';
import 'package:examapp/utils/extension.dart';
import 'package:examapp/widget/custom_fade_transition.dart';
import 'package:examapp/widget/fade_route.dart';
import 'package:examapp/widget/loading_view.dart';
import 'package:examapp/widget/responsive_widget.dart';
import 'package:examapp/widget/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomFadeTransition(
      child: ListView(
        shrinkWrap: true,
        children: [
          Row(
            children: [
              AnimatedContainer(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  duration: Duration(milliseconds: 200),
                  width: ResponsiveWidget.isLargeScreen(context)
                      ? context.dynamicWidth(0.4)
                      : ResponsiveWidget.isMediumScreen(context)
                          ? context.dynamicWidth(0.5)
                          : context.dynamicWidth(0.7),
                  child: Form(
                    key: context.read<LoginController>().formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 36,
                        ),
                        SizedBox(
                          height: 48,
                          child: FittedBox(
                            child: Text(
                              "Log in",
                              style: context.themeData.textTheme.title.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 36,
                          child: Divider(
                            thickness: 4,
                            color: context.themeData.buttonColor,
                            endIndent: context.dynamicWidth(0.1),
                          ),
                        ),
                        SizedBox(
                          height: 66,
                          child: RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                                style: context.themeData.textTheme.subtitle1
                                    .copyWith(
                                        fontSize: 14,
                                        color: Colors.black.withOpacity(0.7)),
                                text:
                                    "Please log in to your account to continue with Online Team Management Tool."),
                          ),
                        ),
                        SizedBox(
                          height: 72,
                          child: TextFormField(
                            validator: (value) => Provider.of<LoginController>(
                                    context,
                                    listen: false)
                                .validateEmail(),
                            decoration: new InputDecoration(
                              hintText: "Email Address",
                              errorStyle: context
                                  .themeData.inputDecorationTheme.errorStyle
                                  .copyWith(
                                color: Colors.red.withOpacity(0.8),
                              ),
                            ),
                            onChanged: (String value) {
                              Provider.of<LoginController>(context,
                                      listen: false)
                                  .email = value;
                            },
                          ),
                        ),
                        SizedBox(
                            height: 72,
                            child: TextFormField(
                                obscureText: true,
                                validator: (value) =>
                                    Provider.of<LoginController>(context,
                                            listen: false)
                                        .validatePassword(),
                                decoration: new InputDecoration(
                                  hintText: "Password",
                                  errorStyle: context
                                      .themeData.inputDecorationTheme.errorStyle
                                      .copyWith(
                                    color: Colors.red.withOpacity(0.8),
                                  ),
                                ),
                                onChanged: (String value) {
                                  Provider.of<LoginController>(context,
                                          listen: false)
                                      .password = value;
                                })),
                        SizedBox(
                            height: 84,
                            child: Center(
                                child: SubmitButton(
                              colors: [
                                context.themeData.primaryColor,
                                context.themeData.primaryColor,
                              ],
                              child: Text(
                                "Login",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 26),
                              ),
                              onTap: () async {
                                await onTapLogin(context);
                              },
                            ))),
                        SizedBox(
                            height: 72,
                            child: Center(
                              child: Text("Forgot password?",
                                  style: context.themeData.textTheme.bodyText1
                                      .copyWith(fontWeight: FontWeight.bold)),
                            )),
                        SizedBox(
                          height: 90,
                          child: Center(
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                Provider.of<HomeController>(context,
                                            listen: false)
                                        .homeSelectedView =
                                    HomeSelectedView.Register;
                              },
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "You dont't have an account\n",
                                      style: context
                                          .themeData.textTheme.bodyText1
                                          .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Sign Up",
                                      style: context
                                          .themeData.textTheme.bodyText1
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: context
                                                  .themeData.buttonColor),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  onTapLogin(BuildContext context) async {
    Navigator.push(
        context, TransparentRoute(builder: (context) => LoadingView()));
    bool isLogin = await context.read<LoginController>().login();

    if (isLogin) {
      var user = await context.read<LoginController>().currentUser();
      Navigator.pop(context);
      CurrentUser.currentUser = user;
      if (CurrentUser.currentUser is Instructor) {
        context.read<HomeController>().homeSelectedView =
            HomeSelectedView.Instructor;
        context.read<BaseController>().selectedTab = TabType.Home;
      } else if (CurrentUser.currentUser is Student) {
        context.read<HomeController>().homeSelectedView =
            HomeSelectedView.Student;
        context.read<BaseController>().selectedTab = TabType.Home;
      } else {
        print("HEEELLLOOO");
        context.read<HomeController>().homeSelectedView =
            HomeSelectedView.Welcome;
        context.read<BaseController>().selectedTab = TabType.Home;
      }
    } else {
      Navigator.pop(context);
    }
  }
}
