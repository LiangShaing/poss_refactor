import 'dart:io';

import 'package:chowsangsang_enterprise_portal/service_factory.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deep_link/flutter_deep_link.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/product_info.dart';
import 'package:mobile_poss_gp01/database_objects/product/pojo/store_product.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/inventory.dart';
import 'package:mobile_poss_gp01/extension/string_extension.dart';
import 'package:mobile_poss_gp01/mixins/common_function.dart';
import 'package:mobile_poss_gp01/resources/color_style.dart';
import 'package:mobile_poss_gp01/resources/size_style.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';
import 'package:mobile_poss_gp01/widgets/components/my_alert_dialog_stateless_widget.dart';
import 'package:mobile_poss_gp01/widgets/components/my_text_shimmer_stateless_widget.dart';
import 'package:mobile_poss_gp01/widgets/components/my_text_stateless_widget.dart';

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
    with CommonFunction, SingleTickerProviderStateMixin {
  bool selected = false;

  /* 貨品名稱 */
  // late final List<String> _productNames = [
  //   widget.storeProduct.catalogItem?.goldType?.zhCN ?? "",
  //   widget.storeProduct.catalogItem?.materialCategory?.zhCN ?? "",
  //   widget.storeProduct.catalogItem?.usage?.zhCN ?? ""
  // ];

  // late final String _brand = widget.storeProduct.catalogItem!.brand?.zhCN ?? '';
  // late final String _collection = widget.storeProduct.catalogItem!.collection?.zhCN ?? '';
  // late final String _subCollection = widget.storeProduct.catalogItem!.subCollection?.zhCN ?? '';

  late final TextTheme _textTheme = Theme.of(context).textTheme;
  late bool _isAddToCartLoading = false;
  late bool _isProductStockLoading = false;

  // late Future<ProductAmountPOJO> _futureAmount;
  // late ProductAmountPOJO? _productAmountPOJO;
  late bool _isInCart = false;

  @override
  void initState() {
    super.initState();
    Logger.screen("AddToCartByStoreStatefulWidget");
    // _futureAmount = IndexPageState.prodService.getStoreProductAmount(widget.storeProductInfo);
    // /* 搜尋本店商品只要帶inventoryId */
    // _isInCart = IndexPageState.cartService.isInShoppingBag(widget.storeProductInfo.inventory?.inventoryId, null);
    // _productAmountPOJO = null;
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
    return MyAlertDialogStatelessWidget(
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
                    MyTextStatelessWidget(text: widget.productInfo.finalBrandCollection, style: _textTheme.titleLarge),
                  /* 系列＆副系列 */
                  if (widget.productInfo.finalCollection != null)
                    MyTextStatelessWidget(text: widget.productInfo.finalCollection, style: _textTheme.titleLarge),
                  /* catalogItem number */
                  MyTextStatelessWidget(text: widget.productInfo.catalogItemCode, style: _textTheme.titleLarge),
                  /* inventory itemNumber */
                  MyTextStatelessWidget(
                      text: widget.productInfo.itemNumber,
                      style: _textTheme.titleLarge?.copyWith(color: ColorStyle.primary)),
                  /* productDescription */
                  /* 定價 */
                  if (widget.productInfo.fixedPriceIndicator) ...[
                    if (widget.productInfo.bookingUnit != null && widget.productInfo.bookingUnit!.bom.isNotEmpty) ...[
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
                                  style: _textTheme.titleLarge,
                                  padding: const EdgeInsets.symmetric(horizontal: SizeStyle.paddingUnit * 0.2)),
                          ],
                        ),
                      )
                    ]
                  ],

                  // /* 計價 */
                  // if (widget.storeProductInfo.model != null &&
                  //     !widget.storeProductInfo.model!.fixedPriceIndicator) ...[
                  //   Wrap(
                  //     direction: Axis.horizontal,
                  //     crossAxisAlignment: WrapCrossAlignment.end,
                  //     children: [
                  //       MyTextStatelessWidget(text: "${"cart.label.brandPrice".tr}:",
                  //           padding: const EdgeInsets.only(right: SizeStyle.paddingUnit),
                  //           style: _textTheme.titleLarge),
                  //       /* 金重 */
                  //       if ((widget.storeProductInfo.inventory?.physicalWeight?.gram.toString() ?? "").isNotEmpty)
                  //         _factory.getPhysicalWeight().render(context,
                  //             "${widget.storeProductInfo.inventory?.physicalWeight?.gram.toString()}${"cart.label.gram".tr}",
                  //             label: "product.widgets.factory.goldWeight".tr),
                  //       /* 賣出金價 */
                  //       if ((_productAmountPOJO?.goldPrice.toString() ?? "").isNotEmpty)
                  //         _factory.getGoldPrice().render(context, "¥${_productAmountPOJO?.goldPrice.toString()}",
                  //             label: "product.widgets.factory.saleGoldWeight".tr),
                  //       /* 工費 取inventory price */
                  //       _factory.getLaborCost().render(
                  //           context, widget.storeProductInfo.inventory?.price.round().toString(),
                  //           label: "${"product.widgets.factory.laborCost".tr}RMB¥"),
                  //     ],
                  //   ),
                  // ],
                  // /* 圈號/長度 */
                  // if (sizeLength.isNotEmpty) _factory.getUsage().render(context, sizeLength),
                  // // /* 證書 */
                  // // if (certificates.isNotEmpty) _factory.getCertificates().render(context, certificates),
                  // if (certificateList.isNotEmpty)
                  //   Wrap(
                  //     children: [
                  //       MyTextStatelessWidget(text:"${"product.label.certificateNo".tr}:",
                  //           style: _textTheme.titleLarge),
                  //       Wrap(children: [...certificateList]),
                  //     ],
                  //   ),
                  //
                  // /* 貨重 */
                  // _factory.getGrossWeight().render(context,
                  //     "${widget.storeProductInfo.inventory?.grossWeight?.gram.toString()}${"cart.label.gram".tr}",
                  //     label: "product.widgets.factory.physicalWeight".tr),
                  //
                  // /* 重量下限 */
                  // if (physicalWeightLowerBound != null)
                  //   _factory.getGrossWeight().render(
                  //       context, "${physicalWeightLowerBound.toString()}${"cart.label.gram".tr}",
                  //       label: "product.widgets.factory.standardSpecificationPhysicalWeight".tr),
                ],
              ),
            ),
          ),
          /* 價格 */
          // SizedBox(
          //   width: 150,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Column(
          //           mainAxisAlignment: MainAxisAlignment.end,
          //           crossAxisAlignment: CrossAxisAlignment.end,
          //           children: [
          //             /* 優惠 label */
          //             if ((_productAmountPOJO?.selectedDiscount?.discountName ?? "").isNotEmpty)
          //               DiscountTagStatelessWidget(
          //                   discountName: _productAmountPOJO?.selectedDiscount?.discountName),
          //
          //             /* 貨牌價 */
          //             _factory.getInventoryAmount().render(context, _inventoryAmount,
          //                 decoration:
          //                 _inventoryAmount != null && _netAmount != null && (_inventoryAmount > _netAmount)
          //                     ? TextDecoration.lineThrough
          //                     : TextDecoration.none),
          //
          //             /* 約定售價 */
          //             _factory.getNetAmount().render(context, _netAmount,
          //                 labelStyle: _textTheme.titleMedium, valueStyle: _textTheme.displaySmall),
          //           ])
          //     ],
          //   ),
          // )
        ],
      ),
      bottomWidget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('widget.button.cancel'.tr),
            style: OutlinedButton.styleFrom(minimumSize: SizeStyle.dialogButtonSize),
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
    );

    // return FutureBuilder<ProductAmountPOJO>(
    //     future: _futureAmount,
    //     builder: (BuildContext context, AsyncSnapshot<ProductAmountPOJO> snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         if (snapshot.hasError) {
    //           handleException(snapshot.error, context,
    //               eventName: "AddToCartByStoreStatefulWidget getStoreProductAmount error",
    //               callBack: () => {
    //                 if (MyNavigationService.canPop()) {MyNavigationService.pop(false)}
    //               });
    //         } else if (snapshot.hasData) {
    //           _productAmountPOJO = snapshot.data!;
    //         }
    //       }
    //
    //       final double? _inventoryAmount = _productAmountPOJO?.inventoryAmount;
    //       final double? _netAmount = _productAmountPOJO?.netAmount;
    //
    //       //TODO: 先註解從staticReferenceExt取名稱
    //       // List<String> productName = IndexPageState.prodService.getStoreProductName(widget.productInfoRes.catalogItem!).where((e)=>e.isNotEmpty).toList();
    //
    //       String? _finalBrandCollection;
    //       String? _finalCollection;
    //
    //       if (_brand.isNotEmpty) {
    //         _finalBrandCollection = _brand;
    //       } else if (_brand.isEmpty && _collection.isNotEmpty) {
    //         _finalBrandCollection = _collection;
    //       } else {
    //         _finalBrandCollection = "";
    //       }
    //
    //       if (_finalBrandCollection == _collection) {
    //         _finalCollection = _subCollection;
    //       } else {
    //         if (_collection.isNotEmpty) {
    //           _finalCollection = _collection;
    //         } else if (_collection.isEmpty && _subCollection.isNotEmpty) {
    //           _finalCollection = _subCollection;
    //         } else {
    //           _finalCollection = "";
    //         }
    //       }
    //
    //       final List<Bom>? bom = widget.storeProductInfo.inventory?.bom.where((e) => e.mainMaterialIndicator).toList();
    //
    //       final String sizeLength = IndexPageState.prodService.getProductSizeAndLength(
    //           widget.storeProductInfo.catalogItem?.usage?.referenceCode ?? "",
    //           widget.storeProductInfo.model?.length?.referenceCode ?? "",
    //           widget.storeProductInfo.model?.ringSize?.referenceCode ?? "",
    //           widget.storeProductInfo.catalogItem?.earringsType.firstOrNull?.zhCN ?? "");
    //
    //       List<Widget> certificateList = [];
    //       for (Bom bom in widget.storeProductInfo.inventory?.bom ?? []) {
    //         certificateList.addAll(bom.bomCertificates.map((e) {
    //           String physicalCert =
    //               "(${e.certificateOrganization}${e.physicalCertificateIndicator == "Y" ? ' ${"product.label.physicalCert".tr}' : ''})";
    //           String number = "${e.certificateNumber}$physicalCert";
    //           String? path = e.certificateOrganization == 'GIA' ? e.reportPdfPath : e.digitalCardPath;
    //           return certificateWidget(number, path);
    //         }).toList());
    //       }
    //
    //       /* 重量下限 找CN用的 weightUnit = GM */
    //       double? physicalWeightLowerBound = widget.storeProductInfo.catalogItem?.standardSpecificationPhysicalWeight
    //           .firstWhereOrNull((e) => e.weightUnit == "GM")
    //           ?.lowerBound;
    //
    //       return MyAlertDialogStatelessWidget(
    //         title: "widget.addToCart.title".tr,
    //         body: Row(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Expanded(
    //               child: Padding(
    //                 padding: const EdgeInsets.only(right: SizeStyle.paddingUnit),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     /* 貨品名稱 */
    //                     _factory.getProductName().render(context, _productNames.where((e) => e.isNotEmpty).join(" ")),
    //                     /* 品牌 */
    //                     if (_finalBrandCollection.isNotEmpty)
    //                       _factory.getBrand().render(context, _finalBrandCollection),
    //                     /* 系列＆副系列 */
    //                     if (_finalCollection.isNotEmpty) _factory.getCollection().render(context, _finalCollection),
    //
    //                     /* catalogItem number */
    //                     _factory.getCatalogItem().render(context, widget.storeProductInfo.catalogItem?.catalogItem,
    //                         padding: const EdgeInsets.only(right: 0)),
    //
    //                     /* inventory itemNumber */
    //                     _factory.getItemNumber().render(context, widget.storeProductInfo.inventory?.itemNumber,
    //                         padding: const EdgeInsets.only(right: 0),
    //                         valueStyle: _textTheme.titleLarge?.copyWith(color: ColorStyle.primary)),
    //
    //                     /* productDescription */
    //                     /* 定價 */
    //                     if (widget.storeProductInfo.model != null &&
    //                         widget.storeProductInfo.model!.fixedPriceIndicator) ...[
    //                       // Wrap(
    //                       //   children: [
    //                       //     /* 金重 */
    //                       //     if (widget.productInfoRes.inventory?.physicalWeight?.gram != null)
    //                       //       _factory.getPhysicalWeight().render(
    //                       //           context,
    //                       //           "${widget.productInfoRes.inventory?.physicalWeight?.gram.toString()}${"cart.label.gram".tr}" ??
    //                       //               "",
    //                       //           label: "product.widgets.factory.goldWeight".tr),
    //                       //   ],
    //                       // ),
    //                       if (bom != null && bom.isNotEmpty) ...[
    //                         ...bom.map(
    //                               (e) => Wrap(
    //                             children: [
    //                               /* 重量 */
    //                               _factory.getBomCaratWeight().render(context, e.caratWeight.toString(),
    //                                   label: "product.widgets.factory.caratWeight".tr),
    //                               /* 顏色 */
    //                               _factory
    //                                   .getBomDiamondColor()
    //                                   .render(context, e.diamondColor?.zhCN, label: "product.widgets.factory.color".tr),
    //                               /* 淨度 */
    //                               _factory.getBomDiamondClarity().render(context, e.diamondClarity?.referenceCode,
    //                                   label: "product.widgets.factory.clarity".tr),
    //                               /* 切工 */
    //                               _factory.getBomDiamondCutGrade().render(context, e.diamondCutGrade?.zhCN,
    //                                   label: "product.widgets.factory.cutGrade".tr),
    //                             ],
    //                           ),
    //                         )
    //                       ]
    //                     ],
    //
    //                     /* 計價 */
    //                     if (widget.storeProductInfo.model != null &&
    //                         !widget.storeProductInfo.model!.fixedPriceIndicator) ...[
    //                       Wrap(
    //                         direction: Axis.horizontal,
    //                         crossAxisAlignment: WrapCrossAlignment.end,
    //                         children: [
    //                           MyTextStatelessWidget(text: "${"cart.label.brandPrice".tr}:",
    //                               padding: const EdgeInsets.only(right: SizeStyle.paddingUnit),
    //                               style: _textTheme.titleLarge),
    //                           /* 金重 */
    //                           if ((widget.storeProductInfo.inventory?.physicalWeight?.gram.toString() ?? "").isNotEmpty)
    //                             _factory.getPhysicalWeight().render(context,
    //                                 "${widget.storeProductInfo.inventory?.physicalWeight?.gram.toString()}${"cart.label.gram".tr}",
    //                                 label: "product.widgets.factory.goldWeight".tr),
    //                           /* 賣出金價 */
    //                           if ((_productAmountPOJO?.goldPrice.toString() ?? "").isNotEmpty)
    //                             _factory.getGoldPrice().render(context, "¥${_productAmountPOJO?.goldPrice.toString()}",
    //                                 label: "product.widgets.factory.saleGoldWeight".tr),
    //                           /* 工費 取inventory price */
    //                           _factory.getLaborCost().render(
    //                               context, widget.storeProductInfo.inventory?.price.round().toString(),
    //                               label: "${"product.widgets.factory.laborCost".tr}RMB¥"),
    //                         ],
    //                       ),
    //                     ],
    //                     /* 圈號/長度 */
    //                     if (sizeLength.isNotEmpty) _factory.getUsage().render(context, sizeLength),
    //                     // /* 證書 */
    //                     // if (certificates.isNotEmpty) _factory.getCertificates().render(context, certificates),
    //                     if (certificateList.isNotEmpty)
    //                       Wrap(
    //                         children: [
    //                           MyTextStatelessWidget(text:"${"product.label.certificateNo".tr}:",
    //                               style: _textTheme.titleLarge),
    //                           Wrap(children: [...certificateList]),
    //                         ],
    //                       ),
    //
    //                     /* 貨重 */
    //                     _factory.getGrossWeight().render(context,
    //                         "${widget.storeProductInfo.inventory?.grossWeight?.gram.toString()}${"cart.label.gram".tr}",
    //                         label: "product.widgets.factory.physicalWeight".tr),
    //
    //                     /* 重量下限 */
    //                     if (physicalWeightLowerBound != null)
    //                       _factory.getGrossWeight().render(
    //                           context, "${physicalWeightLowerBound.toString()}${"cart.label.gram".tr}",
    //                           label: "product.widgets.factory.standardSpecificationPhysicalWeight".tr),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             /* 價格 */
    //             // SizedBox(
    //             //   width: 150,
    //             //   child: Column(
    //             //     mainAxisAlignment: MainAxisAlignment.end,
    //             //     children: [
    //             //       Column(
    //             //           mainAxisAlignment: MainAxisAlignment.end,
    //             //           crossAxisAlignment: CrossAxisAlignment.end,
    //             //           children: [
    //             //             /* 優惠 label */
    //             //             if ((_productAmountPOJO?.selectedDiscount?.discountName ?? "").isNotEmpty)
    //             //               DiscountTagStatelessWidget(
    //             //                   discountName: _productAmountPOJO?.selectedDiscount?.discountName),
    //             //
    //             //             /* 貨牌價 */
    //             //             _factory.getInventoryAmount().render(context, _inventoryAmount,
    //             //                 decoration:
    //             //                 _inventoryAmount != null && _netAmount != null && (_inventoryAmount > _netAmount)
    //             //                     ? TextDecoration.lineThrough
    //             //                     : TextDecoration.none),
    //             //
    //             //             /* 約定售價 */
    //             //             _factory.getNetAmount().render(context, _netAmount,
    //             //                 labelStyle: _textTheme.titleMedium, valueStyle: _textTheme.displaySmall),
    //             //           ])
    //             //     ],
    //             //   ),
    //             // )
    //           ],
    //         ),
    //         bottomWidget: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             OutlinedButton(
    //               onPressed: () => Navigator.of(context).pop(false),
    //               child: Text('widget.button.cancel'.tr),
    //               style: OutlinedButton.styleFrom(minimumSize: SizeStyle.dialogButtonSize),
    //             ),
    //             Row(
    //               children: [
    //                 if (widget.storeProductInfo.earmark != null && widget.storeProductInfo.earmark?.quantity != 0 ||
    //                     widget.storeProductInfo.storeCatalogItems.isNotEmpty)
    //                   Padding(
    //                     padding: const EdgeInsets.only(right: SizeStyle.pagePadding),
    //                     child: OutlinedButton.icon(
    //                       onPressed: _isProductStockLoading
    //                           ? null
    //                           : () async {
    //                         try {
    //                           setState(() => _isProductStockLoading = true);
    //                           PossProductO2ORes? possProductO2ORes;
    //
    //                           if (widget.storeProductInfo.earmark != null &&
    //                               widget.storeProductInfo.earmark?.quantity != 0) {
    //                             possProductO2ORes = await IndexPageState.prodService.searchO2O(
    //                                 referenceInventoryId: widget.storeProductInfo.inventory?.inventoryId);
    //                           }
    //                           setState(() => _isProductStockLoading = false);
    //                           Navigator.of(context).pop();
    //                           showMyDialogWithScaffold(
    //                             context: context,
    //                             barrierDismissible: false,
    //                             body: ProductStockStatefulWidget(
    //                                 productInfoRes: widget.storeProductInfo,
    //                                 possProductO2ORes: possProductO2ORes,
    //                                 storeProductAmountPOJO: _productAmountPOJO),
    //                           );
    //                         } catch (e) {
    //                           setState(() => _isProductStockLoading = false);
    //                           handleException(e, context,
    //                               eventName: "AddToCartByStoreStatefulWidget searchO2O failed");
    //                         }
    //                       },
    //                       label: Text("widget.addToCart.button.inventoryList".tr),
    //                       style: OutlinedButton.styleFrom(
    //                         minimumSize: SizeStyle.dialogButtonSize,
    //                       ),
    //                       icon: _isProductStockLoading
    //                           ? Container(
    //                         width: 24,
    //                         height: 24,
    //                         padding: const EdgeInsets.all(2.0),
    //                         child: const CircularProgressIndicator(
    //                           color: ColorStyle.lightGrey1,
    //                           strokeWidth: 3,
    //                         ),
    //                       )
    //                           : const Icon(Icons.list),
    //                     ),
    //                   ),
    //                 ElevatedButton(
    //                   onPressed: !_isAddToCartLoading &&
    //                       !_isInCart &&
    //                       _inventoryAmount != null &&
    //                       _netAmount != null &&
    //                       widget.storeProductInfo.inventory?.inventoryStatus == null
    //                       ? _submitAddToCart
    //                       : null,
    //                   child: _isAddToCartLoading
    //                       ? Container(
    //                     width: 24,
    //                     height: 24,
    //                     padding: const EdgeInsets.all(2.0),
    //                     child: const CircularProgressIndicator(
    //                       color: Colors.white,
    //                       strokeWidth: 3,
    //                     ),
    //                   )
    //                       : Text(
    //                       _isInCart
    //                           ? "widget.addToCart.button.alreadyAddToCart".tr
    //                           : (_inventoryAmount != null && _netAmount != null)
    //                           ? widget.storeProductInfo.inventory?.inventoryStatus == null
    //                           ? "widget.addToCart.button.addToCart".tr
    //                           : "widget.addToCart.button.outOfStockItem".tr
    //                           : "widget.addToCart.button.noPriceInformation".tr,
    //                       style: _textTheme.titleLarge?.copyWith(color: ColorStyle.white)),
    //                   style: ElevatedButton.styleFrom(minimumSize: SizeStyle.dialogButtonSize),
    //                 ),
    //               ],
    //             )
    //           ],
    //         ),
    //       );
    //     });
  }
}
