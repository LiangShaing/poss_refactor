import 'package:flutter/material.dart';
import 'package:mobile_poss_gp01/resources/size_style.dart';

class MyAlertDialogStatelessWidget extends StatelessWidget {
  final double dialogWidth;
  final double? dialogHeight;
  final String? title;
  final bool bodyScrollable;
  final bool dialogScrollable;
  final Widget body;
  final Widget? bottomWidget;
  final ScrollController? scrollController;
  final VoidCallback? closeFunc;

  const MyAlertDialogStatelessWidget({
    Key? key,
    this.dialogWidth = SizeStyle.dialogWidth,
    this.dialogHeight,
    this.title,
    this.bodyScrollable = false,
    this.dialogScrollable = true,
    this.bottomWidget,
    this.scrollController,
    this.closeFunc,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme _textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      scrollable: dialogScrollable,
      content: Stack(
        children: [
          Container(
            width: dialogWidth,
            height: dialogHeight,
            padding: const EdgeInsets.symmetric(vertical: SizeStyle.paddingUnit * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// title
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      SizeStyle.paddingUnit * 2,
                      0,
                      SizeStyle.paddingUnit * 2,
                      SizeStyle.paddingUnit * 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title!.toString(), style: _textTheme.displaySmall),
                      ],
                    ),
                  ),

                /// scrollable body (must has dialogHeight)
                if (bodyScrollable && dialogHeight != null)
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: SizeStyle.paddingUnit * 2),
                      child: body,
                    ),
                  ),

                if (!bodyScrollable && dialogHeight != null)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: SizeStyle.paddingUnit * 2),
                      child: body,
                    ),
                  ),

                if (!bodyScrollable && dialogHeight == null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: SizeStyle.paddingUnit * 2),
                    child: body,
                  ),

                /// 底部按鈕
                if (bottomWidget != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      SizeStyle.paddingUnit * 2,
                      SizeStyle.paddingUnit * 2,
                      SizeStyle.paddingUnit * 2,
                      0,
                    ),
                    child: bottomWidget,
                  ),
              ],
            ),
          ),
          if (closeFunc != null)
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                padding: const EdgeInsets.fromLTRB(
                  SizeStyle.paddingUnit * 3,
                  SizeStyle.paddingUnit * 2,
                  SizeStyle.paddingUnit * 2,
                  SizeStyle.paddingUnit * 3,
                ),
                onPressed: closeFunc,
                icon: const Icon(Icons.close, color: Colors.black),
              ),
            ),
        ],
      ),
    );
  }
}
