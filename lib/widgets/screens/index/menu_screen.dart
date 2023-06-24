import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
// import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:mobile_poss_gp01/extension/string_extension.dart';
import 'package:mobile_poss_gp01/resources/color_style.dart';
import 'package:mobile_poss_gp01/resources/size_style.dart';
import 'package:mobile_poss_gp01/util/handle_date/handle_date.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';
import 'package:mobile_poss_gp01/widgets/components/my_scaffold_stateful_widget.dart';
import 'package:mobile_poss_gp01/widgets/components/my_text_stateless_widget.dart';
import 'package:mobile_poss_gp01/widgets/containers/menu/group_feature_button_stateless_widget.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';
import 'package:shimmer/shimmer.dart';

/// Page: 主選單
// class MenuPageStatefulWidget extends StatefulWidget {
//   const MenuPageStatefulWidget({Key? key}) : super(key: key);
//
//   @override
//   State<MenuPageStatefulWidget> createState() => _MenuPageState();
// }

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  //
  // ///金價資訊
  // List<Map<String, String>> tableData = [
  //   {'name': 'menu.label.pureGoldJewelry'.tr, 'price1': "", 'price2': "", 'price3': ""},
  //   {'name': 'menu.label.goldBuckle'.tr, 'price1': "", 'price2': "", 'price3': ""},
  //   {'name': 'menu.label.cssGold'.tr, 'price1': "", 'price2': "", 'price3': ""},
  //   {'name': 'menu.label.platinumJewelry'.tr, 'price1': "", 'price2': "", 'price3': ""},
  // ];
  //

  //
  // ///售後服務 & 訂製
  // late List<_GroupFeaturePojo> data2 =
  //     features.getRange(2, features.length).map((e) => _GroupFeaturePojo.fromJson(e)).toList();
  //
  // List<dynamic> mockCurrencyData = ["RMB", "TWD"];
  //
  // double columnWidth = 0.0;
  //
  // double columnHeight = 34;

  // Widget _getItemWidget(
  //   String label,
  //   double width, {
  //   AlignmentGeometry alignment = Alignment.center,
  //   Color bgColor = ColorStyle.tableHeader,
  //   Color textColor = Colors.black,
  // }) {
  //   return label.isEmpty
  //       ? Container(
  //           width: width,
  //           height: columnHeight,
  //           alignment: alignment,
  //           padding: const EdgeInsets.all(SizeStyle.paddingUnit * 0.5),
  //           child: Shimmer.fromColors(
  //             baseColor:
  //                 bgColor == ColorStyle.shimmerHighlightColor ? const Color.fromRGBO(247, 246, 242, 1.0) : bgColor,
  //             highlightColor: ColorStyle.shimmerHighlightColor,
  //             child: Container(
  //               alignment: alignment,
  //               color: ColorStyle.white,
  //               child: Text('', style: Theme.of(context).textTheme.bodyLarge),
  //             ),
  //           ),
  //         )
  //       : Container(
  //           child: Text(
  //             label,
  //             style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: textColor, fontWeight: FontWeight.w500),
  //           ),
  //           width: width,
  //           height: columnHeight,
  //           alignment: alignment,
  //           padding: const EdgeInsets.fromLTRB(SizeStyle.paddingUnit * 0.5, 0, 0, 0),
  //           color: bgColor,
  //         );
  // }
  //
  // List<Widget> _getTitleWidget(double width) {
  //   return [
  //     /* 金類(每克) */
  //     _getItemWidget("menu.label.goldGram".tr, width, alignment: Alignment.centerLeft, textColor: Colors.white),
  //     /* 賣出(RMB) */
  //     _getItemWidget("menu.label.sell".tr, width, textColor: Colors.white),
  //     /* 換金 */
  //     _getItemWidget("menu.label.changeGold".tr, width, textColor: Colors.white),
  //     /* 換珠寶 */
  //     _getItemWidget("menu.label.changeJewelry".tr, width, textColor: Colors.white),
  //   ];
  // }
  //
  // Color _getRowColor(int index) {
  //   return index % 2 == 0 ? const Color.fromRGBO(247, 246, 242, 1.0) : const Color.fromRGBO(255, 255, 255, 1.0);
  // }
  //
  // Widget _generateFirstColumnRow(BuildContext context, int index) {
  //   String label = tableData.elementAt(index)['name'] != null ? tableData.elementAt(index)['name'] as String : "--";
  //   return _getItemWidget(label, columnWidth, alignment: Alignment.centerLeft, bgColor: _getRowColor(index));
  // }
  //
  // Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
  //   return Row(
  //     children: <Widget>[
  //       _getItemWidget(
  //           tableData.elementAt(index)['price1'] != null ? tableData.elementAt(index)['price1'] as String : "--",
  //           columnWidth,
  //           bgColor: _getRowColor(index)),
  //       _getItemWidget(
  //           tableData.elementAt(index)['price2'] != null ? tableData.elementAt(index)['price2'] as String : "--",
  //           columnWidth,
  //           bgColor: _getRowColor(index)),
  //       _getItemWidget(
  //           tableData.elementAt(index)['price3'] != null ? tableData.elementAt(index)['price3'] as String : "--",
  //           columnWidth,
  //           bgColor: _getRowColor(index)),
  //     ],
  //   );
  // }
  //
  // DataCell tableColumn(String text) {
  //   return DataCell(Center(
  //     child: Text(text, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black)),
  //   ));
  // }
  //
  // DataRow tableRow(int index, List<String> data) {
  //   return DataRow(
  //     color: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
  //       if (index % 2 == 0) {
  //         return const Color.fromRGBO(247, 246, 242, 1.0);
  //       }
  //       return const Color.fromRGBO(255, 255, 255, 1.0); // Use default value for other states and odd rows.
  //     }),
  //     cells: <DataCell>[
  //       DataCell(Text(data.elementAt(0),
  //           textAlign: TextAlign.start, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black))),
  //       ...data.getRange(1, data.length).map((e) => tableColumn(e))
  //     ],
  //   );
  // }
  //
  // String _removeTrailingZeroes(double? value) {
  //   if (value == null) return "--";
  //   String stringValue = value.toInt().toString();
  //   return stringValue;
  // }

  @override
  Widget build(BuildContext context) {
    double calcColumnWidth = (MediaQuery.of(context).size.width - 356) / 4;
    // columnWidth = calcColumnWidth < 100 ? 100 : calcColumnWidth;

    List<dynamic> features = [
      {
        'name': "menu.label.sale".tr,
        'features': [
          {
            'name': 'menu.button.startSession'.tr,
            'icon': Icons.group_add.codePoint,
            'disabled': false,
            'func': () async {
              // if (IndexPageState.customerService.getCurrentCustomerSession()?.isNotEmpty == true) {
              //   /* 當前已有會客序號: 關閉當前會客 */
              //   bool _isConfirm = await showAlertWithResp(context, "widget.appbar.label.closeCustomerSession".tr,
              //       titleAlignment: TextAlign.center) ??
              //       false;
              //   if (!_isConfirm) return;
              //   await IndexPageState.customerService.stopOrCloseCustomerSession();
              // }
              //
              // IndexPageState.customerService.createNewCustomerSession();
              // showSuccessSnackBar(context, "menu.message.alreadyCreatedCustomerSession".tr);
              // final AppProvider _appProvider = context.read<AppProvider>();
              // _appProvider.closeDrawer();
              // _appProvider.setBottomIndex(3);
              // MyNavigationPossService.pushReset(PossMobileRoute.cartPageRouteName);
            }
          },
          {'name': "menu.button.myCard".tr, 'icon': 0xe18a, 'disabled': true, 'func': () {}}
        ]
      },
      {
        'name': "menu.label.transaction".tr,
        'features': [
          {'name': "menu.button.viewItems".tr, 'icon': 0xe33e, 'disabled': true, 'func': () {}},
          {'name': "menu.button.jewelryPurchase".tr, 'icon': 0xf04ed, 'disabled': true, 'func': () {}}
        ]
      },
      // {
      //   'name': "menu.label.afterSaleService".tr,
      //   'features': [
      //     {'name': "menu.button.pickUp".tr, 'icon': 0xe13e, 'disabled': false},
      //     {'name': "menu.button.customerRepair".tr, 'icon': 0xe189, 'disabled': false},
      //     {'name': "menu.button.specialReturns".tr, 'icon': 0xe0a8, 'disabled': false},
      //     {'name': "menu.button.cancelDeal".tr, 'icon': 0xe139, 'disabled': false},
      //     {'name': "menu.button.addOrder".tr, 'icon': 0xe0b2, 'disabled': false}
      //   ]
      // },
      // {
      //   'name': "menu.label.customized".tr,
      //   'features': [
      //     {'name': "menu.button.diamondJewelry".tr, 'icon': 0xe08c, 'disabled': true},
      //     {'name': "menu.button.customRings".tr, 'icon': 0xe08c, 'disabled': false},
      //     {'name': "menu.button.weddingOrder".tr, 'icon': 0xe08c, 'disabled': false},
      //     {'name': "menu.button.spotSales".tr, 'icon': 0xf04f6, 'disabled': false},
      //   ]
      // },
    ];
    // ///銷售 & 購入交易
    List<_GroupFeaturePojo> data = features.getRange(0, 2).map((e) => _GroupFeaturePojo.fromJson(e)).toList();

    return MyScaffoldStatefulWidget(
        body: Container(
      color: const Color.fromRGBO(247, 246, 242, 1.0),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              /* 功能選項 */
              MyTextStatelessWidget(
                padding: const EdgeInsets.all(8.0),
                text: "menu.title.menu".tr,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontWeight: FontWeight.normal, color: Colors.black),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /* 銷售 & 購入交易 */
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ...data.map((e) => GroupFeatureButtonStatelessWidget(
                                      items: e.features,
                                      title: e.name,
                                    ))
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                /* 金價資訊 */
                                MyTextStatelessWidget(
                                  text: "menu.label.goldInfo".tr,
                                  style:
                                      Theme.of(context).textTheme.bodyLarge?.copyWith(color: const Color(0xFF241f20)),
                                  padding: const EdgeInsets.symmetric(vertical: SizeStyle.paddingUnit * 2),
                                ),
                                /* 金價資訊 table */
                                // SizedBox(
                                //   width: columnWidth < 100 ? 400 : (columnWidth * 4),
                                //   height: 170,
                                //   child: HorizontalDataTable(
                                //     tableHeight: 170,
                                //     leftHandSideColumnWidth: columnWidth,
                                //     rightHandSideColumnWidth: columnWidth * 3,
                                //     isFixedHeader: true,
                                //     headerWidgets: _getTitleWidget(columnWidth),
                                //     leftSideItemBuilder: _generateFirstColumnRow,
                                //     rightSideItemBuilder: _generateRightHandSideColumnRow,
                                //     itemCount: tableData.length,
                                //     leftHandSideColBackgroundColor: const Color.fromRGBO(247, 246, 242, 1.0),
                                //     rightHandSideColBackgroundColor: const Color.fromRGBO(247, 246, 242, 1.0),
                                //   ),
                                // ),
                                // if (_latestDate != null)
                                //   SizedBox(
                                //     width: columnWidth < 100 ? 400 : (columnWidth * 4),
                                //     height: columnHeight,
                                //     child: Row(
                                //       mainAxisAlignment: MainAxisAlignment.end,
                                //       crossAxisAlignment: CrossAxisAlignment.end,
                                //       children: [
                                //         MyTextStatelessWidget(
                                //           text: HandleDate.getFormattedDate(_latestDate),
                                //           style: Theme.of(context)
                                //               .textTheme
                                //               .bodyLarge
                                //               ?.copyWith(color: ColorStyle.grey),
                                //           padding: const EdgeInsets.all(0),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  /* 售後服務 & 訂製 */
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ...data2.map((e) => GroupFeatureButtonStatelessWidget(
                        //       items: e.features,
                        //       title: e.name,
                        //     ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    ));
    // return StreamBuilder<RealmResultsChanges<GoldRate>>(
    //     stream: IndexPageState.goldRateService.getGoldRate()?.changes,
    //     builder: (context, snapshot) {
    //       final realmData = snapshot.data;
    //       late DateTime? _latestDate =
    //       realmData?.results.map((e) => e.lastModifyDate).reduce((min, e) => e.isAfter(min) ? e : min);
    //
    //       if (realmData != null && realmData.results.isNotEmpty) {
    //         Map<String?, List<GoldRate>> groups = groupBy(realmData.results, (GoldRate e) => e.goldRateTypeCode);
    //
    //         groups.forEach((key, value) {
    //           if (value.isNotEmpty) value.sort((a, b) => b.effectiveDate.compareTo(a.effectiveDate));
    //         });
    //
    //         _latestDate = realmData.results.map((e) => e.lastModifyDate).reduce((min, e) => e.isAfter(min) ? e : min);
    //
    //         tableData = [
    //           {
    //             'name': 'menu.label.pureGoldJewelry'.tr,
    //             'price1': _removeTrailingZeroes(groups['001']?.firstOrNull?.rate),
    //             'price2': _removeTrailingZeroes(groups['007']?.firstOrNull?.rate),
    //             'price3': _removeTrailingZeroes(groups['008']?.firstOrNull?.rate)
    //           },
    //           {
    //             'name': 'menu.label.goldBuckle'.tr,
    //             'price1': _removeTrailingZeroes(groups['005']?.firstOrNull?.rate),
    //             'price2': '--',
    //             'price3': '--'
    //           },
    //           {
    //             'name': 'menu.label.cssGold'.tr,
    //             'price1': _removeTrailingZeroes(groups['006']?.firstOrNull?.rate),
    //             'price2': '--',
    //             'price3': '--'
    //           },
    //           {
    //             'name': 'menu.label.platinumJewelry'.tr,
    //             'price1': _removeTrailingZeroes(groups['002']?.firstOrNull?.rate),
    //             'price2': _removeTrailingZeroes(groups['009']?.firstOrNull?.rate),
    //             'price3': '--'
    //           },
    //         ];
    //       }
    //       return Container(
    //         color: const Color.fromRGBO(247, 246, 242, 1.0),
    //         child: Column(children: [
    //           Padding(
    //             padding: const EdgeInsets.all(16.0),
    //             child: Row(
    //               children: [
    //                 /* 功能選項 */
    //                 MyTextStatelessWidget(
    //                   padding: const EdgeInsets.all(8.0),
    //                   text: "menu.title.menu".tr,
    //                   style: Theme.of(context)
    //                       .textTheme
    //                       .displayMedium
    //                       ?.copyWith(fontWeight: FontWeight.normal, color: Colors.black),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Expanded(
    //             child: Container(
    //               padding: const EdgeInsets.symmetric(horizontal: 24),
    //               width: double.infinity,
    //               child: SingleChildScrollView(
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   children: [
    //                     SingleChildScrollView(
    //                       scrollDirection: Axis.horizontal,
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Row(
    //                             mainAxisAlignment: MainAxisAlignment.start,
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               /* 銷售 & 購入交易 */
    //                               Column(
    //                                 crossAxisAlignment: CrossAxisAlignment.start,
    //                                 mainAxisAlignment: MainAxisAlignment.start,
    //                                 children: [
    //                                   ...data.map((e) => GroupFeatureButtonStatelessWidget(
    //                                     items: e.features,
    //                                     title: e.name,
    //                                   ))
    //                                 ],
    //                               ),
    //                               Column(
    //                                 crossAxisAlignment: CrossAxisAlignment.start,
    //                                 mainAxisAlignment: MainAxisAlignment.start,
    //                                 children: [
    //                                   /* 金價資訊 */
    //                                   MyTextStatelessWidget(
    //                                     text: "menu.label.goldInfo".tr,
    //                                     style: Theme.of(context)
    //                                         .textTheme
    //                                         .bodyLarge
    //                                         ?.copyWith(color: const Color(0xFF241f20)),
    //                                     padding: const EdgeInsets.symmetric(vertical: SizeStyle.paddingUnit * 2),
    //                                   ),
    //                                   /* 金價資訊 table */
    //                                   SizedBox(
    //                                     width: columnWidth < 100 ? 400 : (columnWidth * 4),
    //                                     height: 170,
    //                                     child: HorizontalDataTable(
    //                                       tableHeight: 170,
    //                                       leftHandSideColumnWidth: columnWidth,
    //                                       rightHandSideColumnWidth: columnWidth * 3,
    //                                       isFixedHeader: true,
    //                                       headerWidgets: _getTitleWidget(columnWidth),
    //                                       leftSideItemBuilder: _generateFirstColumnRow,
    //                                       rightSideItemBuilder: _generateRightHandSideColumnRow,
    //                                       itemCount: tableData.length,
    //                                       leftHandSideColBackgroundColor: const Color.fromRGBO(247, 246, 242, 1.0),
    //                                       rightHandSideColBackgroundColor: const Color.fromRGBO(247, 246, 242, 1.0),
    //                                     ),
    //                                   ),
    //                                   if (_latestDate != null)
    //                                     SizedBox(
    //                                       width: columnWidth < 100 ? 400 : (columnWidth * 4),
    //                                       height: columnHeight,
    //                                       child: Row(
    //                                         mainAxisAlignment: MainAxisAlignment.end,
    //                                         crossAxisAlignment: CrossAxisAlignment.end,
    //                                         children: [
    //                                           MyTextStatelessWidget(
    //                                             text: HandleDate.getFormattedDate(_latestDate),
    //                                             style: Theme.of(context)
    //                                                 .textTheme
    //                                                 .bodyLarge
    //                                                 ?.copyWith(color: ColorStyle.grey),
    //                                             padding: const EdgeInsets.all(0),
    //                                           ),
    //                                         ],
    //                                       ),
    //                                     ),
    //                                 ],
    //                               ),
    //                             ],
    //                           )
    //                         ],
    //                       ),
    //                     ),
    //                     /* 售後服務 & 訂製 */
    //                     SingleChildScrollView(
    //                       scrollDirection: Axis.horizontal,
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           ...data2.map((e) => GroupFeatureButtonStatelessWidget(
    //                             items: e.features,
    //                             title: e.name,
    //                           ))
    //                         ],
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ]),
    //       );
    //     });
  }
}

class _GroupFeaturePojo {
  final String name; //deviceToken, badgeNumber, router
  final List<_FeaturePojo> features; //json string

  _GroupFeaturePojo(this.name, this.features);

  factory _GroupFeaturePojo.fromJson(Map<String, dynamic> json) {
    List<dynamic> arr = json['features'] as List<dynamic>;

    List<_FeaturePojo> list = arr.map((e) {
      Map<String, dynamic> element = e as Map<String, dynamic>;
      return _FeaturePojo.fromJson(element);
    }).toList();

    return _GroupFeaturePojo(json["name"] as String, list);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'features': features,
      };
}

class _FeaturePojo {
  final String name; //deviceToken, badgeNumber, router
  final int icon;
  final bool disabled; //json string
  final VoidCallback func;

  _FeaturePojo(this.name, this.icon, this.disabled, this.func);

  _FeaturePojo.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        icon = json['icon'] as int,
        disabled = json['disabled'] as bool,
        func = json['func'] as VoidCallback;

  Map<String, dynamic> toJson() => {'name': name, 'icon': icon, 'disabled': disabled, 'func': func};
}
