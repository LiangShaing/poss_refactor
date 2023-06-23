import 'package:flutter/material.dart';
import 'package:mobile_poss_gp01/resources/size_style.dart';
import 'package:mobile_poss_gp01/widgets/components/my_app_bar_stateless_widget.dart';

/// **[isWrapWithLayoutBuilder]** = ture;
///
/// 讓畫面可scroll且預設Expanded為100vh，如果不使用此功能請給false(例如使用Listview時)
///
/// **[isShowWatermark]** = false; 浮水印
class MyScaffoldStatefulWidget extends StatefulWidget {
  final Widget body;
  final bool hasDrawer;
  final bool isShowAppBar;
  final bool isShowBottomAppBar;
  final bool isShowActions;
  final bool isShowBack;
  final bool isShowWatermark;
  final bool isWrapWithLayoutBuilder;
  final VoidCallback? backFunc;
  final VoidCallback? openDrawer;
  final Widget? fixedBottomWidget;
  final ScrollController? scrollController;
  final Function(String)? bottomAppBarSelectTabFunc;

  const MyScaffoldStatefulWidget({
    Key? key,
    required this.body,
    this.hasDrawer = false,
    this.isShowAppBar = true,
    this.isShowBottomAppBar = false,
    this.isShowActions = false,
    this.isShowBack = false,
    this.isShowWatermark = false,
    this.isWrapWithLayoutBuilder = true,
    this.backFunc,
    this.openDrawer,
    this.fixedBottomWidget,
    this.scrollController,
    this.bottomAppBarSelectTabFunc,
  }) : super(key: key);

  @override
  State<MyScaffoldStatefulWidget> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffoldStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    late Widget watermark = Container();

    return Scaffold(
      appBar: widget.isShowAppBar
          ? MyAppBarStatelessWidget(
              isShowDrawer: widget.hasDrawer,
              isShowActions: widget.isShowActions,
              isShowBack: widget.isShowBack,
              openDrawer: widget.hasDrawer ? widget.openDrawer : null,
              backFunc: widget.backFunc,
            )
          : null,
      // resizeToAvoidBottomInset: false,
      // bottomNavigationBar: widget.isShowBottomAppBar
      //     ? MyBottomAppBarStatefulWidget(selectTabFunc: (String value) => widget.bottomAppBarSelectTabFunc!(value))
      //     : null,
      body: Stack(
        children: [
          if (!widget.isWrapWithLayoutBuilder)
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(child: SizedBox(width: double.infinity, child: widget.body)),
                  if (widget.fixedBottomWidget != null) widget.fixedBottomWidget ?? Container(),
                ],
              ),
            ),
          if (widget.isWrapWithLayoutBuilder)
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints viewportConstraints) {
                return Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              controller: widget.scrollController,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    minHeight: widget.fixedBottomWidget == null
                                        ? (viewportConstraints.maxHeight - 22)
                                        : (viewportConstraints.maxHeight - 121)),
                                child: IntrinsicHeight(
                                  child: Container(
                                    padding: const EdgeInsets.only(top: SizeStyle.paddingUnit * 2),
                                    width: double.infinity,
                                    child: widget.body,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (widget.fixedBottomWidget != null) widget.fixedBottomWidget ?? Container(),
                        ],
                      )),
                );
              },
            ),
          if (widget.isShowWatermark)
            Positioned(
              child: OverflowBox(
                maxHeight: double.infinity,
                maxWidth: double.infinity,
                child: IgnorePointer(
                    child: RotationTransition(
                  turns: const AlwaysStoppedAnimation(-15 / 360),
                  child: Column(
                    children: [
                      ...List.filled((MediaQuery.of(context).size.height / 50).round(), 0).map(
                        (_) => Row(
                          children: [
                            ...List.filled((MediaQuery.of(context).size.width / 120).round(), 0).map((_) => watermark),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
              ),
            ),
        ],
      ),
    );
  }
}
