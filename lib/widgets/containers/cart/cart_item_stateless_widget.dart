// import 'package:collection/collection.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
//
//
// enum ModifyBtnType {
//   prepayment,
//   adjustment,
//   priceDetail,
// }
//
// class _ProductCartItemWidgetsFactoryImpl extends ProductWidgetsFactoryImpl {
//   const _ProductCartItemWidgetsFactoryImpl();
//
//   @override
//   ProductAmountWidget getInventoryAmount() => const ProductCartItemInventoryAmountWidgetImpl();
//
//   @override
//   ProductAmountWidget getNetAmount() => const ProductCartItemNetAmountWidgetImpl();
// }
//
// class CartItemStatelessWidget<T> extends StatelessWidget with CommonFunction, HandleExceptionEvent {
//   final String index;
//
//   final ValueChanged removeCartItem;
//   final ValueChanged<bool> onCheck;
//   final ShoppingBagItem shoppingBagItem;
//   final CacheProductItem? cacheProductItem;
//   final bool isDisabled;
//   final bool isPriceLoading;
//   final CustomerSession customerSession;
//
//   const CartItemStatelessWidget({
//     Key? key,
//     required this.index,
//     // required this.isChecked,
//     required this.removeCartItem,
//     required this.onCheck,
//     required this.shoppingBagItem,
//     required this.customerSession,
//     required this.cacheProductItem,
//     this.isDisabled = false,
//     this.isPriceLoading = false,
//   }) : super(key: key);
//
//   void _toggleSlide(BuildContext context) {
//     if (Slidable.of(context)?.actionPaneType.value == ActionPaneType.end) {
//       Slidable.of(context)?.close();
//     } else {
//       Slidable.of(context)?.openEndActionPane();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const ProductWidgetsFactory _factory = _ProductCartItemWidgetsFactoryImpl();
//     final TextTheme _textTheme = Theme.of(context).textTheme;
//     final Color _textBlackColor = isDisabled ? ColorStyle.disabled : ColorStyle.textColorMain;
//     //TODO:目前沒有checkbox 把default color => ColorStyle.white
//     final Color _backgroundColor = isDisabled ? ColorStyle.lightGrey2 : ColorStyle.white;
//     // final Color _backgroundColor = isDisabled
//     //     ? ColorStyle.lightGrey2
//     //     : isChecked
//     //         ? ColorStyle.selected
//     //         : ColorStyle.white;
//     // void _showPrepayDialog() => showDialog(context: context, builder: (_) => PrepaymentStatefulWidget(item: item));
//
//     // void _showAdjustDialog() => showDialog(context: context, builder: (_) => AdjustmentStatefulWidget(item: item));
//
//     /// 價格詳細dialog
//     // void _showPriceDetailDialog() => showDialog(
//     //     context: context,
//     //     builder: (_) => PriceDetailStatefulWidget(
//     //           historyItem: shoppingBagItem,
//     //           confirmFunc: (value) {},
//     //           approvalFunc: () {},
//     //         ));
//
//     final List<Map> _btnData = [
//       // {
//       //   'type': ModifyBtnType.adjustment,
//       //   'color': ColorStyle.orange,
//       //   'label': "cart.button.adjustment".tr,
//       //   'iconData': Icons.architecture,
//       //   'onPress': _showAdjustDialog,
//       //   // 'isAdjusted': [item.engravingFont, item.engravingContent, item.customizedRingSize, item.chalcedonyQuantity]
//       //   //     .any((e) => ![false, null, '', 0].contains(e)),
//       //   // 'isAble': [item.canEngraving, item.canChangeRingSize, item.canChangeChalcedonyQuantity].contains(true),
//       //   'isAdjusted': true,
//       //   'isAble': true,
//       // },
//       // {
//       //   'type': ModifyBtnType.prepayment,
//       //   'color': ColorStyle.green,
//       //   'label': "cart.button.prepayments".tr,
//       //   'iconData': Icons.payments,
//       //   'onPress': _showPrepayDialog,
//       //   'isAdjusted': true,
//       //   'isAble': true,
//       // },
//       // {
//       //   'type': ModifyBtnType.priceDetail,
//       //   'color': ColorStyle.blue,
//       //   'label': "cart.button.priceDetail".tr,
//       //   'iconData': Icons.summarize,
//       //   'onPress': _showPriceDetailDialog,
//       //   'isAdjusted': true,
//       //   'isAble': true,
//       // }
//     ];
//
//     return Slidable(
//       enabled: !isDisabled,
//       groupTag: "cartItem",
//       key: ValueKey(shoppingBagItem.ctLineNumber ?? 0),
//       endActionPane: ActionPane(
//         extentRatio: 0.45,
//         motion: const ScrollMotion(),
//         children: [
//           ..._btnData.map(
//                 (e) => SlidableAction(
//               autoClose: true,
//               onPressed: e['isAble'] ? (_) => e['onPress']() : null,
//               backgroundColor: e['isAble'] ? e['color'] : null,
//               foregroundColor: Colors.white,
//               icon: e['iconData'],
//               label: e['label'],
//               spacing: SizeStyle.paddingUnit,
//             ),
//           ),
//
//           /* 刪除商品 */
//           SlidableAction(
//             autoClose: false,
//             onPressed: removeCartItem,
//             backgroundColor: ColorStyle.red,
//             foregroundColor: Colors.white,
//             icon: Icons.delete,
//             label: "cart.button.delete".tr,
//             spacing: SizeStyle.paddingUnit,
//           ),
//         ],
//       ),
//       child: Builder(builder: (context) {
//         String _brand = cacheProductItem?.brand?.name ?? "";
//         String _collection = cacheProductItem?.collection?.name ?? '';
//         String _subCollection = cacheProductItem?.subCollection?.name ?? '';
//         String? _finalBrandCollection;
//         String? _finalCollection;
//
//         if (_brand.isNotEmpty) {
//           _finalBrandCollection = _brand;
//         } else if (_brand.isEmpty && _collection.isNotEmpty) {
//           _finalBrandCollection = _collection;
//         } else {
//           _finalBrandCollection = "-";
//         }
//
//         if (_finalBrandCollection == _collection) {
//           _finalCollection = _subCollection;
//         } else {
//           if (_collection.isNotEmpty) {
//             _finalCollection = _collection;
//           } else if (_collection.isEmpty && _subCollection.isNotEmpty) {
//             _finalCollection = _subCollection;
//           } else {
//             _finalCollection = "-";
//           }
//         }
//
//         double? inventoryAmount = shoppingBagItem.inventoryAmount;
//         double? netAmount = shoppingBagItem.netAmount;
//
//         List<String> description = [];
//         if (cacheProductItem != null && (cacheProductItem!.fixedPriceIndicator ?? true)) {
//           /* 定價商品 */
//           description = [
//             // /* 金重 */
//             // cacheProductItem?.bookingUnitInfo?.physicalWeightGram != null
//             //     ? "${"product.widgets.factory.goldWeight".tr}:${cacheProductItem?.bookingUnitInfo?.physicalWeightGram}${"cart.label.gram".tr}"
//             //     : "",
//             /* 重量 */
//             cacheProductItem?.bookingUnitInfo?.caratWeight != null
//                 ? "${"product.widgets.factory.caratWeight".tr}:${cacheProductItem?.bookingUnitInfo?.caratWeight.toString()}"
//                 : "",
//             /* 顏色 */
//             cacheProductItem?.bookingUnitInfo?.color != null
//                 ? "${"product.widgets.factory.color".tr}:${cacheProductItem?.bookingUnitInfo?.color}"
//                 : "",
//             /* 淨度 */
//             cacheProductItem?.bookingUnitInfo?.clarity != null
//                 ? "${"product.widgets.factory.clarity".tr}:${cacheProductItem?.bookingUnitInfo?.clarity}"
//                 : "",
//             /* 切工 */
//             cacheProductItem?.bookingUnitInfo?.cutGrade != null
//                 ? "${"product.widgets.factory.cutGrade".tr}:${cacheProductItem?.bookingUnitInfo?.cutGrade}"
//                 : "",
//             /* 圈號/長度 */
//             cacheProductItem?.bookingUnitInfo?.sizeAndLength != null
//                 ? cacheProductItem?.bookingUnitInfo?.sizeAndLength ?? ""
//                 : "",
//             /* 貨重 */
//             cacheProductItem?.bookingUnitInfo?.grossWeightGram != null
//                 ? "${"product.widgets.factory.physicalWeight".tr}:${cacheProductItem?.bookingUnitInfo?.grossWeightGram}"
//                 : "",
//           ];
//         } else if (cacheProductItem != null && !(cacheProductItem!.fixedPriceIndicator ?? true)) {
//           /* 計價 */
//           /* 賣出金價 */
//           description = [
//             /* 金重 */
//             cacheProductItem?.bookingUnitInfo?.physicalWeightGram != null
//                 ? "${"product.widgets.factory.goldWeight".tr}:${cacheProductItem?.bookingUnitInfo?.physicalWeightGram}${"cart.label.gram".tr}"
//                 : "",
//             /* 賣出金價 */
//             cacheProductItem?.goldPrice != null
//                 ? "${"product.widgets.factory.saleGoldWeight".tr}¥${cacheProductItem?.goldPrice}"
//                 : "",
//             /* 工費 */
//             cacheProductItem?.bookingUnitInfo?.laborCost != null
//                 ? "${"product.widgets.factory.laborCost".tr}RMB¥${cacheProductItem?.bookingUnitInfo?.laborCost}"
//                 : "",
//             /* 圈號/長度 */
//             cacheProductItem?.bookingUnitInfo?.sizeAndLength != null
//                 ? cacheProductItem?.bookingUnitInfo?.sizeAndLength ?? ""
//                 : "",
//             /* 貨重 */
//             cacheProductItem?.bookingUnitInfo?.grossWeightGram != null
//                 ? "${"product.widgets.factory.physicalWeight".tr}:${cacheProductItem?.bookingUnitInfo?.grossWeightGram}${"cart.label.gram".tr}"
//                 : "",
//           ];
//         }
//
//         return Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             /* number of product */
//             MyTextStatelessWidget(
//               text: index,
//               style: _textTheme.titleLarge?.copyWith(color: _textBlackColor),
//               padding: const EdgeInsets.symmetric(horizontal: SizeStyle.paddingUnit),
//             ),
//
//             /* product detail block */
//             Expanded(
//               child: Stack(
//                 fit: StackFit.loose,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(SizeStyle.paddingUnit),
//                     alignment: Alignment.topLeft,
//                     decoration: BoxDecoration(
//                         color: _backgroundColor,
//                         boxShadow: const [BoxShadow(color: ColorStyle.boxShadow, blurRadius: 4, offset: Offset(0, 4))],
//                         borderRadius: SizeStyle.borderRadius),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         /* 圖片 & tag */
//                         Container(
//                           margin: const EdgeInsets.only(right: SizeStyle.paddingUnit * 2),
//                           clipBehavior: Clip.hardEdge,
//                           decoration: const BoxDecoration(
//                             borderRadius: BorderRadius.vertical(bottom: SizeStyle.radius),
//                           ),
//                           child: Column(
//                             children: [
//                               NetworkImageStatelessWidget(url: cacheProductItem?.imagesPath.firstOrNull ?? ''),
//                               /* 本店, 後備倉 */
//                               Container(
//                                 width: 70,
//                                 height: 20,
//                                 decoration: BoxDecoration(
//                                     color: cacheProductItem?.saleType == SaleType.inStore.value
//                                         ? ColorStyle.primary
//                                         : ColorStyle.white,
//                                     border: Border.all(width: 1, color: ColorStyle.primary),
//                                     borderRadius: const BorderRadius.vertical(bottom: SizeStyle.radius)),
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   cacheProductItem?.saleType == SaleType.inStore.value
//                                       ? "cart.label.store".tr
//                                       : "cart.label.remote".tr,
//                                   style: TextStyle(
//                                     color: cacheProductItem?.saleType == SaleType.inStore.value
//                                         ? ColorStyle.white
//                                         : ColorStyle.primary,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//
//                         /* 左方商品內容 */
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   /* 商品內容 */
//                                   Expanded(
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         children: [
//                                           /* title */
//                                           Padding(
//                                             padding: const EdgeInsets.only(bottom: SizeStyle.paddingUnit * 0.5),
//                                             child: Wrap(
//                                               crossAxisAlignment: WrapCrossAlignment.end,
//                                               direction: Axis.horizontal,
//                                               children: [
//                                                 /* 貨品名稱 */
//                                                 _factory.getProductName().render(context, cacheProductItem?.productName,
//                                                     valueStyle: _textTheme.headlineSmall),
//                                                 /* 品牌 */
//                                                 _factory.getBrand().render(context, _finalBrandCollection,
//                                                     valueStyle: _textTheme.headlineSmall),
//                                                 /* 系列＆副系列 */
//                                                 _factory.getCollection().render(context, _finalCollection,
//                                                     valueStyle: _textTheme.headlineSmall),
//                                                 /* catalogItem number */
//                                                 _factory.getCatalogItem().render(context, cacheProductItem?.catalogItemCode,
//                                                     valueStyle: _textTheme.headlineSmall),
//                                               ],
//                                             ),
//                                           ),
//
//                                           /* detail info */
//                                           // description
//                                           Row(
//                                             children: [
//                                               if (cacheProductItem?.itemNumber != null)
//                                                 _factory.getItemNumber().render(context, cacheProductItem?.itemNumber,
//                                                     padding: const EdgeInsets.only(right: 0),
//                                                     valueStyle: _textTheme.titleLarge?.copyWith(color: ColorStyle.primary)),
//                                               Expanded(
//                                                 child: MyTextStatelessWidget(
//                                                     text: description.where((e) => e.isNotEmpty).join(" "),
//                                                     padding: description.isEmpty
//                                                         ? const EdgeInsets.all(0)
//                                                         : const EdgeInsets.all(SizeStyle.paddingUnit),
//                                                     style: _textTheme.titleLarge),
//                                               ),
//                                             ],
//                                           )
//                                           // if (cacheProductItem != null && (cacheProductItem!.fixedPriceIndicator ?? true))
//                                           //   Padding(
//                                           //     padding: const EdgeInsets.only(bottom: SizeStyle.paddingUnit * 0.5),
//                                           //     child: Wrap(
//                                           //       crossAxisAlignment: WrapCrossAlignment.end,
//                                           //       direction: Axis.horizontal,
//                                           //       children: [
//                                           //         /* inventory itemNumber */
//                                           //         _factory.getItemNumber().render(
//                                           //             context, cacheProductItem?.itemNumber ?? "",
//                                           //             valueStyle:
//                                           //                 _textTheme.bodyLarge?.copyWith(color: ColorStyle.primary)),
//                                           //         /* 金重 */
//                                           //         _factory.getPhysicalWeight().render(
//                                           //             context,
//                                           //             cacheProductItem?.bookingUnitInfo?.physicalWeightGram.toString() ??
//                                           //                 "",
//                                           //             label: "product.widgets.factory.goldWeight".tr,
//                                           //             valueStyle: _textTheme.bodyLarge),
//                                           //
//                                           //         /* 重量 */
//                                           //         _factory.getBomCaratWeight().render(
//                                           //             context,
//                                           //             cacheProductItem?.bookingUnitInfo?.caratWeight != null
//                                           //                 ? cacheProductItem?.bookingUnitInfo?.caratWeight.toString()
//                                           //                 : "",
//                                           //             label: "product.widgets.factory.caratWeight".tr),
//                                           //         /* 顏色 */
//                                           //         _factory.getBomDiamondColor().render(
//                                           //             context, cacheProductItem?.bookingUnitInfo?.color,
//                                           //             label: "product.widgets.factory.color".tr),
//                                           //         /* 淨度 */
//                                           //         _factory.getBomDiamondClarity().render(
//                                           //             context, cacheProductItem?.bookingUnitInfo?.clarity,
//                                           //             label: "product.widgets.factory.clarity".tr),
//                                           //         /* 切工 */
//                                           //         _factory.getBomDiamondCutGrade().render(
//                                           //             context, cacheProductItem?.bookingUnitInfo?.cutGrade,
//                                           //             label: "product.widgets.factory.cutGrade".tr),
//                                           //         /* 4C */
//                                           //         // _factory
//                                           //         //     .getBom()
//                                           //         //     .render(context, productInfo, valueStyle: _textTheme.bodyLarge),
//                                           //         /* 圈號/長度 */
//                                           //         // _factory
//                                           //         //     .getUsage()
//                                           //         //     .render(context, productInfo, valueStyle: _textTheme.bodyLarge),
//                                           //       ],
//                                           //     ),
//                                           //   ),
//                                           // if (cacheProductItem != null && !(cacheProductItem!.fixedPriceIndicator ?? true))
//                                           //   Padding(
//                                           //     padding: const EdgeInsets.only(bottom: SizeStyle.paddingUnit * 0.5),
//                                           //     child: Wrap(
//                                           //       crossAxisAlignment: WrapCrossAlignment.end,
//                                           //       direction: Axis.horizontal,
//                                           //       children: [
//                                           //         MyTextStatelessWidget(
//                                           //             text: "${"cart.label.brandPrice".tr}:",
//                                           //             padding: const EdgeInsets.only(right: SizeStyle.paddingUnit),
//                                           //             style: _textTheme.titleLarge),
//                                           //         /* 金重 */
//                                           //         if (cacheProductItem?.bookingUnitInfo?.grossWeightGram != null)
//                                           //           _factory.getPhysicalWeight().render(context,
//                                           //               "${cacheProductItem?.bookingUnitInfo?.physicalWeightGram.toString()}${"cart.label.gram".tr}",
//                                           //               label: "product.widgets.factory.goldWeight".tr),
//                                           //         /* 賣出金價 */
//                                           //         if (cacheProductItem?.goldPrice != null)
//                                           //           _factory.getLaborCost().render(
//                                           //               context, "¥${cacheProductItem?.goldPrice}",
//                                           //               label: "product.widgets.factory.saleGoldWeight".tr),
//                                           //         /* 工費 */
//                                           //         _factory.getLaborCost().render(
//                                           //             context, cacheProductItem?.bookingUnitInfo?.laborCost.toString(),
//                                           //             label: "${"product.widgets.factory.laborCost".tr}¥"),
//                                           //       ],
//                                           //     ),
//                                           //   ),
//                                         ],
//                                       )),
//
//                                   /* 價格區塊 */
//                                   SizedBox(
//                                       width: 180,
//                                       child: Padding(
//                                         padding: const EdgeInsets.only(
//                                           right: SizeStyle.paddingUnit * 4,
//                                           left: SizeStyle.paddingUnit,
//                                         ),
//                                         child: Column(
//                                           mainAxisAlignment: MainAxisAlignment.start,
//                                           children: [
//                                             /* 貨牌價 */
//                                             Padding(
//                                               padding: const EdgeInsets.only(bottom: SizeStyle.paddingUnit * 0.5),
//                                               child: Row(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 children: [
//                                                   Text("cart.label.brandPrice".tr,
//                                                       style: _textTheme.titleMedium?.copyWith(color: ColorStyle.grey)),
//                                                   Expanded(
//                                                       child: _factory.getInventoryAmount().render(
//                                                           context, inventoryAmount,
//                                                           decoration: inventoryAmount != null &&
//                                                               netAmount != null &&
//                                                               (inventoryAmount > netAmount)
//                                                               ? TextDecoration.lineThrough
//                                                               : TextDecoration.none)),
//                                                 ],
//                                               ),
//                                             ),
//
//                                             /* 約定售價 */
//                                             Row(
//                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                               children: [
//                                                 Text("cart.label.totalAgreedPrice".tr,
//                                                     style: _textTheme.titleMedium?.copyWith(color: ColorStyle.grey)),
//                                                 Expanded(
//                                                     child: _factory.getNetAmount().render(context, netAmount,
//                                                         labelStyle: _textTheme.titleMedium,
//                                                         valueStyle: _textTheme.headlineMedium))
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       )),
//                                 ],
//                               ),
//
//                               /* 選擇優惠 */
//                               if (cacheProductItem != null && cacheProductItem!.discounts.isNotEmpty)
//                                 Container(
//                                   width: 170,
//                                   margin: const EdgeInsets.only(top: SizeStyle.paddingUnit),
//                                   child: MyDropdownButtonStatelessWidget<ProductDiscount>(
//                                       hintTextCode: "cart.label.selectDiscount".tr,
//                                       items: cacheProductItem?.discounts
//                                           .map<DropdownMenuItem<ProductDiscount>>((ProductDiscount e) =>
//                                           DropdownMenuItem<ProductDiscount>(
//                                               value: e, child: Text(e.discountName)))
//                                           .toList() ??
//                                           [],
//                                       dropdownValue: cacheProductItem?.discounts.firstWhereOrNull(
//                                               (e) => e.projectLineId == shoppingBagItem.selectedDiscountProjectLineId),
//                                       onChanged: (ProductDiscount? value) {
//                                         if (value != null) {
//                                           IndexPageState.cartService.updateCartItemDiscount(shoppingBagItem, value);
//                                         }
//                                       }),
//                                 ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//
//                   /* 右方...按鈕(slide event) */
//                   Positioned(
//                       right: 0,
//                       top: 0,
//                       child: IconButton(
//                         onPressed: isDisabled ? null : () => _toggleSlide(context),
//                         icon: Icon(Icons.more_vert, color: _textBlackColor),
//                       )),
//                 ],
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
