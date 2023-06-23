import 'package:flutter/material.dart';
import 'package:mobile_poss_gp01/resources/color_style.dart';

class MyLinearProgressIndicator extends StatefulWidget {
  const MyLinearProgressIndicator({super.key});

  @override
  MyLinearProgressIndicatorState createState() => MyLinearProgressIndicatorState();
}

class MyLinearProgressIndicatorState extends State<MyLinearProgressIndicator> with TickerProviderStateMixin {
  late AnimationController _linearIndicatorController;

  @override
  void initState() {
    /* 進度條設定 */
    _linearIndicatorController = AnimationController(
      animationBehavior: AnimationBehavior.preserve,
      vsync: this,
      duration: const Duration(seconds: 20),
    )..addListener(() {
        setState(() {});
      });
    _linearIndicatorController.repeat();
  }

  @override
  void dispose() {
    _linearIndicatorController.stop();
    _linearIndicatorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: LinearProgressIndicator(
        value: _linearIndicatorController.value,
        backgroundColor: ColorStyle.white,
        color: ColorStyle.primary,
        minHeight: 8,
      ),
    );
  }
}
