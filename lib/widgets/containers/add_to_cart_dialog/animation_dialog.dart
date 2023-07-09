import 'package:flutter/material.dart';
import 'package:mobile_poss_gp01/resources/color_style.dart';

class AnimationDialog extends StatefulWidget {
  const AnimationDialog({super.key});

  @override
  AnimationDialogState createState() => AnimationDialogState();
}

class AnimationDialogState extends State<AnimationDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _tween;
  late double x = 0;
  late double y = 0;
  late double opacity = 1;
  late double size = 100;
  late double rotateDeg = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    final animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _tween = Tween<double>(begin: 1.0, end: 0.0).animate(animation);
    _controller
      ..addListener(() {
        if (_tween.value > 0.2) {
          x = (1 - _tween.value) * (MediaQuery.of(context).size.width / 2) + 50;
          y = (1 - _tween.value) * (MediaQuery.of(context).size.height / 2) + 50;
          size = 100 * (_tween.value + 0.2);
          rotateDeg = _tween.value * 360;
        }

        if (_tween.value <= 0.2) {
          opacity = 1 - (0.2 - _tween.value);
        }
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(Duration.zero, () => Navigator.of(context).pop());
        }
      })
      ..forward();

    // Future.delayed(Duration(microseconds: 2100), () => Navigator.of(context).pop());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(x, y, 0),
      child: RotationTransition(
        turns: AlwaysStoppedAnimation(-rotateDeg / 360),
        child: Icon(
          Icons.card_giftcard_rounded,
          size: size,
          color: ColorStyle.primary.withOpacity(opacity),
        ),
      ),
    );
  }
}
