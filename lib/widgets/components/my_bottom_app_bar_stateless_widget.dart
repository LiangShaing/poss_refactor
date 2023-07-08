import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_poss_gp01/blocs/app_mgmt_bloc.dart';
import 'package:mobile_poss_gp01/events/app_mgmt_event.dart';
import 'package:mobile_poss_gp01/resources/color_style.dart';
import 'package:mobile_poss_gp01/resources/size_style.dart';
import 'package:mobile_poss_gp01/resources/static_values.dart';
import 'package:mobile_poss_gp01/states/app_mgmt_state.dart';

class MyBottomAppBarStatefulWidget extends StatefulWidget {
  final Function(String) selectTabFunc;

  const MyBottomAppBarStatefulWidget({Key? key, required this.selectTabFunc}) : super(key: key);

  @override
  MyBottomAppBarStatefulWidgetState createState() => MyBottomAppBarStatefulWidgetState();
}

class MyBottomAppBarStatefulWidgetState extends State<MyBottomAppBarStatefulWidget>
    with SingleTickerProviderStateMixin {

  //TODO:先不判斷沒有會客序號不能去購物車
  // bool _checkCartDisabled = false;

  void _onTap(MyBottomAppBarItem value) {
    if (context.read<AppMgmtBloc>().state.drawer) {
      context.read<AppMgmtBloc>().add(AppMgmtDrawerClosed());
    }
    context.read<AppMgmtBloc>().add(AppMgmtTabChanged(index: value.index));
  }

  @override
  void initState() {
    super.initState();
  }

  // void _handleIconPressed(String type) {
  //   _appProvider.setBottomIndex(1);
  //   mounted ? setState(() {}) : null;
  //   debugPrint(type);
  // }

  Container _qtyWidget(int qty) {
    return qty > 0
        ? Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: SizeStyle.paddingUnit),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorStyle.accent,
            ),
            child: Text(qty.toString(), style: const TextStyle(color: Colors.white)))
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppMgmtBloc,AppMgmtState>(
      builder: (context, stat) {
        return BottomAppBar(
            height: SizeStyle.bottomAppBarHeight,
            color: ColorStyle.lightGrey2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...StaticValues.bottomAppBarNavigation.map((e) {
                  bool isActive = stat.tabIndex == e.index;
                  return Expanded(
                    child: InkWell(
                      // splashColor: _checkCartDisabled ? Colors.transparent : ColorStyle.primary,
                      // highlightColor: _checkCartDisabled ? Colors.transparent : ColorStyle.primary,
                      onTap: () => _onTap(e),
                      child: Container(
                        height: double.infinity,
                        padding: const EdgeInsets.only(top: SizeStyle.paddingUnit),
                        decoration: isActive
                            ? const BoxDecoration(border: Border(top: BorderSide(color: ColorStyle.primary, width: 4.0)))
                            : null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: SizeStyle.paddingUnit),
                              child: Icon(e.icon, color: isActive ? ColorStyle.primary : ColorStyle.lightGrey1),
                            ),
                            Text(e.i18nName ?? "-",
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: isActive ? ColorStyle.primary : ColorStyle.grey,
                                    )),
                            // if (isCart) _qtyWidget(_qty)
                          ],
                        ),
                      ),
                    ),
                  );
                  // bool isCart = false;
                  // if (e.widget != null) return Expanded(child: e.widget!);
                  // if (e.pushRoute == PossMobileRoute.cartPageRouteName) isCart = true;
                  //
                  // // _checkCartDisabled = (isCart && _possProvider.currentCustomerSessionQuery == null ||
                  // //         _possProvider.currentCustomerSessionQuery!.isEmpty)
                  // //     ? true
                  // //     : false;
                  //
                  // return StreamBuilder<RealmResultsChanges<CustomerSession>>(
                  //   stream: IndexPageState.customerService.getCurrentCustomerSession()?.changes,
                  //   builder: (context, snapshot) {
                  //     final data = snapshot.data;
                  //     bool _hasSession = data?.results.firstOrNull != null;
                  //     bool _isActive = _hasSession && _index == e.index;
                  //     int _qty = 0;
                  //     if (data != null && data.results.isNotEmpty) {
                  //       _qty = data.results.first.shoppingBag?.items.length ?? 0;
                  //     }
                  //     return Expanded(
                  //       child: InkWell(
                  //         // splashColor: _checkCartDisabled ? Colors.transparent : ColorStyle.primary,
                  //         // highlightColor: _checkCartDisabled ? Colors.transparent : ColorStyle.primary,
                  //         onTap: _hasSession && !_isActive ? () => _onTap(e) : null,
                  //         child: Container(
                  //           height: double.infinity,
                  //           padding: const EdgeInsets.only(top: SizeStyle.paddingUnit),
                  //           decoration: _isActive
                  //               ? const BoxDecoration(
                  //                   border: Border(top: BorderSide(color: ColorStyle.primary, width: 4.0)))
                  //               : null,
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Padding(
                  //                 padding: const EdgeInsets.only(right: SizeStyle.paddingUnit),
                  //                 child: Icon(e.icon, color: _isActive ? ColorStyle.primary : ColorStyle.lightGrey1),
                  //               ),
                  //               Text(e.i18nName ?? "-",
                  //                   style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  //                         color: _isActive ? ColorStyle.primary : ColorStyle.lightGrey1,
                  //                       )),
                  //               if (isCart) _qtyWidget(_qty)
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // );
                }).toList(),
              ],
            ));
      }
    );
  }
}

class MyBottomAppBarItem {
  final int index;
  final String? i18nName;
  final IconData? icon;

  // final String? pushRoute;
  final Widget? widget;

  const MyBottomAppBarItem(this.index,
      {this.i18nName,
      this.icon,
      // this.pushRoute,
      this.widget});
}
