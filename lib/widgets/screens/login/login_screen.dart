import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_poss_gp01/blocs/realm_authorized_bloc.dart';
import 'package:mobile_poss_gp01/events/realm_authorized_event.dart';
import 'package:mobile_poss_gp01/extension/string_extension.dart';
import 'package:mobile_poss_gp01/routes/custom_page_route.dart';
import 'package:mobile_poss_gp01/states/realm_authorized_state.dart';
import 'package:mobile_poss_gp01/widgets/screens/index/index_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RealmAuthorizedBloc, RealmAuthorizedState>(builder: _builder);
  }

  Widget _builder(BuildContext context, RealmAuthorizedState state) {
    Widget widget = Container();

    switch (state.runtimeType) {
      case RealmAuthorizedStateLoading:
        widget = const CircularProgressIndicator();
        break;
      case RealmAuthorizedStateError:
        widget = const Text('Something went wrong!');
        break;
      case RealmStatePermissionUnauthenticated:
        widget = ElevatedButton(
          child: Text("base.login.button.loginBtn".tr),
          onPressed: () => context.read<RealmAuthorizedBloc>().add(RealmLoginStarted()),
        );
        break;
      case RealmStatePermissionAuthenticated:
        context.read<RealmAuthorizedBloc>().add(RealmUpdateSubscriptions());
        break;
      case RealmStateSubscriptionsUpdated:
        SchedulerBinding.instance.addPostFrameCallback((_) {
          // Navigator.of(context).pushNamed("/index");
          Navigator.push(context, CustomPageRoute(builder: (context) {
            return IndexScreen();
          }));
        });
        break;
      default:
        widget = Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [widget],
        ),
      ),
    );
  }
}
