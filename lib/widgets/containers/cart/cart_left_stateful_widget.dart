import 'package:chowsangsang_enterprise_portal/service_factory.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile_poss_gp01/extension/string_extension.dart';
import 'package:mobile_poss_gp01/resources/size_style.dart';
import 'package:mobile_poss_gp01/widgets/components/my_text_stateless_widget.dart';
import 'package:realm/realm.dart';

class CartLeftStatefulWidget extends StatefulWidget {
  const CartLeftStatefulWidget({Key? key}) : super(key: key);

  @override
  State<CartLeftStatefulWidget> createState() => _CartLeftStatefulWidgetState();

  PossMobileService getService() => ServiceFactory.createPossMobileService(rtGetNewAtToggle: true);
}

class _CartLeftStatefulWidgetState extends State<CartLeftStatefulWidget> {
  /// TODO 整單優惠&註銷
  // late final PanelController _pcBottom = PanelController();
  // late final double _slideUpWidth =
  //     MediaQuery.of(context).size.width - SizeStyle.fixedColumnWidth - (SizeStyle.pagePadding * 3);

  String _formatIndex(int number) => number.toString().padLeft(2, '0');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // void _removeCartItem(BuildContext context, ShoppingBagItem shoppingBagItem) async {
  //   startLoading(context);
  //   try {
  //     await IndexPageState.cartService.removeCartItem(shoppingBagItem);
  //     showSuccessSnackBar(context, 'cart.removed'.tr);
  //   } catch (e) {
  //     Slidable.of(context)?.close();
  //     String errorMessage = "";
  //     if (e.runtimeType == BadRequestException) {
  //       // showAlert(context, 'cart\.deleteFailed'.tr, icon: IconStyle.alertWarning);
  //       errorMessage = e.toString();
  //     } else {
  //       handleException(e, context, eventName: "CartLeftStatefulWidget _removeCartItem");
  //     }
  //
  //     showErrorSnackBar(context, "${'cart.deleteFailed'.tr} $errorMessage");
  //     Logger.error(message: "CartLeftStatefulWidget _removeCartItem failed");
  //   }
  //   if (MyNavigationService.canPop()) MyNavigationService.pop();
  // }

  /// TODO 整單優惠 規則還不太清楚
  // List<DiscountRenderItem> getDiscountRenderList(List<HistoryItem> cartItems) {
  //   List<DiscountRenderItem> _list = [];
  //   List<ProductDiscount> _discounts = cartItems
  //       .map((HistoryItem e) =>
  //           e.discounts.firstWhereOrNull((ProductDiscount i) => i.projectLineId == e.selectedDiscountProjectLineId))
  //       .whereType<ProductDiscount>()
  //       .toList();
  //
  //   if (_discounts.isNotEmpty) {
  //     List<String> _discountTypes = _discounts.map((e) => e.projectLineId).toSet().toList();
  //
  //     for (String projectCode in _discountTypes) {
  //       List<String> _idxList = [];
  //       for (var i in cartItems) {
  //         /* 商品選擇的折扣是否屬於此折扣 */
  //         bool _withProjectCode = i.discounts
  //             .any((d) => i.selectedDiscountProjectLineId == d.projectLineId && d.projectLineId == projectCode);
  //
  //         if (_withProjectCode) {
  //           int _idx = cartItems.indexOf(i);
  //           _idxList.insert(0, _formatIndex(cartItems.length - _idx));
  //         }
  //       }
  //       ProductDiscount _productDiscount = _discounts.firstWhere((e) => e.projectLineId == projectCode);
  //       _list.add(DiscountRenderItem(discountName: _productDiscount.discountName, discountIndexList: _idxList));
  //     }
  //   }
  //
  //   return _list;
  // }

  @override
  Widget build(BuildContext context) {
    // final PossProvider _possProvider = context.read<PossProvider>();
    List _cartItemsClone = [];
    return Padding(
      padding: const EdgeInsets.only(left: SizeStyle.pagePadding),
      child: Stack(
        children: [
          Column(
            children: [
              /* 標題 */
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /* 清空購物車 */
                  // Padding(
                  //   padding: const EdgeInsets.only(top: SizeStyle.paddingUnit),
                  //   child: TextButton.icon(
                  //     style: TextButton.styleFrom(foregroundColor: ColorStyle.primary),
                  //     onPressed: _cartItemsClone.isEmpty
                  //         ? null
                  //         : () async {
                  //             bool? _isConfirmed = await showAlertWithResp(context, '確認要清空購物車?');
                  //             if (_isConfirmed == true) IndexPageState.cartService.clearAllCartItem();
                  //           },
                  //     icon: const Icon(Icons.cleaning_services_outlined),
                  //     label: const Text('清空購物車'),
                  //   ),
                  // ),
                  Padding(
                    // padding: const EdgeInsets.only(top: SizeStyle.paddingUnit * 2),
                    padding: const EdgeInsets.only(top: SizeStyle.paddingUnit),
                    child: Row(
                      children: [
                        //TODO checkbox
                        // if (_cartItems.isNotEmpty)
                        //   SizedBox(
                        //     height: 25,
                        //     width: 25,
                        //     child: Checkbox(
                        //       checkColor: Colors.white,
                        //       value: _cartItems.length == _isChecked.length,
                        //       onChanged: (_) => _handleAllItemChecked(),
                        //     ),
                        //   ),
                        Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text("home.label.product".tr, style: Theme.of(context).textTheme.titleLarge)),
                        const Spacer(),
                        MyTextStatelessWidget(
                            text: "${"cart.label.price".tr} (RMB ¥)",
                            padding: const EdgeInsets.only(right: SizeStyle.paddingUnit * 6)),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: Color.fromRGBO(102, 102, 102, 1)),
                ],
              ),

              /* 購物車商品 */
              if (_cartItemsClone.isNotEmpty)
                Expanded(
                  child: SlidableAutoCloseBehavior(
                    child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(
                          0,
                          SizeStyle.paddingUnit,
                          SizeStyle.paddingUnit,
                          SizeStyle.paddingUnit * 3,
                        ),
                        itemBuilder: (context, index) => Builder(builder: (context) {
                          return Container();
                              // ShoppingBagItem _cartItem = _cartItemsClone[index];
                              // CacheProductItem? _cacheProductItem = IndexPageState.cartService
                              //     .findCacheProductItem(_cartItem.inventoryId, _cartItem.modelSequenceNumber);
                              // return CartItemStatelessWidget(
                              //   // isChecked: _cartItem.selectIndicator ,
                              //   index: _formatIndex(_cartItemsClone.length - index),
                              //   removeCartItem: (context) => _removeCartItem(context, _cartItem),
                              //   onCheck: (bool bl) {
                              //     // _possProvider.addOrUpdateCartItem(_productInfo, selectIndicator: bl)
                              //   },
                              //   cacheProductItem: _cacheProductItem,
                              //   shoppingBagItem: _cartItem,
                              //   customerSession: _customerSession!.results.first,
                              //   // isPriceLoading: true,
                              // );
                            }),
                        separatorBuilder: (_, __) => const SizedBox(height: SizeStyle.paddingUnit * 2),
                        itemCount: _cartItemsClone.length),
                  ),
                ),
            ],
          ),

          /* 助銷信息 */
          // if (widget.data != null && widget.data!.upsellMessages.isNotEmpty)
          //   SlidingUpPanel(
          //     slideDirection: SlideDirection.DOWN,
          //     controller: _pcTop,
          //     maxHeight: 120,
          //     minHeight: 20,
          //     defaultPanelState: PanelState.CLOSED,
          //     renderPanelSheet: false,
          //     panel: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Expanded(
          //           child: Container(
          //             width: _slideUpWidth,
          //             padding: const EdgeInsets.all(12),
          //             decoration: BoxDecoration(
          //                 color: ColorStyle.slideUpBackground,
          //                 borderRadius: const BorderRadius.only(
          //                   bottomLeft: Radius.circular(6),
          //                   bottomRight: Radius.circular(6),
          //                 )),
          //             child: SingleChildScrollView(
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   ...["cart.label.upsellMessages".tr, ...?widget.data?.upsellMessages].map(
          //                     (e) => Text(
          //                       e,
          //                       style: Theme.of(context).textTheme.titleLarge?.copyWith(color: ColorStyle.white),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),
          //         InkWell(
          //           onTap: () => _pcTop.isPanelOpen ? _pcTop.close() : _pcTop.open(),
          //           child: Container(
          //             height: 20,
          //             width: _slideUpWidth,
          //             alignment: Alignment.topCenter,
          //             child: Container(
          //                 width: 76,
          //                 height: 8,
          //                 alignment: Alignment.center,
          //                 decoration: BoxDecoration(
          //                     color: ColorStyle.slideUpBackground,
          //                     borderRadius: const BorderRadius.only(
          //                       bottomLeft: Radius.circular(6),
          //                       bottomRight: Radius.circular(6),
          //                     )),
          //                 child: Row(
          //                   crossAxisAlignment: CrossAxisAlignment.center,
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     Container(width: 60, height: 2, color: ColorStyle.pageBackground),
          //                   ],
          //                 )),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),

          /* 整單優惠 */
          // if (_cartItems.isNotEmpty)
          //   SlidingUpPanel(
          //     controller: _pcBottom,
          //     maxHeight: 120,
          //     minHeight: 28,
          //     defaultPanelState: PanelState.CLOSED,
          //     renderPanelSheet: false,
          //     panel: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         /* 整單優惠^按鈕感應範圍 */
          //         InkWell(
          //           onTap: () => _pcBottom.isPanelOpen ? _pcBottom.close() : _pcBottom.open(),
          //           child: Container(
          //             width: _slideUpWidth,
          //             alignment: Alignment.center,
          //             child: Container(
          //                 width: 84,
          //                 height: 28,
          //                 alignment: Alignment.center,
          //                 decoration: BoxDecoration(
          //                     color: ColorStyle.slideUpBackground,
          //                     borderRadius: const BorderRadius.only(
          //                       topLeft: SizeStyle.radius,
          //                       topRight: SizeStyle.radius,
          //                     )),
          //                 child: Row(
          //                   crossAxisAlignment: CrossAxisAlignment.center,
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     Text(
          //                       Translate.of(context).getLan("cart.label.wholeOrderDiscount"),
          //                       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          //                             color: ColorStyle.white,
          //                             fontWeight: FontWeight.bold,
          //                           ),
          //                     ),
          //                     const Icon(Icons.expand_less, color: ColorStyle.white, size: 18),
          //                   ],
          //                 )),
          //           ),
          //         ),
          //
          //         /* 優惠內容 */
          //         Expanded(
          //           child: Container(
          //             width: _slideUpWidth,
          //             padding: const EdgeInsets.all(12),
          //             decoration: BoxDecoration(
          //                 color: ColorStyle.slideUpBackground,
          //                 borderRadius: const BorderRadius.only(
          //                   topLeft: SizeStyle.radius,
          //                   topRight: SizeStyle.radius,
          //                 )),
          //             child: SingleChildScrollView(
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   ...getDiscountRenderList(_cartItems).map(
          //                     (e) => Text('${e.discountName} (${e.discountIndexList.join(',')})',
          //                         style:
          //                             Theme.of(context).textTheme.titleLarge?.copyWith(color: ColorStyle.white)),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
        ],
      ),
    );
    // return StreamBuilder<RealmResultsChanges<CustomerSession>>(
    //     stream: IndexPageState.customerService.getCurrentCustomerSession()?.changes,
    //     builder: (context, snapshot) {
    //       final RealmResultsChanges<CustomerSession>? _customerSession = snapshot.data;
    //       final List<CacheProductItem>? cacheProductItems =
    //           _customerSession?.results.firstOrNull?.uiPersistShoppingBag?.cacheProductItems;
    //       final ShoppingBag? _shoppingBag = _customerSession?.results.firstOrNull?.shoppingBag;
    //       final List<ShoppingBagItem> _shoppingBagItems = _shoppingBag?.items ?? [];
    //
    //       /* clone shopping bag items */
    //       late List<ShoppingBagItem> _cartItemsClone = [];
    //       _cartItemsClone.addAll(_shoppingBagItems);
    //
    //       /* 優先以ctLineNumber排序 */
    //       _cartItemsClone.sort((a, b) {
    //         if (a.ctLineNumber != null && b.ctLineNumber != null) {
    //           return b.ctLineNumber!.compareTo(a.ctLineNumber!);
    //         } else {
    //           return b.createdDate.compareTo(a.createdDate);
    //         }
    //       });
    //
    //       if (_cartItemsClone.isNotEmpty) {
    //         /* 取得圖片路徑 */
    //         List<String> _noImageInventories = cacheProductItems
    //             ?.where((e) => e.imagesPath.isEmpty)
    //             .map((e) => e.inventoryId)
    //             .whereType<String>()
    //             .toList() ??
    //             [];
    //
    //         List<String> _noImageModels = cacheProductItems
    //             ?.where((e) => e.imagesPath.isEmpty)
    //             .map((e) => e.inventoryId != null ? null : e.modelSequenceNumber)
    //             .whereType<String>()
    //             .toList() ??
    //             [];
    //         if (_noImageInventories.isNotEmpty) {
    //           IndexPageState.prodService.setProductImagesPathByInventoryId(_noImageInventories);
    //         }
    //
    //         if (_noImageModels.isNotEmpty) {
    //           IndexPageState.prodService.setProductImagesPathByModelSequenceNumber(_noImageModels);
    //         }
    //       }
    //
    //       return Padding(
    //         padding: const EdgeInsets.only(left: SizeStyle.pagePadding),
    //         child: Stack(
    //           children: [
    //             Column(
    //               children: [
    //                 /* 標題 */
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     /* 清空購物車 */
    //                     // Padding(
    //                     //   padding: const EdgeInsets.only(top: SizeStyle.paddingUnit),
    //                     //   child: TextButton.icon(
    //                     //     style: TextButton.styleFrom(foregroundColor: ColorStyle.primary),
    //                     //     onPressed: _cartItemsClone.isEmpty
    //                     //         ? null
    //                     //         : () async {
    //                     //             bool? _isConfirmed = await showAlertWithResp(context, '確認要清空購物車?');
    //                     //             if (_isConfirmed == true) IndexPageState.cartService.clearAllCartItem();
    //                     //           },
    //                     //     icon: const Icon(Icons.cleaning_services_outlined),
    //                     //     label: const Text('清空購物車'),
    //                     //   ),
    //                     // ),
    //                     Padding(
    //                       // padding: const EdgeInsets.only(top: SizeStyle.paddingUnit * 2),
    //                       padding: const EdgeInsets.only(top: SizeStyle.paddingUnit),
    //                       child: Row(
    //                         children: [
    //                           //TODO checkbox
    //                           // if (_cartItems.isNotEmpty)
    //                           //   SizedBox(
    //                           //     height: 25,
    //                           //     width: 25,
    //                           //     child: Checkbox(
    //                           //       checkColor: Colors.white,
    //                           //       value: _cartItems.length == _isChecked.length,
    //                           //       onChanged: (_) => _handleAllItemChecked(),
    //                           //     ),
    //                           //   ),
    //                           Padding(
    //                               padding: const EdgeInsets.all(6.0),
    //                               child: Text(Translate.of(context).getLan("home.label.product"),
    //                                   style: Theme.of(context).textTheme.titleLarge)),
    //                           const Spacer(),
    //                           MyTextStatelessWidget(
    //                               text: "${Translate.of(context).getLan("cart.label.price")} (RMB ¥)",
    //                               padding: const EdgeInsets.only(right: SizeStyle.paddingUnit * 6)),
    //                         ],
    //                       ),
    //                     ),
    //                     const Divider(height: 1, color: Color.fromRGBO(102, 102, 102, 1)),
    //                   ],
    //                 ),
    //
    //                 /* 購物車商品 */
    //                 if (_cartItemsClone.isNotEmpty)
    //                   Expanded(
    //                     child: SlidableAutoCloseBehavior(
    //                       child: ListView.separated(
    //                           padding: const EdgeInsets.fromLTRB(
    //                             0,
    //                             SizeStyle.paddingUnit,
    //                             SizeStyle.paddingUnit,
    //                             SizeStyle.paddingUnit * 3,
    //                           ),
    //                           itemBuilder: (context, index) => Builder(builder: (context) {
    //                             ShoppingBagItem _cartItem = _cartItemsClone[index];
    //                             CacheProductItem? _cacheProductItem = IndexPageState.cartService
    //                                 .findCacheProductItem(_cartItem.inventoryId, _cartItem.modelSequenceNumber);
    //                             return CartItemStatelessWidget(
    //                               // isChecked: _cartItem.selectIndicator ,
    //                               index: _formatIndex(_cartItemsClone.length - index),
    //                               removeCartItem: (context) => _removeCartItem(context, _cartItem),
    //                               onCheck: (bool bl) {
    //                                 // _possProvider.addOrUpdateCartItem(_productInfo, selectIndicator: bl)
    //                               },
    //                               cacheProductItem: _cacheProductItem,
    //                               shoppingBagItem: _cartItem,
    //                               customerSession: _customerSession!.results.first,
    //                               // isPriceLoading: true,
    //                             );
    //                           }),
    //                           separatorBuilder: (_, __) => const SizedBox(height: SizeStyle.paddingUnit * 2),
    //                           itemCount: _cartItemsClone.length),
    //                     ),
    //                   ),
    //               ],
    //             ),
    //
    //             /* 助銷信息 */
    //             // if (widget.data != null && widget.data!.upsellMessages.isNotEmpty)
    //             //   SlidingUpPanel(
    //             //     slideDirection: SlideDirection.DOWN,
    //             //     controller: _pcTop,
    //             //     maxHeight: 120,
    //             //     minHeight: 20,
    //             //     defaultPanelState: PanelState.CLOSED,
    //             //     renderPanelSheet: false,
    //             //     panel: Column(
    //             //       crossAxisAlignment: CrossAxisAlignment.start,
    //             //       children: [
    //             //         Expanded(
    //             //           child: Container(
    //             //             width: _slideUpWidth,
    //             //             padding: const EdgeInsets.all(12),
    //             //             decoration: BoxDecoration(
    //             //                 color: ColorStyle.slideUpBackground,
    //             //                 borderRadius: const BorderRadius.only(
    //             //                   bottomLeft: Radius.circular(6),
    //             //                   bottomRight: Radius.circular(6),
    //             //                 )),
    //             //             child: SingleChildScrollView(
    //             //               child: Column(
    //             //                 crossAxisAlignment: CrossAxisAlignment.start,
    //             //                 children: [
    //             //                   ...["cart.label.upsellMessages".tr, ...?widget.data?.upsellMessages].map(
    //             //                     (e) => Text(
    //             //                       e,
    //             //                       style: Theme.of(context).textTheme.titleLarge?.copyWith(color: ColorStyle.white),
    //             //                     ),
    //             //                   ),
    //             //                 ],
    //             //               ),
    //             //             ),
    //             //           ),
    //             //         ),
    //             //         InkWell(
    //             //           onTap: () => _pcTop.isPanelOpen ? _pcTop.close() : _pcTop.open(),
    //             //           child: Container(
    //             //             height: 20,
    //             //             width: _slideUpWidth,
    //             //             alignment: Alignment.topCenter,
    //             //             child: Container(
    //             //                 width: 76,
    //             //                 height: 8,
    //             //                 alignment: Alignment.center,
    //             //                 decoration: BoxDecoration(
    //             //                     color: ColorStyle.slideUpBackground,
    //             //                     borderRadius: const BorderRadius.only(
    //             //                       bottomLeft: Radius.circular(6),
    //             //                       bottomRight: Radius.circular(6),
    //             //                     )),
    //             //                 child: Row(
    //             //                   crossAxisAlignment: CrossAxisAlignment.center,
    //             //                   mainAxisAlignment: MainAxisAlignment.center,
    //             //                   children: [
    //             //                     Container(width: 60, height: 2, color: ColorStyle.pageBackground),
    //             //                   ],
    //             //                 )),
    //             //           ),
    //             //         ),
    //             //       ],
    //             //     ),
    //             //   ),
    //
    //             /* 整單優惠 */
    //             // if (_cartItems.isNotEmpty)
    //             //   SlidingUpPanel(
    //             //     controller: _pcBottom,
    //             //     maxHeight: 120,
    //             //     minHeight: 28,
    //             //     defaultPanelState: PanelState.CLOSED,
    //             //     renderPanelSheet: false,
    //             //     panel: Column(
    //             //       crossAxisAlignment: CrossAxisAlignment.start,
    //             //       children: [
    //             //         /* 整單優惠^按鈕感應範圍 */
    //             //         InkWell(
    //             //           onTap: () => _pcBottom.isPanelOpen ? _pcBottom.close() : _pcBottom.open(),
    //             //           child: Container(
    //             //             width: _slideUpWidth,
    //             //             alignment: Alignment.center,
    //             //             child: Container(
    //             //                 width: 84,
    //             //                 height: 28,
    //             //                 alignment: Alignment.center,
    //             //                 decoration: BoxDecoration(
    //             //                     color: ColorStyle.slideUpBackground,
    //             //                     borderRadius: const BorderRadius.only(
    //             //                       topLeft: SizeStyle.radius,
    //             //                       topRight: SizeStyle.radius,
    //             //                     )),
    //             //                 child: Row(
    //             //                   crossAxisAlignment: CrossAxisAlignment.center,
    //             //                   mainAxisAlignment: MainAxisAlignment.center,
    //             //                   children: [
    //             //                     Text(
    //             //                       Translate.of(context).getLan("cart.label.wholeOrderDiscount"),
    //             //                       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
    //             //                             color: ColorStyle.white,
    //             //                             fontWeight: FontWeight.bold,
    //             //                           ),
    //             //                     ),
    //             //                     const Icon(Icons.expand_less, color: ColorStyle.white, size: 18),
    //             //                   ],
    //             //                 )),
    //             //           ),
    //             //         ),
    //             //
    //             //         /* 優惠內容 */
    //             //         Expanded(
    //             //           child: Container(
    //             //             width: _slideUpWidth,
    //             //             padding: const EdgeInsets.all(12),
    //             //             decoration: BoxDecoration(
    //             //                 color: ColorStyle.slideUpBackground,
    //             //                 borderRadius: const BorderRadius.only(
    //             //                   topLeft: SizeStyle.radius,
    //             //                   topRight: SizeStyle.radius,
    //             //                 )),
    //             //             child: SingleChildScrollView(
    //             //               child: Column(
    //             //                 crossAxisAlignment: CrossAxisAlignment.start,
    //             //                 children: [
    //             //                   ...getDiscountRenderList(_cartItems).map(
    //             //                     (e) => Text('${e.discountName} (${e.discountIndexList.join(',')})',
    //             //                         style:
    //             //                             Theme.of(context).textTheme.titleLarge?.copyWith(color: ColorStyle.white)),
    //             //                   ),
    //             //                 ],
    //             //               ),
    //             //             ),
    //             //           ),
    //             //         )
    //             //       ],
    //             //     ),
    //             //   ),
    //           ],
    //         ),
    //       );
    //     });
  }
}

class DiscountRenderItem {
  final String discountName;
  final List<String> discountIndexList;

  DiscountRenderItem({
    required this.discountName,
    required this.discountIndexList,
  });
}
