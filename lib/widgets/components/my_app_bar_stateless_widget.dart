import 'package:chowsangsang_enterprise_portal/service_factory.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_poss_gp01/blocs/app_mgmt_bloc.dart';
import 'package:mobile_poss_gp01/blocs/authentication_bloc.dart';
import 'package:mobile_poss_gp01/blocs/customer_session_bloc.dart';
import 'package:mobile_poss_gp01/blocs/product_bloc.dart';
import 'package:mobile_poss_gp01/blocs/realm_mgmt_bloc.dart';
import 'package:mobile_poss_gp01/enum/bloc_status.dart';
import 'package:mobile_poss_gp01/events/app_mgmt_event.dart';
import 'package:mobile_poss_gp01/events/authentication_event.dart';
import 'package:mobile_poss_gp01/events/customer_session_event.dart';
import 'package:mobile_poss_gp01/events/product_event.dart';
import 'package:mobile_poss_gp01/events/realm_mgmt_event.dart';
import 'package:mobile_poss_gp01/extension/string_extension.dart';
import 'package:mobile_poss_gp01/repositories/authentication_repository.dart';
import 'package:mobile_poss_gp01/repositories/customer_session_repository.dart';
import 'package:mobile_poss_gp01/repositories/product_repository.dart';
import 'package:mobile_poss_gp01/resources/color_style.dart';
import 'package:mobile_poss_gp01/resources/size_style.dart';
import 'package:mobile_poss_gp01/routes/base/arguments/login_screen_route_arguments.dart';
import 'package:mobile_poss_gp01/routes/base/base_route.dart';
import 'package:mobile_poss_gp01/routes/my_navigator.dart';
import 'package:mobile_poss_gp01/states/app_mgmt_state.dart';
import 'package:mobile_poss_gp01/states/authentication_state.dart';
import 'package:mobile_poss_gp01/states/customer_session_state.dart';
import 'package:mobile_poss_gp01/states/product_state.dart';
import 'package:mobile_poss_gp01/states/realm_mgmt_state.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';
import 'package:mobile_poss_gp01/widgets/components/my_text_stateless_widget.dart';
import 'package:mobile_poss_gp01/widgets/containers/add_to_cart_dialog/add_to_cart_by_store_stateful_widget.dart';

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

  static final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const String currentVersion = String.fromEnvironment("VERSION", defaultValue: "");
    return MultiBlocListener(
        listeners: [
          BlocListener<RealmMgmtBloc, RealmMgmtState>(
            listener: (context, state) {
              if (state.runtimeType == RealmMgmtLogoutSuccess) {
                BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLogoutRequested());
              }
            },
          ),
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              /* 登出成功導向首頁 */
              if (state.runtimeType == AuthenticationLogoutSuccess) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  MyNavigator.pushReset(BaseRoute.loginScreenRouteName, LoginScreenArguments(isAutoLogin: false));
                });
              }
            },
          ),
        ],
        child: AppBar(
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
                            onPressed: () => BlocProvider.of<AppMgmtBloc>(context).add(AppMgmtDrawerOpened()),
                            icon: const Icon(Icons.menu, color: Colors.black, size: 32));
                      }
                      return widget;
                    }),
                    /* 搜尋商品輸入欄 */
                    BlocProvider<ProductBloc>(
                        create: (BuildContext context) => ProductBloc(
                            productRepository: ProductRepository(),
                            authenticationRepository: AuthenticationRepository(),
                            customerSessionRepository: CustomerSessionRepository()),
                        child: BlocListener<ProductBloc, ProductState>(
                          listener: (context, state) {
                            if (state is ProductLoadFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: ColorStyle.warningRed.withOpacity(0.6),
                                duration: const Duration(milliseconds: 3000),
                                margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.3,
                                  right: MediaQuery.of(context).size.width * 0.3,
                                ),
                                content: Center(child: Text(state.errorMessage)),
                              ));
                            } else if (state is ProductStoreLoadSuccess) {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (_) =>
                                      AddToCartByStoreStatefulWidget(productInfo: state.productInfo));
                            } else if (state is ProductRemotedLoadSuccess) {
                              // showMyDialogWithScaffold(
                              //     context: context,
                              //     barrierDismissible: false,
                              //     body: AddToCartByRemotedStatefulWidget(productInfoRes: _productInfoRes));
                            }
                          },
                          child: BlocBuilder<ProductBloc, ProductState>(
                              builder: (BuildContext context, ProductState state) {
                            return Container(
                              width: 200,
                              height: SizeStyle.buttonHeightMedium,
                              margin: const EdgeInsets.only(left: SizeStyle.paddingUnit),
                              child: TextField(
                                controller: _searchController,
                                maxLines: 1,
                                style: const TextStyle(fontSize: 17),
                                textAlignVertical: TextAlignVertical.center,
                                onSubmitted: (String value) =>
                                    context.read<ProductBloc>().add(ProductItemFetched(value: value)),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color.fromRGBO(252, 252, 252, 1),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
                                    onPressed: () => context
                                        .read<ProductBloc>()
                                        .add(ProductItemFetched(value: _searchController.text)),
                                  ),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(30))),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: SizeStyle.paddingUnit * 2),
                                ),
                                // onSubmitted: (String value) => value.isNotEmpty ? _showAddToCartDialog(value, context) : null,
                                // decoration: InputDecoration(
                                //   filled: true,
                                //   fillColor: const Color.fromRGBO(252, 252, 252, 1),
                                //   suffixIcon: IconButton(
                                //     icon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
                                //     onPressed: () => _searchController.text.isNotEmpty
                                //         ? _showAddToCartDialog(_searchController.text, context)
                                //         : null,
                                //   ),
                                //   border: const OutlineInputBorder(
                                //       borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(30))),
                                //   contentPadding: const EdgeInsets.symmetric(horizontal: SizeStyle.paddingUnit * 2),
                                // ),
                              ),
                            );
                          }),
                        )),

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
                    BlocBuilder<RealmMgmtBloc, RealmMgmtState>(builder: (context, state) {
                      return MyTextStatelessWidget(
                        text: currentVersion,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: state.isRealmConnect ? ColorStyle.grey : ColorStyle.white),
                      );
                    }),

                    /* Icons */
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: SizeStyle.paddingUnit),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          /* 會客序號 */
                          BlocProvider<CustomerSessionBloc>(
                              create: (BuildContext context) => CustomerSessionBloc(
                                  customerSessionRepository: CustomerSessionRepository(),
                                  authenticationRepository: AuthenticationRepository())
                                ..add(CustomerSessionInitialed()),
                              child: BlocBuilder<CustomerSessionBloc, CustomerSessionState>(builder: (context, state) {
                                if (state.runtimeType == CustomerSessionLoadSuccess) {
                                  return Row(
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.supervisor_account, size: 20, color: ColorStyle.black),
                                          MyTextStatelessWidget(
                                            text: (state as CustomerSessionLoadSuccess).customerSession?.code,
                                            style: Theme.of(context).textTheme.bodyMedium,
                                            padding: const EdgeInsets.only(left: SizeStyle.paddingUnit),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                } else {
                                  return Row(
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.supervisor_account, size: 20, color: ColorStyle.black),
                                          MyTextStatelessWidget(
                                            text: "--",
                                            style: Theme.of(context).textTheme.bodyMedium,
                                            padding: const EdgeInsets.only(left: SizeStyle.paddingUnit),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }
                              })),

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
        ));
  }
}
