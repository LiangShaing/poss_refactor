import 'package:flutter/material.dart';
import 'package:mobile_poss_gp01/resources/color_style.dart';
import 'package:mobile_poss_gp01/resources/size_style.dart';
import 'package:mobile_poss_gp01/widgets/components/my_text_stateless_widget.dart';
import 'package:shimmer/shimmer.dart';

class MyTextShimmerStatelessWidget extends StatelessWidget {
  final String? title;
  final TextStyle? valueStyle;
  final TextDecoration decoration;

  final EdgeInsets padding;

  const MyTextShimmerStatelessWidget(
      {Key? key,
      this.title,
      this.valueStyle,
      this.decoration = TextDecoration.none,
      this.padding = const EdgeInsets.only(right: SizeStyle.paddingUnit * 0.5)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return title == null
        ? Padding(
            padding: const EdgeInsets.only(bottom: SizeStyle.paddingUnit * 0.5),
            child: Shimmer.fromColors(
              baseColor: ColorStyle.shimmerBaseColor,
              highlightColor: ColorStyle.shimmerHighlightColor,
              child: Container(
                width: 100,
                color: ColorStyle.white,
                child: Text('', style: textTheme.displaySmall),
              ),
            ),
          )
        : Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            direction: Axis.horizontal,
            children: [
              MyTextStatelessWidget(
                  text: title,
                  padding: title!.isEmpty ? const EdgeInsets.all(0) : padding,
                  style: valueStyle ?? textTheme.titleLarge)
            ],
          );
  }
}
