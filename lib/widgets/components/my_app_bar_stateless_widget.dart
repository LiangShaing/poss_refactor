import 'package:chowsangsang_enterprise_portal/service_factory.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_poss_gp01/blocs/app_mgmt_bloc.dart';
import 'package:mobile_poss_gp01/blocs/authentication_bloc.dart';
import 'package:mobile_poss_gp01/blocs/realm_mgmt_bloc.dart';
import 'package:mobile_poss_gp01/events/app_mgmt_event.dart';
import 'package:mobile_poss_gp01/events/authentication_event.dart';
import 'package:mobile_poss_gp01/events/realm_mgmt_event.dart';
import 'package:mobile_poss_gp01/extension/string_extension.dart';
import 'package:mobile_poss_gp01/resources/size_style.dart';
import 'package:mobile_poss_gp01/routes/custom_page_route.dart';
import 'package:mobile_poss_gp01/states/app_mgmt_state.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';
import 'package:mobile_poss_gp01/widgets/screens/login/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';

class MyAppBarStatelessWidget extends StatelessWidget implements PreferredSize {
  final bool isShowBack;
  final bool isShowDrawer;
  final bool isShowActions;
  final VoidCallback? backFunc;
  final VoidCallback? openDrawer;
  final Function(String)? onSubmitted;

  const MyAppBarStatelessWidget(
      {Key? key,
      this.isShowBack = false,
      this.isShowDrawer = false,
      this.isShowActions = false,
      this.backFunc,
      this.openDrawer,
      this.onSubmitted})
      : super(key: key);

  @override
  Widget get child => throw UnimplementedError();

  /// 設定appbar高度，預設為[kToolbarHeight]
  @override
  Size get preferredSize => SizeStyle.topAppBarSize;

  /// 搜尋商品
  // Future<void> _showAddToCartDialog(String searchText, BuildContext context) async {
  //   /* 清除文字 */
  //
  //   _searchController.clear();
  //
  //   try {
  //     /* 請先產生新會客序號 */
  //     if (!IndexPageState.customerService.checkCustomerSessionIsNotEmpty()) {
  //       Logger.debug(message: "_showAddToCartDialog currentCustomerSessionQuery is empty");
  //       return showAlert(
  //         context,
  //         "widget.showAddToCartDialog.message.createdCustomerSession".tr,
  //         icon: IconStyle.alertCheck,
  //       );
  //     }
  //
  //     /* 從realm找出商品 */
  //     ProductInfoRes _productInfoRes = IndexPageState.prodService.findProductBySearchText(searchText);
  //
  //     /* 瀏覽商品dialog */
  //     if (_productInfoRes.isInStore) {
  //       /* 有本店現貨 */
  //       Logger.info(message: 'searching $searchText is in Store, show AddToCartByStoreStatefulWidget');
  //       showDialog(
  //           context: context,
  //           barrierDismissible: false,
  //           builder: (_) => AddToCartByStoreStatefulWidget(productInfoRes: _productInfoRes));
  //     } else {
  //       /* 無本店現貨 */
  //       Logger.info(message: 'searching $searchText is remote, show AddToCartByRemotedStatefulWidget');
  //       showMyDialogWithScaffold(
  //           context: context,
  //           barrierDismissible: false,
  //           body: AddToCartByRemotedStatefulWidget(productInfoRes: _productInfoRes));
  //     }
  //   } catch (e) {
  //     Logger.error(message: "IndexPageStatefulWidget _showAddToCartDialog : ${e.toString()}");
  //     switch (e.runtimeType) {
  //       case RealmException:
  //         showAlert(
  //           context,
  //           "widget.appbar.label.searchNotFound".tr,
  //           icon: IconStyle.alertWarning,
  //         );
  //         break;
  //       case BadRequestException:
  //         showAlert(context, "widget.showAddToCartDialog.message.getPriceFailed".tr, icon: IconStyle.alertWarning,
  //             callback: () {
  //           Navigator.of(context).pop();
  //           /* 同時關閉商品瀏覽dialog */
  //           Navigator.of(context).maybePop();
  //         });
  //         break;
  //       default:
  //         handleException(e, context, eventName: "MyAppBarStatelessWidget _showAddToCartDialog");
  //         break;
  //     }
  //   }
  // }

  /// 登出
  // Future<void> _showLogoutDialog(BuildContext context) async {
  //   bool isConfirm =
  //       await showAlertWithResp(context, "base.login.msg.confirmedLogout".tr, titleAlignment: TextAlign.center) ??
  //           false;
  //   if (isConfirm) {
  //     try {
  //       // LogoutModel _logoutModel = LogoutModel();
  //       // await _logoutModel.logout(context);
  //       // Future(
  //       //     () => MyNavigationService.pushReset(BaseRoute.loginPageRouteName, LoginPageArguments(isAutoLogin: false)));
  //     } catch (error) {
  //       Logger.error(message: "_logout  ${error.toString()}");
  //     }
  //   }
  // }

  static final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const String currentVersion = String.fromEnvironment("VERSION", defaultValue: "");
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Stack(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BlocBuilder<AppMgmtBloc, AppMgmtState>(builder: (BuildContext context, AppMgmtState state) {
                  Widget widget = Container();
                  if (state.drawer) {
                    widget = IconButton(
                        onPressed: () => BlocProvider.of<AppMgmtBloc>(context).add(AppMgmtDrawerClosed()),
                        icon: const Icon(Icons.menu_open_outlined, color: Colors.black, size: 32));
                  } else if (!state.drawer) {
                    widget = IconButton(
                        onPressed: () => BlocProvider.of<AppMgmtBloc>(context).add(AppMgmtDrawerShowed()),
                        icon: const Icon(Icons.menu, color: Colors.black, size: 32));
                  }
                  return widget;
                }),
                // StreamBuilder<RealmResultsChanges<CustomerSession>>(
                //   stream: IndexPageState.customerService.getCurrentCustomerSession()?.changes,
                //   builder: (context, snapshot) {
                //     final data = snapshot.data;
                //     if (data?.results.firstOrNull != null) {
                //       /* 搜尋商品輸入欄 */
                //       return Container(
                //         width: 200,
                //         height: SizeStyle.buttonHeightMedium,
                //         margin: const EdgeInsets.only(left: SizeStyle.paddingUnit),
                //         child: TextField(
                //           controller: _searchController,
                //           maxLines: 1,
                //           style: const TextStyle(fontSize: 17),
                //           textAlignVertical: TextAlignVertical.center,
                //           onSubmitted: (String value) => value.isNotEmpty ? _showAddToCartDialog(value, context) : null,
                //           decoration: InputDecoration(
                //             filled: true,
                //             fillColor: const Color.fromRGBO(252, 252, 252, 1),
                //             suffixIcon: IconButton(
                //               icon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
                //               onPressed: () => _searchController.text.isNotEmpty
                //                   ? _showAddToCartDialog(_searchController.text, context)
                //                   : null,
                //             ),
                //             border: const OutlineInputBorder(
                //                 borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(30))),
                //             contentPadding: const EdgeInsets.symmetric(horizontal: SizeStyle.paddingUnit * 2),
                //           ),
                //         ),
                //       );
                //     }
                //     return Container();
                //   },
                // ),
              ],
            ),
            /* 右邊欄位 */
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /* 版本號 */
                // StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                //   if (Provider.of<PossProvider?>(context, listen: false) != null) {
                //     final PossProvider _possProvider = context.watch<PossProvider>();
                //     bool _connection = _possProvider.getRealmConnection;
                //     return MyTextStatelessWidget(
                //       text: _currentVersion,
                //       style: Theme.of(context)
                //           .textTheme
                //           .bodySmall
                //           ?.copyWith(color: _connection ? ColorStyle.grey : ColorStyle.white),
                //     );
                //   }
                //   return Container();
                // }),

                /* Icons */
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: SizeStyle.paddingUnit),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      /* 會客序號 */
                      // StreamBuilder<RealmResultsChanges<CustomerSession>>(
                      //   stream: IndexPageState.customerService.getCurrentCustomerSession()?.changes,
                      //   builder: (context, snapshot) {
                      //     final data = snapshot.data;
                      //     String _customerId = "--";
                      //     if (data?.results.firstOrNull != null) {
                      //       _customerId = data?.results.firstOrNull?.code ?? "--";
                      //     }
                      //     return Row(
                      //       children: [
                      //         Row(
                      //           mainAxisSize: MainAxisSize.min,
                      //           children: [
                      //             const Icon(Icons.supervisor_account, size: 20, color: ColorStyle.black),
                      //             MyTextStatelessWidget(
                      //               text: _customerId,
                      //               style: Theme.of(context).textTheme.bodyMedium,
                      //               padding: const EdgeInsets.only(left: SizeStyle.paddingUnit),
                      //             ),
                      //           ],
                      //         ),
                      //       ],
                      //     );
                      //   },
                      // ),

                      /* 登出 */
                      IconButton(
                        constraints: const BoxConstraints.expand(width: 40, height: 40),
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          showDialog<bool>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) => AlertDialog(
                              title: Column(children: [
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Icon(Icons.error_outline_outlined,
                                      color: Color.fromRGBO(238, 103, 60, 1), size: 24),
                                ),
                                Text("base.login.msg.confirmedLogout".tr,
                                    style: const TextStyle(fontSize: 16, color: Colors.black))
                              ]),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("widget.button.back".tr),
                                  onPressed: () => Navigator.pop(context, false),
                                ),
                                TextButton(
                                  child: Text("widget.button.confirm".tr),
                                  onPressed: () => Navigator.pop(context, true),
                                ),
                              ],
                            ),
                          ).then((value) {
                            if (value == true) {
                              Logger.debug(message: "logout");
                              BlocProvider.of<RealmMgmtBloc>(context).add(RealmMgmtLogoutRequested());
                              BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLogoutRequested());

                              SchedulerBinding.instance.addPostFrameCallback((_) {
                                Navigator.push(context, CustomPageRoute(builder: (context) {
                                  return const LoginScreen(isAutoLogin: false);
                                }));
                              });
                            }
                          });
                        },
                        icon: const Icon(Icons.logout, color: Colors.black),
                      ),
                      // IconButton(
                      //   constraints: const BoxConstraints.expand(width: 40, height: 40),
                      //   padding: EdgeInsets.zero,
                      //   onPressed: () {},
                      //   icon: const Icon(Icons.settings, color: Colors.black),
                      // ),
                      // IconButton(
                      //   constraints: const BoxConstraints.expand(width: 40, height: 40),
                      //   padding: EdgeInsets.zero,
                      //   onPressed: () => _showCustomerSessionDialog(context),
                      //   icon: const Icon(Icons.supervisor_account, color: Colors.black),
                      // ),
                      // IconButton(
                      //   constraints: const BoxConstraints.expand(width: 40, height: 40),
                      //   padding: EdgeInsets.zero,
                      //   onPressed: () {},
                      //   icon: const Icon(Icons.notifications, color: Colors.black),
                      // ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,
          height: SizeStyle.topAppBarSize.height,
          child: Center(child: SizedBox(width: 160, child: Image.asset('assets/images/app_bar_css_logo.png'))),
        )
      ]),
      automaticallyImplyLeading: isShowBack,
    );
  }
}
