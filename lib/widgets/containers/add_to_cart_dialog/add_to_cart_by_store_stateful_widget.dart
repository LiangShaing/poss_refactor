import 'dart:io';

import 'package:chowsangsang_enterprise_portal/service_factory.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deep_link/flutter_deep_link.dart';
import 'package:mobile_poss_gp01/blocs/product_amount_bloc.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/product_amount.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/product_info.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/store_product.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/inventory.dart';
import 'package:mobile_poss_gp01/events/product_amount_event.dart';
import 'package:mobile_poss_gp01/extension/string_extension.dart';
import 'package:mobile_poss_gp01/mixins/common_function.dart';
import 'package:mobile_poss_gp01/mixins/exception/handle_exception_event.dart';
import 'package:mobile_poss_gp01/repositories/authentication_repository.dart';
import 'package:mobile_poss_gp01/repositories/customer_session_repository.dart';
import 'package:mobile_poss_gp01/repositories/product_repository.dart';
import 'package:mobile_poss_gp01/resources/color_style.dart';
import 'package:mobile_poss_gp01/resources/size_style.dart';
import 'package:mobile_poss_gp01/routes/my_navigator.dart';
import 'package:mobile_poss_gp01/states/product_amount_state.dart';
import 'package:mobile_poss_gp01/util/handle_price/handle_price.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';
import 'package:mobile_poss_gp01/widgets/components/discount_tag_stateless_widget.dart';
import 'package:mobile_poss_gp01/widgets/components/my_alert_dialog_stateless_widget.dart';
import 'package:mobile_poss_gp01/widgets/components/my_text_shimmer_stateless_widget.dart';
import 'package:mobile_poss_gp01/widgets/components/my_text_stateless_widget.dart';
import 'package:shimmer/shimmer.dart';

/// 價格詳細 dialog
class AddToCartByStoreStatefulWidget extends StatefulWidget {
  final ProductInfo productInfo;

  const AddToCartByStoreStatefulWidget({
    Key? key,
    required this.productInfo,
  }) : super(key: key);

  @override
  State<AddToCartByStoreStatefulWidget> createState() => _AddToCartByStoreStatefulWidgetState();
}

class _AddToCartByStoreStatefulWidgetState extends State<AddToCartByStoreStatefulWidget>
    with CommonFunction, HandleExceptionEvent, SingleTickerProviderStateMixin {


  late final TextTheme _textTheme = Theme.of(context).textTheme;
  late bool _isAddToCartLoading = false;
  late bool _isProductStockLoading = false;

  late bool _isInCart = false;

  @override
  void initState() {
    super.initState();
    Logger.screen("AddToCartByStoreStatefulWidget");
    // /* 搜尋本店商品只要帶inventoryId */
    // _isInCart = IndexPageState.cartService.isInShoppingBag(widget.storeProductInfo.inventory?.inventoryId, null);
  }

  @override
  void dispose() {
    super.dispose();
    Logger.screen("dispose AddToCartByStoreStatefulWidget");
  }

  void _submitAddToCart() async {
    // setState(() => _isAddToCartLoading = true);
    // try {
    //   await IndexPageState.cartService.addToCartItem(AddToCartPOJO(
    //     isInventoryItem: true,
    //     productAmountPOJO: _productAmountPOJO!,
    //     productInfoRes: widget.storeProductInfo,
    //   ));
    //   showSuccessSnackBar(context, '${"product.widgets.factory.addToCartSuccessful".tr}!');
    //
    //   Navigator.of(context).pop(true);
    //   showDialog(
    //       barrierColor: Colors.transparent,
    //       barrierDismissible: false,
    //       context: context,
    //       builder: (context) => const AnimationDialog());
    // } catch (e) {
    //   if (e.runtimeType == BadRequestException) {
    //     Logger.error(message: e.toString());
    //     showErrorSnackBar(context, '${"product.widgets.factory.addToCartUnSuccessful".tr}! ${e.toString()}');
    //   } else {
    //     handleException(e, context, eventName: "AddToCartStatelessWidget postEarmark");
    //   }
    // }
    // setState(() => _isAddToCartLoading = false);
  }

  Widget certificateWidget(String text, String? path) {
    return Padding(
      padding: const EdgeInsets.only(right: SizeStyle.pagePadding * 0.5),
      child: InkWell(
          onTap: path != null
              ? () {
                  Platform.isAndroid
                      ? FlutterDeepLink.openBrowser(url: path)
                      : FlutterDeepLink.openSafariService(url: path);
                }
              : null,
          child: Text(
            text,
            style: _textTheme.titleLarge?.copyWith(color: path != null ? ColorStyle.lightBlue2 : ColorStyle.black),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> certificateList = [];
    for (ProductBom bom in widget.productInfo.bookingUnit?.bom ?? []) {
      certificateList.addAll(bom.bomCertificates.map((e) {
        String physicalCert =
            "(${e.certificateOrganization}${e.physicalCertificateIndicator == "Y" ? ' ${"product.label.physicalCert".tr}' : ''})";
        String number = "${e.certificateNumber}$physicalCert";
        String? path = e.certificateOrganization == 'GIA' ? e.reportPdfPath : e.digitalCardPath;
        return certificateWidget(number, path);
      }).toList());
    }

    return BlocProvider<ProductAmountBloc>(
        create: (BuildContext context) => ProductAmountBloc(
            productRepository: ProductRepository(),
            authenticationRepository: AuthenticationRepository(),
            customerSessionRepository: CustomerSessionRepository())
          ..add(ProductAmountFetched(productInfo: widget.productInfo)),
        child: BlocListener<ProductAmountBloc, ProductAmountState>(
            listener: (context, state) {
              if (state is ProductAmountLoadFailure) {
                handleException(state.exception, context,
                    eventName: "AddToCartByStoreStatefulWidget getStoreProductAmount error",
                    callBack: () => {
                          if (MyNavigator.canPop()) {MyNavigator.pop(false)}
                        });
              }
            },
            child: MyAlertDialogStatelessWidget(
              title: "widget.addToCart.title".tr,
              body: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: SizeStyle.paddingUnit),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /* 貨品名稱 */
                          MyTextStatelessWidget(text: widget.productInfo.productName, style: _textTheme.titleLarge),
                          /* 品牌 */
                          if (widget.productInfo.finalBrandCollection != null)
                            MyTextStatelessWidget(
                                text: widget.productInfo.finalBrandCollection, style: _textTheme.titleLarge),
                          /* 系列＆副系列 */
                          if (widget.productInfo.finalCollection != null)
                            MyTextStatelessWidget(
                                text: widget.productInfo.finalCollection, style: _textTheme.titleLarge),
                          /* catalogItem number */
                          MyTextStatelessWidget(text: widget.productInfo.catalogItemCode, style: _textTheme.titleLarge),
                          /* inventory itemNumber */
                          MyTextStatelessWidget(
                              text: widget.productInfo.itemNumber,
                              style: _textTheme.titleLarge?.copyWith(color: ColorStyle.primary)),
                          /* productDescription */
                          /* 定價 */
                          if (widget.productInfo.fixedPriceIndicator) ...[
                            if (widget.productInfo.bookingUnit != null &&
                                widget.productInfo.bookingUnit!.bom.isNotEmpty) ...[
                              ...widget.productInfo.bookingUnit!.bom.map(
                                (e) => Wrap(
                                  children: [
                                    /* 重量 */
                                    if (e.caratWeight != null)
                                      MyTextStatelessWidget(
                                          text: "${"product.widgets.factory.caratWeight".tr}${e.caratWeight}",
                                          style: _textTheme.titleLarge,
                                          padding: const EdgeInsets.symmetric(horizontal: SizeStyle.paddingUnit * 0.2)),
                                    /* 顏色 */
                                    if (e.color != null)
                                      MyTextStatelessWidget(
                                          text: "${"product.widgets.factory.color".tr}${e.color}",
                                          style: _textTheme.titleLarge,
                                          padding: const EdgeInsets.symmetric(horizontal: SizeStyle.paddingUnit * 0.2)),
                                    /* 淨度 */
                                    if (e.clarity != null)
                                      MyTextStatelessWidget(
                                          text: "${"product.widgets.factory.clarity".tr}${e.clarity}",
                                          style: _textTheme.titleLarge,
                                          padding: const EdgeInsets.symmetric(horizontal: SizeStyle.paddingUnit * 0.2)),

                                    /* 切工 */
                                    if (e.cutGrade != null)
                                      MyTextStatelessWidget(
                                          text: "${"product.widgets.factory.cutGrade".tr}${e.cutGrade}",
                                          style: _textTheme.titleLarge),
                                  ],
                                ),
                              )
                            ]
                          ],

                          /* 計價 */
                          if (!widget.productInfo.fixedPriceIndicator) ...[
                            Wrap(
                              direction: Axis.horizontal,
                              crossAxisAlignment: WrapCrossAlignment.end,
                              children: [
                                MyTextStatelessWidget(
                                    text: "${"cart.label.brandPrice".tr}:",
                                    padding: const EdgeInsets.only(right: SizeStyle.paddingUnit),
                                    style: _textTheme.titleLarge),
                                /* 金重 */
                                if ((widget.productInfo.bookingUnit?.physicalWeightGram?.toString() ?? "").isNotEmpty)
                                  MyTextStatelessWidget(
                                      text:
                                          "${"product.widgets.factory.goldWeight".tr}${widget.productInfo.bookingUnit?.physicalWeightGram}${"cart.label.gram".tr}",
                                      style: _textTheme.titleLarge,
                                      padding: const EdgeInsets.symmetric(horizontal: SizeStyle.paddingUnit * 0.2)),

                                /* 賣出金價 */
                                BlocBuilder<ProductAmountBloc, ProductAmountState>(builder: (context, state) {
                                  if (state is ProductAmountLoadSuccess) {
                                    return MyTextStatelessWidget(
                                        text:
                                            "${"product.widgets.factory.saleGoldWeight".tr}¥${state.productAmount?.goldPrice}",
                                        style: _textTheme.titleLarge,
                                        padding: const EdgeInsets.symmetric(horizontal: SizeStyle.paddingUnit * 0.2));
                                  }
                                  return const Text("");
                                }),

                                /* 工費 取inventory price */
                                if ((widget.productInfo.bookingUnit?.laborCost?.toString() ?? "").isNotEmpty)
                                  MyTextStatelessWidget(
                                      text:
                                          "${"product.widgets.factory.laborCost".tr}RMB¥${widget.productInfo.bookingUnit?.laborCost}",
                                      style: _textTheme.titleLarge,
                                      padding: const EdgeInsets.symmetric(horizontal: SizeStyle.paddingUnit * 0.2))
                              ],
                            ),
                          ],
                          /* 圈號/長度 */
                          if (widget.productInfo.bookingUnit != null &&
                              (widget.productInfo.bookingUnit!.size ?? "").isNotEmpty)
                            MyTextStatelessWidget(
                                text: widget.productInfo.bookingUnit!.size, style: _textTheme.titleLarge),

                          /* 證書 */
                          if (certificateList.isNotEmpty)
                            Wrap(
                              children: [
                                MyTextStatelessWidget(
                                    text: "${"product.label.certificateNo".tr}:", style: _textTheme.titleLarge),
                                Wrap(children: [...certificateList]),
                              ],
                            ),

                          /* 貨重 */
                          if (widget.productInfo.bookingUnit?.grossWeightGram != null)
                            MyTextStatelessWidget(
                                text:
                                    "${"product.widgets.factory.grossWeightGram".tr}${widget.productInfo.bookingUnit?.grossWeightGram}${"cart.label.gram".tr}",
                                style: _textTheme.titleLarge),

                          /* 重量下限 */
                          if (widget.productInfo.bookingUnit?.physicalWeightLowerBound != null)
                            MyTextStatelessWidget(
                                text:
                                    "${"product.widgets.factory.standardSpecificationPhysicalWeight".tr}${widget.productInfo.bookingUnit?.physicalWeightLowerBound}${"cart.label.gram".tr}",
                                style: _textTheme.titleLarge),
                        ],
                      ),
                    ),
                  ),
                  /* 價格 */
                  BlocBuilder<ProductAmountBloc, ProductAmountState>(builder: (context, state) {
                    return SizedBox(
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (state is ProductAmountLoadInProgress) ...[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: SizeStyle.paddingUnit * 0.5),
                                    child: Shimmer.fromColors(
                                      baseColor: ColorStyle.shimmerBaseColor,
                                      highlightColor: ColorStyle.shimmerHighlightColor,
                                      child: Container(
                                        width: 100,
                                        color: ColorStyle.white,
                                        child: Text('', style: _textTheme.displaySmall),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: SizeStyle.paddingUnit * 0.5),
                                    child: Shimmer.fromColors(
                                      baseColor: ColorStyle.shimmerBaseColor,
                                      highlightColor: ColorStyle.shimmerHighlightColor,
                                      child: Container(
                                        width: 100,
                                        color: ColorStyle.white,
                                        child: Text('', style: _textTheme.displaySmall),
                                      ),
                                    ),
                                  )
                                ],
                                if (state is ProductAmountLoadSuccess) ...[
                                  /* 優惠 label */
                                  if ((state.productAmount?.selectedDiscount?.discountName ?? "").isNotEmpty)
                                    DiscountTagStatelessWidget(
                                        discountName: state.productAmount?.selectedDiscount?.discountName),
                                  /* 貨牌價 */
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const MyTextStatelessWidget(
                                          text: "RMB¥",
                                          padding: EdgeInsets.only(right: SizeStyle.paddingUnit),
                                          style: TextStyle(color: ColorStyle.grey)),
                                      MyTextStatelessWidget(
                                          text: HandlePrice.formatPrice(state.productAmount?.inventoryAmount ?? 0),
                                          style: TextStyle(
                                              decoration: state.productAmount?.inventoryAmount != null &&
                                                      state.productAmount?.netAmount != null &&
                                                      (state.productAmount!.inventoryAmount! >
                                                          state.productAmount!.netAmount!)
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                              color: ColorStyle.grey)),
                                    ],
                                  ),
                                  /* 約定售價 */
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const MyTextStatelessWidget(
                                          text: "RMB¥",
                                          padding: EdgeInsets.only(right: SizeStyle.paddingUnit),
                                          style: TextStyle(color: ColorStyle.grey)),
                                      MyTextStatelessWidget(
                                        text: HandlePrice.formatPrice(state.productAmount?.netAmount ?? 0),
                                        style: _textTheme.displaySmall,
                                      ),
                                    ],
                                  )
                                ]
                              ])
                        ],
                      ),
                    );
                  }),
                ],
              ),
              bottomWidget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(minimumSize: SizeStyle.dialogButtonSize),
                    child: Text('widget.button.cancel'.tr),
                  ),
                  // Row(
                  //   children: [
                  //     if (widget.storeProductInfo.earmark != null && widget.storeProductInfo.earmark?.quantity != 0 ||
                  //         widget.storeProductInfo.storeCatalogItems.isNotEmpty)
                  //       Padding(
                  //         padding: const EdgeInsets.only(right: SizeStyle.pagePadding),
                  //         child: OutlinedButton.icon(
                  //           onPressed: _isProductStockLoading
                  //               ? null
                  //               : () async {
                  //             try {
                  //               setState(() => _isProductStockLoading = true);
                  //               PossProductO2ORes? possProductO2ORes;
                  //
                  //               if (widget.storeProductInfo.earmark != null &&
                  //                   widget.storeProductInfo.earmark?.quantity != 0) {
                  //                 possProductO2ORes = await IndexPageState.prodService.searchO2O(
                  //                     referenceInventoryId: widget.storeProductInfo.inventory?.inventoryId);
                  //               }
                  //               setState(() => _isProductStockLoading = false);
                  //               Navigator.of(context).pop();
                  //               showMyDialogWithScaffold(
                  //                 context: context,
                  //                 barrierDismissible: false,
                  //                 body: ProductStockStatefulWidget(
                  //                     productInfoRes: widget.storeProductInfo,
                  //                     possProductO2ORes: possProductO2ORes,
                  //                     storeProductAmountPOJO: _productAmountPOJO),
                  //               );
                  //             } catch (e) {
                  //               setState(() => _isProductStockLoading = false);
                  //               handleException(e, context,
                  //                   eventName: "AddToCartByStoreStatefulWidget searchO2O failed");
                  //             }
                  //           },
                  //           label: Text("widget.addToCart.button.inventoryList".tr),
                  //           style: OutlinedButton.styleFrom(
                  //             minimumSize: SizeStyle.dialogButtonSize,
                  //           ),
                  //           icon: _isProductStockLoading
                  //               ? Container(
                  //             width: 24,
                  //             height: 24,
                  //             padding: const EdgeInsets.all(2.0),
                  //             child: const CircularProgressIndicator(
                  //               color: ColorStyle.lightGrey1,
                  //               strokeWidth: 3,
                  //             ),
                  //           )
                  //               : const Icon(Icons.list),
                  //         ),
                  //       ),
                  //     ElevatedButton(
                  //       onPressed: !_isAddToCartLoading &&
                  //           !_isInCart &&
                  //           _inventoryAmount != null &&
                  //           _netAmount != null &&
                  //           widget.storeProductInfo.inventory?.inventoryStatus == null
                  //           ? _submitAddToCart
                  //           : null,
                  //       child: _isAddToCartLoading
                  //           ? Container(
                  //         width: 24,
                  //         height: 24,
                  //         padding: const EdgeInsets.all(2.0),
                  //         child: const CircularProgressIndicator(
                  //           color: Colors.white,
                  //           strokeWidth: 3,
                  //         ),
                  //       )
                  //           : Text(
                  //           _isInCart
                  //               ? "widget.addToCart.button.alreadyAddToCart".tr
                  //               : (_inventoryAmount != null && _netAmount != null)
                  //               ? widget.storeProductInfo.inventory?.inventoryStatus == null
                  //               ? "widget.addToCart.button.addToCart".tr
                  //               : "widget.addToCart.button.outOfStockItem".tr
                  //               : "widget.addToCart.button.noPriceInformation".tr,
                  //           style: _textTheme.titleLarge?.copyWith(color: ColorStyle.white)),
                  //       style: ElevatedButton.styleFrom(minimumSize: SizeStyle.dialogButtonSize),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            )));

  }
}
