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
import 'package:mobile_poss_gp01/widgets/containers/menu/gold_rate_table_widget.dart';
import 'package:shimmer/shimmer.dart';

/// Page: 主選單
class MenuScreen extends StatelessWidget with CommonFunction {
  const MenuScreen({super.key});



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
                                const GoldRateTableWidget()
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
