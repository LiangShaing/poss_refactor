import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_poss_gp01/blocs/customer_session_bloc.dart';
import 'package:mobile_poss_gp01/blocs/realm_authorized_bloc.dart';
import 'package:mobile_poss_gp01/observers/global_bloc_observer.dart';
import 'package:mobile_poss_gp01/repositories/customer_session_repository.dart';
import 'package:mobile_poss_gp01/repositories/realm_authorized_repository.dart';
import 'package:mobile_poss_gp01/resources/realm/realm_sync_dao.dart';
import 'package:mobile_poss_gp01/states/customer_session_state.dart';
import 'package:mobile_poss_gp01/widgets/pages/index/index_page.dart';
import 'package:mobile_poss_gp01/widgets/pages/login/login_page.dart';
import 'package:realm/realm.dart';

import 'events/customer_session_event.dart';

void main() async {
  Realm.logger.level = RealmLogLevel.all;
  WidgetsFlutterBinding.ensureInitialized();
  RealmSyncDao.setAppId("mobile-poss-sit-bjtiq");
  RealmSyncDao.setApiKeyCredentials("lfMqV7VzxKqLLZswpvALaldEnacjaQG31cPueHNs3ZCBL2Xg5x0zLaExl8sU6T4a");
  RealmSyncDao.setNetworkCheck(true);
  // RealmSyncDao.setRealmName("mobilePossVersion.1.0.1.realm");
  Bloc.observer = GlobalBlocObserver();
  // RealmSyncDao realmSyncDao = RealmSyncDao.instance();
  // await realmSyncDao.userLogin();
  // await realmSyncDao.createRealm();
  //
  // await realmSyncDao.updateSubscriptions();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RealmAuthorizedBloc>(
          create: (BuildContext context) => RealmAuthorizedBloc(realmAuthorizedRepository: RealmAuthorizedRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        routes: {
          '/': (context) => const LoginPage(),
          "/index": (context) => const IndexPage(),
        },
      ),
    );
  }
}


