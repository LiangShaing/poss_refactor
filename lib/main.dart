import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile_poss_gp01/blocs/app_init_bloc.dart';
import 'package:mobile_poss_gp01/blocs/authentication_bloc.dart';
import 'package:mobile_poss_gp01/blocs/realm_mgmt_bloc.dart';
import 'package:mobile_poss_gp01/events/localization_event.dart';
import 'package:mobile_poss_gp01/i18n/localizations.dart';
import 'package:mobile_poss_gp01/observers/global_bloc_observer.dart';
import 'package:mobile_poss_gp01/repositories/authentication_repository.dart';
import 'package:mobile_poss_gp01/repositories/realm_authorized_repository.dart';
import 'package:mobile_poss_gp01/database_objects/realm/realm_sync_dao.dart';
import 'package:mobile_poss_gp01/resources/theme.dart';
import 'package:mobile_poss_gp01/states/app_init_state.dart';
import 'package:mobile_poss_gp01/states/locailzation_state.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';
import 'package:mobile_poss_gp01/widgets/components/app_life_cycle_manager_stateful_widget.dart';
import 'package:mobile_poss_gp01/widgets/screens/index/index_screen.dart';
import 'package:mobile_poss_gp01/widgets/screens/login/login_screen.dart';
import 'package:mobile_poss_gp01/widgets/screens/login/realm_login_screen.dart';
import 'package:realm/realm.dart';
import 'blocs/localization_bloc.dart';
import 'events/app_init_event.dart';

GlobalKey<NavigatorState> navigationKey = GlobalKey();

void main() async {
  Realm.logger.level = RealmLogLevel.debug;
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
          BlocProvider<AppInitBloc>(create: (_) => AppInitBloc()..add(AppInitStarted())),
          BlocProvider<LocalizationBloc>(create: (_) => LocalizationBloc()),
          BlocProvider<RealmMgmtBloc>(
            create: (BuildContext context) => RealmMgmtBloc(realmAuthorizedRepository: RealmAuthorizedRepository()),
          ),
          BlocProvider<AuthenticationBloc>(
              create: (BuildContext context) =>
                  AuthenticationBloc(authenticationRepository: AuthenticationRepository()))
        ],
        child: BlocBuilder<AppInitBloc, AppInitState>(builder: (context, state) {
          Widget widget;
          switch (state.runtimeType) {
            case AppInitLoadFailure:
              Logger.error(message: "AppInitLoadFailure");
              exit(1);
            default:
              widget = BlocBuilder<LocalizationBloc, LocalizationState>(builder: (context, state) {
                return AppLifeCycleManagerStatefulWidget(
                  child: MaterialApp(
                    navigatorKey: navigationKey,
                    theme: appThemeData(context),
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
                          context.read<LocalizationBloc>().add(LocalizationChanged(locale: lang));
                        });
                      }
                      return null;
                    },
                    locale: state.locale,
                    initialRoute: "/",
                    routes: {
                      '/': (context) => const LoginScreen(),
                      // '/': (context) => const RealmLoginScreen(),
                      "/index": (context) => const IndexScreen(),
                    },
                    // initialRoute: BaseRoute.loginPageRouteName,
                    // onGenerateRoute: (settings) {
                    //   return GenerateRoute.route(routeSettings: settings);
                    // },
                  ),
                );
              });
              break;
          }
          return widget;
        }));
  }
}
