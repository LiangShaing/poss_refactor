import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_poss_gp01/blocs/app_mgmt_bloc.dart';
import 'package:mobile_poss_gp01/resources/size_style.dart';
import 'package:mobile_poss_gp01/routes/base/base_route.dart';
import 'package:mobile_poss_gp01/routes/custom_page_route.dart';
import 'package:mobile_poss_gp01/routes/my_navigator.dart';
import 'package:mobile_poss_gp01/states/app_mgmt_state.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';
import 'package:mobile_poss_gp01/widgets/components/my_app_bar_stateless_widget.dart';

import 'my_bottom_app_bar_stateless_widget.dart';

/// **[isWrapWithLayoutBuilder]** = ture;
///
/// 讓畫面可scroll且預設Expanded為100vh，如果不使用此功能請給false(例如使用Listview時)
///
/// **[isShowWatermark]** = false; 浮水印
class MyScaffoldStatefulWidget extends StatefulWidget {
  final Widget body;
  final bool hasDrawer;
  final bool isShowAppBar;
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

    return MultiBlocListener(
      listeners: [
        BlocListener<AppMgmtBloc, AppMgmtState>(listener: (context, state) {
          if (state.drawer) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              MyNavigator.push(BaseRoute.menuScreenRouteName);
            });
          } else if (!state.drawer) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              MyNavigator.maybePop();
            });
          }
        })
      ],
      child: Scaffold(
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
        bottomNavigationBar: MyBottomAppBarStatefulWidget(selectTabFunc: (String value) {
          // if (value == '/pagea') {
          //   SchedulerBinding.instance.addPostFrameCallback((_) {
          //     Navigator.pushAndRemoveUntil(context, CustomPageRoute(builder: (context) {
          //       return PageAScreen();
          //     }), (route) => false);
          //   });
          // } else {
          //   SchedulerBinding.instance.addPostFrameCallback((_) {
          //     Navigator.pushAndRemoveUntil(context, CustomPageRoute(builder: (context) {
          //       return PageBScreen();
          //     }), (route) => false);
          //   });
          // }
        }),
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
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                controller: widget.scrollController,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
                                  child: IntrinsicHeight(
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: widget.body,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // if (widget.fixedBottomWidget != null) widget.fixedBottomWidget ?? Container(),
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
                              ...List.filled((MediaQuery.of(context).size.width / 120).round(), 0)
                                  .map((_) => watermark),
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
      ),
    );
  }
}
