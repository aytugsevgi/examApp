import 'package:examapp/widget/custom_fade_transition.dart';
import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomFadeTransition(child: Center(child: Text("About")));
  }
}
