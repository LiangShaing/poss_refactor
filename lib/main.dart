import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile_poss_gp01/blocs/realm_authorized_bloc.dart';
import 'package:mobile_poss_gp01/events/localization_event.dart';
import 'package:mobile_poss_gp01/i18n/localizations.dart';
import 'package:mobile_poss_gp01/observers/global_bloc_observer.dart';
import 'package:mobile_poss_gp01/repositories/realm_authorized_repository.dart';
import 'package:mobile_poss_gp01/database_objects/realm/realm_sync_dao.dart';
import 'package:mobile_poss_gp01/states/locailzation_state.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';
import 'package:mobile_poss_gp01/widgets/pages/index/index_page.dart';
import 'package:mobile_poss_gp01/widgets/pages/login/login_page.dart';
import 'package:realm/realm.dart';
import 'blocs/localization_bloc.dart';

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
        BlocProvider<LocalizationBloc>(create: (_) => LocalizationBloc()),
        BlocProvider<RealmAuthorizedBloc>(
          create: (BuildContext context) => RealmAuthorizedBloc(realmAuthorizedRepository: RealmAuthorizedRepository()),
        ),
      ],
      child: BlocBuilder<LocalizationBloc, LocalizationState>(builder: (context, state) {
        return MaterialApp(
          navigatorKey: navigationKey,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
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
                Locale _locale = Translate.getLocaleFromLocaleString(locale.toLanguageTag());
                Logger.debug(message: "localeResolutionCallback _locale : ${_locale.toString()}");
                context.read<LocalizationBloc>().add(LocalizationChanged(locale: _locale));
              });
            }
            return null;
          },
          locale: state.locale,
          initialRoute: "/",
          routes: {
            '/': (context) => const LoginPage(),
            "/index": (context) => const IndexPage(),
          },
        );
      }),
    );
  }
}
