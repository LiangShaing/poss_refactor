import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:mobile_poss_gp01/blocs/authentication_bloc.dart';
import 'package:mobile_poss_gp01/blocs/customer_session_bloc.dart';
import 'package:mobile_poss_gp01/blocs/gold_rate_bloc.dart';
import 'package:mobile_poss_gp01/database_objects/realm/pojo/gold_rate_pojo.dart';
import 'package:mobile_poss_gp01/events/customer_session_event.dart';
import 'package:mobile_poss_gp01/extension/string_extension.dart';
import 'package:mobile_poss_gp01/mixins/common_function.dart';
import 'package:mobile_poss_gp01/repositories/authentication_repository.dart';
import 'package:mobile_poss_gp01/repositories/customer_session_repository.dart';
import 'package:mobile_poss_gp01/repositories/gold_rate_repository.dart';
import 'package:mobile_poss_gp01/resources/color_style.dart';
import 'package:mobile_poss_gp01/resources/size_style.dart';
import 'package:mobile_poss_gp01/states/customer_session_state.dart';
import 'package:mobile_poss_gp01/states/gold_rate_state.dart';
import 'package:mobile_poss_gp01/util/handle_date/handle_date.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';
import 'package:mobile_poss_gp01/widgets/components/my_scaffold_stateful_widget.dart';
import 'package:mobile_poss_gp01/widgets/components/my_text_stateless_widget.dart';
import 'package:shimmer/shimmer.dart';

/// Page: 主選單
class MenuScreen extends StatelessWidget with CommonFunction {
  const MenuScreen({super.key});

  Color getRowColor(int index) {
    return index % 2 == 0 ? const Color.fromRGBO(247, 246, 242, 1.0) : const Color.fromRGBO(255, 255, 255, 1.0);
  }

  String _removeTrailingZeroes(double? value) {
    if (value == null) return "--";
    String stringValue = value.toInt().toString();
    return stringValue;
  }

  Widget _goldInfoTableBuilder(BuildContext context, GoldRateState state) {
    double calcColumnWidth = (MediaQuery.of(context).size.width - 356) / 4;
    double columnWidth = calcColumnWidth < 100 ? 100 : calcColumnWidth;
    double columnHeight = 34;
    List<GoldRatePOJO> list = [];
    if (state.runtimeType == GoldRateLoadSuccess) {
      list = (state as GoldRateLoadSuccess).list;
    }
    DateTime? latestDate =
        list.isNotEmpty ? list.map((e) => e.lastModifyDate).reduce((min, e) => e.isAfter(min) ? e : min) : null;
    Map<String?, List<GoldRatePOJO>> groups = groupBy(list, (GoldRatePOJO e) => e.goldRateTypeCode);

    groups.forEach((key, value) {
      if (value.isNotEmpty) value.sort((a, b) => b.effectiveDate.compareTo(a.effectiveDate));
    });

    List<Map<String, String>>  tableData = [
      {
        'name': 'menu.label.pureGoldJewelry'.tr,
        'price1': _removeTrailingZeroes(groups['001']?.firstOrNull?.rate),
        'price2': '--',
        'price3': _removeTrailingZeroes(groups['007']?.firstOrNull?.rate)
      },
      {
        'name': 'menu.label.sequins'.tr,
        'price1': _removeTrailingZeroes(groups['005']?.firstOrNull?.rate),
        'price2': '--',
        'price3': '--'
      },
      {
        'name': 'menu.label.cssGold'.tr,
        'price1': _removeTrailingZeroes(groups['006']?.firstOrNull?.rate),
        'price2': '--',
        'price3': '--'
      },
      {'name': 'menu.label.goldBars'.tr, 'price1': "--", 'price2': "--", 'price3': "--"},
      {
        'name': 'menu.label.platinumJewelry'.tr,
        'price1': "--",
        'price2': "--",
        'price3': "--"
      },
      {
        'name': 'menu.label.950platinumJewelry'.tr,
        'price1': _removeTrailingZeroes(groups['002']?.firstOrNull?.rate),
        'price2': '--',
        'price3': _removeTrailingZeroes(groups['009']?.firstOrNull?.rate)
      },
    ];

    Widget getItemWidget(
      String label,
      double width, {
      AlignmentGeometry alignment = Alignment.center,
      Color bgColor = ColorStyle.tableHeader,
      Color textColor = Colors.black,
    }) {
      return label.isEmpty
          ? Container(
              width: width,
              height: columnHeight,
              alignment: alignment,
              padding: const EdgeInsets.all(SizeStyle.paddingUnit * 0.5),
              child: Shimmer.fromColors(
                baseColor:
                    bgColor == ColorStyle.shimmerHighlightColor ? const Color.fromRGBO(247, 246, 242, 1.0) : bgColor,
                highlightColor: ColorStyle.shimmerHighlightColor,
                child: Container(
                  alignment: alignment,
                  color: ColorStyle.white,
                  child: Text('', style: Theme.of(context).textTheme.bodyLarge),
                ),
              ),
            )
          : Container(
              width: width,
              height: columnHeight,
              alignment: alignment,
              padding: const EdgeInsets.fromLTRB(SizeStyle.paddingUnit * 0.5, 0, 0, 0),
              color: bgColor,
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: textColor, fontWeight: FontWeight.w500),
              ),
            );
    }

    List<Widget> getTitleWidget(double width) {
      return [
        /* 金類(每克) */
        getItemWidget("menu.label.goldGram".tr, width, alignment: Alignment.centerLeft, textColor: Colors.white),
        /* 賣出(RMB) */
        getItemWidget("menu.label.sell".tr, width, textColor: Colors.white),
        /* 換金 */
        getItemWidget("menu.label.changeGold".tr, width, textColor: Colors.white),
        /* 換珠寶 */
        getItemWidget("menu.label.changeJewelry".tr, width, textColor: Colors.white),
      ];
    }

    Widget generateFirstColumnRow(BuildContext context, int index) {
      String label = tableData.elementAt(index)['name'] != null ? tableData.elementAt(index)['name'] as String : "--";
      return getItemWidget(label, columnWidth, alignment: Alignment.centerLeft, bgColor: getRowColor(index));
    }

    Widget generateRightHandSideColumnRow(BuildContext context, int index) {
      return Row(
        children: <Widget>[
          getItemWidget(
              tableData.elementAt(index)['price1'] != null ? tableData.elementAt(index)['price1'] as String : "--",
              columnWidth,
              bgColor: getRowColor(index)),
          getItemWidget(
              tableData.elementAt(index)['price2'] != null ? tableData.elementAt(index)['price2'] as String : "--",
              columnWidth,
              bgColor: getRowColor(index)),
          getItemWidget(
              tableData.elementAt(index)['price3'] != null ? tableData.elementAt(index)['price3'] as String : "--",
              columnWidth,
              bgColor: getRowColor(index)),
        ],
      );
    }

    return Column(
      children: [
        SizedBox(
            width: columnWidth < 100 ? 400 : (columnWidth * 4),
            height: 170,
            child: HorizontalDataTable(
              tableHeight: 170,
              leftHandSideColumnWidth: columnWidth,
              rightHandSideColumnWidth: columnWidth * 3,
              isFixedHeader: true,
              headerWidgets: getTitleWidget(columnWidth),
              leftSideItemBuilder: generateFirstColumnRow,
              rightSideItemBuilder: generateRightHandSideColumnRow,
              itemCount: tableData.length,
              leftHandSideColBackgroundColor: const Color.fromRGBO(247, 246, 242, 1.0),
              rightHandSideColBackgroundColor: const Color.fromRGBO(247, 246, 242, 1.0),
            )),
        if (latestDate != null)
          SizedBox(
            width: columnWidth < 100 ? 400 : (columnWidth * 4),
            height: columnHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MyTextStatelessWidget(
                  text: HandleDate.getFormattedDate(latestDate),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorStyle.grey),
                  padding: const EdgeInsets.all(0),
                ),
              ],
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CustomerSessionBloc>(
            create: (BuildContext context) => CustomerSessionBloc(
                customerSessionRepository: CustomerSessionRepository(),
                authenticationRepository: AuthenticationRepository())
              ..add(CustomerSessionInitialed()),
          ),
          BlocProvider<GoldRateBloc>(
            create: (BuildContext context) => GoldRateBloc(goldRateRepository: GoldRateRepository()),
          )
        ],
        child: MyScaffoldStatefulWidget(
            body: Container(
          color: const Color.fromRGBO(247, 246, 242, 1.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  /* 功能選項 */
                  Text(context.read<AuthenticationBloc>().state.employeePOJO?.employeeId ??"123"),
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
                                // Padding(
                                //   padding: const EdgeInsets.only(right: 24.0, bottom: 12),
                                //   child: SizedBox(
                                //     width: 130,
                                //     height: 70,
                                //     child: ElevatedButton(
                                //       onPressed: () {
                                //         BlocProvider.of<CustomerSessionBloc>(context).add(CustomerSessionStarted());
                                //         // e.func();
                                //         // Scaffold.of(context).closeDrawer();
                                //       },
                                //       style: ElevatedButton.styleFrom(
                                //           fixedSize: Size(MediaQuery.of(context).size.width, 50),
                                //           backgroundColor: Theme.of(context).primaryColor),
                                //       child: Column(
                                //         mainAxisAlignment: MainAxisAlignment.center,
                                //         children: [
                                //           // Icon(
                                //           //   IconData(e.icon, fontFamily: 'MaterialIcons'),
                                //           //   color: ColorStyle.white,
                                //           // ),
                                //           Padding(
                                //             padding: const EdgeInsets.only(top: SizeStyle.paddingUnit),
                                //             child: Text(
                                //               "test",
                                //               style: const TextStyle(fontSize: 14.0, color: ColorStyle.white),
                                //             ),
                                //           )
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    MyTextStatelessWidget(
                                      text: "menu.label.sale".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: const Color(0xFF241f20)),
                                      padding: const EdgeInsets.symmetric(vertical: SizeStyle.paddingUnit * 2),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 24.0, bottom: 12),
                                          child: SizedBox(
                                            width: 130,
                                            height: 70,
                                            child: BlocBuilder<CustomerSessionBloc, CustomerSessionState>(
                                                builder: (context, state) {
                                              return ElevatedButton(
                                                onPressed: () async {
                                                  if (state.runtimeType == CustomerSessionLoadSuccess) {
                                                    showAlertWithResp(
                                                            context, "widget.appbar.label.closeCustomerSession".tr,
                                                            titleAlignment: TextAlign.center)
                                                        .then((value) {
                                                      if (value == true) {
                                                        Logger.debug(message: "close CustomerSession");
                                                        BlocProvider.of<CustomerSessionBloc>(context)
                                                            .add(CustomerSessionTerminated());
                                                        BlocProvider.of<CustomerSessionBloc>(context)
                                                            .add(CustomerSessionStarted());
                                                        showSuccessSnackBar(
                                                            context, "menu.message.alreadyCreatedCustomerSession".tr);
                                                      }
                                                    });
                                                  } else if (state.runtimeType == CustomerSessionLoadInitial) {
                                                    BlocProvider.of<CustomerSessionBloc>(context)
                                                        .add(CustomerSessionStarted());
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    fixedSize: Size(MediaQuery.of(context).size.width, 50),
                                                    backgroundColor: Theme.of(context).primaryColor),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      IconData(Icons.group_add.codePoint, fontFamily: 'MaterialIcons'),
                                                      color: ColorStyle.white,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: SizeStyle.paddingUnit),
                                                      child: Text(
                                                        'menu.button.startSession'.tr,
                                                        style: const TextStyle(fontSize: 14.0, color: ColorStyle.white),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 24.0, bottom: 12),
                                          child: SizedBox(
                                            width: 130,
                                            height: 70,
                                            child: ElevatedButton(
                                              onPressed: null,
                                              style: ElevatedButton.styleFrom(
                                                  fixedSize: Size(MediaQuery.of(context).size.width, 50),
                                                  backgroundColor: Theme.of(context).primaryColor),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    IconData(0xe18a, fontFamily: 'MaterialIcons'),
                                                    color: ColorStyle.white,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: SizeStyle.paddingUnit),
                                                    child: Text(
                                                      "menu.button.myCard".tr,
                                                      style: const TextStyle(fontSize: 14.0, color: ColorStyle.white),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                    // ...data.map((e) => GroupFeatureButtonStatelessWidget(
                                    //       items: e.features,
                                    //       title: e.name,
                                    //     ))
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    /* 金價資訊 */
                                    MyTextStatelessWidget(
                                      text: "menu.label.goldInfo".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: const Color(0xFF241f20)),
                                      padding: const EdgeInsets.symmetric(vertical: SizeStyle.paddingUnit * 2),
                                    ),
                                    /* 金價資訊 table */
                                    BlocBuilder<GoldRateBloc, GoldRateState>(builder: _goldInfoTableBuilder),
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
        )));
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
