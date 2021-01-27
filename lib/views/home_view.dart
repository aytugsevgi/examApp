import 'dart:ui';
import 'package:examapp/utils/extension.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(
          flex: 2,
        ),
        Expanded(
          flex: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 600,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 20,
                  child: FittedBox(
                    child: Text(
                      "Welcome!\nEge Examination System",
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
                            style:
                                context.themeData.textTheme.display1.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                  text:
                                      "Build or start your online exam today.\n"),
                              TextSpan(text: "Also first month is "),
                              TextSpan(
                                text: "free!",
                                style: context.themeData.textTheme.display1
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: context.themeData.primaryColor),
                              ),
                            ])),
                  ),
                ),
                Spacer(flex: 18),
                Expanded(
                  flex: 15,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 42,
                        child: RaisedButton(
                          color: context.themeData.primaryColor,
                          onPressed: () {},
                          child: Text(
                            "GET STARTED",
                            style:
                                context.themeData.textTheme.display1.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Spacer(flex: 6),
                      Expanded(
                        flex: 42,
                        child: OutlinedButton(
                          style: ButtonStyle(
                              side: MaterialStateProperty.all(BorderSide(
                            color: context.themeData.accentColor,
                            width: 4,
                          ))),
                          onPressed: () {},
                          child: Text(
                            "Learn More",
                            style:
                                context.themeData.textTheme.display1.copyWith(
                              color: context.themeData.accentColor,
                            ),
                          ),
                        ),
                      ),
                      Spacer(flex: 10),
                    ],
                  ),
                ),
                Spacer(
                  flex: 15,
                ),
              ],
            ),
          ),
        ),
        Spacer(
          flex: 10,
        ),
      ],
    );
  }
}
