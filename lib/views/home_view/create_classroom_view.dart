import 'package:examapp/controllers/base_controller.dart';
import 'package:examapp/controllers/classroom_controller.dart';
import 'package:examapp/utils/extension.dart';
import 'package:examapp/widget/fade_route.dart';
import 'package:examapp/widget/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateClassroomView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: context.dynamicHeight(1),
              width: context.dynamicWidth(1),
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
                padding: EdgeInsets.all(20),
                height: 400,
                width: 440,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(flex: 2),
                    Expanded(
                      flex: 4,
                      child: Text("Create A Classroom",
                          style: context.themeData.textTheme.display3),
                    ),
                    Spacer(flex: 2),
                    Expanded(
                      flex: 12,
                      child: Form(
                        key: context.read<ClassroomController>().formKey,
                        child: TextFormField(
                          validator: (value) => context
                              .read<ClassroomController>()
                              .validateName(),
                          decoration: new InputDecoration(
                            hintText: "Class Name",
                            errorStyle: context
                                .themeData.inputDecorationTheme.errorStyle
                                .copyWith(
                              color: Colors.red.withOpacity(0.8),
                            ),
                          ),
                          onChanged: (String value) {
                            context.read<ClassroomController>().name = value;
                          },
                        ),
                      ),
                    ),
                    Spacer(flex: 22),
                    Expanded(
                        flex: 4,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: OutlinedButton(
                            style: ButtonStyle(
                              side: MaterialStateProperty.all<BorderSide>(
                                BorderSide(
                                  color: context.themeData.accentColor,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  TransparentRoute(
                                      builder: (context) => LoadingView()));
                              await context
                                  .read<ClassroomController>()
                                  .createClassroom();
                              Navigator.pop(context);
                              Navigator.pop(context);
                              context.read<BaseController>().selectedTab =
                                  TabType.Home;
                            },
                            child: Text(
                              "Create",
                              style:
                                  context.themeData.textTheme.display3.copyWith(
                                color: context.themeData.accentColor,
                              ),
                            ),
                          ),
                        )),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
