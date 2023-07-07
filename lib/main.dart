import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile_poss_gp01/blocs/app_mgmt_bloc.dart';
import 'package:mobile_poss_gp01/blocs/authentication_bloc.dart';
import 'package:mobile_poss_gp01/blocs/gold_rate_bloc.dart';
import 'package:mobile_poss_gp01/blocs/realm_mgmt_bloc.dart';
import 'package:mobile_poss_gp01/enum/bloc_status.dart';
import 'package:mobile_poss_gp01/events/authentication_event.dart';
import 'package:mobile_poss_gp01/events/localization_event.dart';
import 'package:mobile_poss_gp01/i18n/localizations.dart';
import 'package:mobile_poss_gp01/observers/global_bloc_observer.dart';
import 'package:mobile_poss_gp01/repositories/authentication_repository.dart';
import 'package:mobile_poss_gp01/repositories/gold_rate_repository.dart';
import 'package:mobile_poss_gp01/repositories/realm_authorized_repository.dart';
import 'package:mobile_poss_gp01/database_objects/realm/realm_sync_dao.dart';
import 'package:mobile_poss_gp01/resources/theme.dart';
import 'package:mobile_poss_gp01/routes/base/base_route.dart';
import 'package:mobile_poss_gp01/routes/generate_route.dart';
import 'package:mobile_poss_gp01/states/app_mgmt_state.dart';
import 'package:mobile_poss_gp01/states/locailzation_state.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';
import 'package:mobile_poss_gp01/widgets/components/app_life_cycle_manager_stateful_widget.dart';
import 'package:realm/realm.dart';
import 'blocs/localization_bloc.dart';
import 'events/app_mgmt_event.dart';

GlobalKey<NavigatorState> navigationKey = GlobalKey();

void main() async {
  // Realm.logger.level = RealmLogLevel.debug;
  WidgetsFlutterBinding.ensureInitialized();
  RealmSyncDao.setAppId("mobile-poss-sit-bjtiq");
  RealmSyncDao.setApiKeyCredentials("lfMqV7VzxKqLLZswpvALaldEnacjaQG31cPueHNs3ZCBL2Xg5x0zLaExl8sU6T4a");
  RealmSyncDao.setNetworkCheck(true);
  Bloc.observer = GlobalBlocObserver();
  await Translate.getSupportLocale();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AppMgmtBloc>(create: (_) => AppMgmtBloc()..add(AppMgmtInitialed())),
          // BlocProvider<LocalizationBloc>(create: (_) => LocalizationBloc()),
          BlocProvider<RealmMgmtBloc>(
            create: (BuildContext context) => RealmMgmtBloc(realmAuthorizedRepository: RealmAuthorizedRepository()),
          ),
          BlocProvider<AuthenticationBloc>(
              create: (BuildContext context) => AuthenticationBloc(authenticationRepository: AuthenticationRepository())
                ..add(AuthenticationInitialed(isAutoLogin: true))),
          BlocProvider<GoldRateBloc>(
              create: (BuildContext context) => GoldRateBloc(goldRateRepository: GoldRateRepository()))
        ],
        child: BlocBuilder<AppMgmtBloc, AppMgmtState>(builder: (context, state) {
          Widget widget;
          switch (state.status) {
            case BlocStatus.failure:
              Logger.error(message: "AppInitLoadFailure");
              exit(1);
            default:
              widget = AppLifeCycleManagerStatefulWidget(
                child: MaterialApp(
                  navigatorKey: navigationKey,
                  theme: appThemeData(context),
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    Translate.delegate,
                  ],
                  supportedLocales: Translate.supportLocale,
                  localeResolutionCallback: (locale, supportedLocales) {
                    if (locale != null) {
                      if (locale == state.locale) {
                        return null;
                      }
                      Future(() {
                        Locale lang = Translate.getLocaleFromLocaleString(locale.toLanguageTag());
                        Logger.debug(message: "localeResolutionCallback _locale : ${lang.toString()}");
                        context.read<AppMgmtBloc>().add(AppMgmtLocalizationChanged(locale: lang));
                      });
                    }
                    return null;
                  },
                  locale: state.locale,
                  // initialRoute: "/",
                  // routes: {
                  //   '/': (context) => const LoginScreen(),
                  //   "/index": (context) => const IndexScreen(),
                  //   "/pagea": (context) => const PageAScreen(),
                  //   "/pageb": (context) => const PageBScreen(),
                  // },
                  initialRoute: BaseRoute.loginScreenRouteName,
                  onGenerateRoute: (settings) {
                    return GenerateRoute.route(routeSettings: settings);
                  },
                ),
              );
              break;
          }
          return widget;
        }));
  }
}
