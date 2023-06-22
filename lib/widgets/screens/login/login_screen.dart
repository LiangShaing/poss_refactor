import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_poss_gp01/blocs/authentication_bloc.dart';
import 'package:mobile_poss_gp01/blocs/realm_authorized_bloc.dart';
import 'package:mobile_poss_gp01/enum/bloc_status.dart';
import 'package:mobile_poss_gp01/events/authentication_event.dart';
import 'package:mobile_poss_gp01/events/realm_authorized_event.dart';
import 'package:mobile_poss_gp01/extension/string_extension.dart';
import 'package:mobile_poss_gp01/repositories/authentication_repository.dart';
import 'package:mobile_poss_gp01/routes/custom_page_route.dart';
import 'package:mobile_poss_gp01/states/authentication_state.dart';
import 'package:mobile_poss_gp01/states/realm_authorized_state.dart';
import 'package:mobile_poss_gp01/widgets/screens/index/index_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          body: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(top: 20),
              //   child: LinearProgressIndicator(
              //     value: _linearIndicatorController.value,
              //     backgroundColor: ColorStyle.white,
              //     color: ColorStyle.primary,
              //     minHeight: 8,
              //   ),
              // ),
              Expanded(
                  child: Image(
                image: const AssetImage('assets/images/CSS_logo.png'),
                height: height * 0.3,
              )),
              BlocProvider(
                  create: (BuildContext context) =>
                      AuthenticationBloc(authenticationRepository: AuthenticationRepository())
                        ..add(AuthenticationInitialed(isAutoLogin: true)),
                  child: BlocBuilder<AuthenticationBloc, AuthenticationState>(builder: _builder)),
              const Padding(
                padding: EdgeInsets.only(bottom: 10, left: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    String.fromEnvironment("VERSION", defaultValue: ""),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _builder(BuildContext context, AuthenticationState state) {
    Widget widget = Container();

    switch (state.status) {
      case BlocStatus.loading:
        widget = ElevatedButton.icon(
          onPressed: null,
          icon: Container(
            width: 24,
            height: 24,
            padding: const EdgeInsets.all(2.0),
            child: const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3,
            ),
          ),
          label: Text(
            "widget.loading.msg.loading".tr,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
          ),
        );
        break;
      case BlocStatus.failure:
        widget = const Text('Something went wrong!');
        break;
      case BlocStatus.success:
        SchedulerBinding.instance.addPostFrameCallback((_) {
          // Navigator.of(context).pushNamed("/index");
          Navigator.push(context, CustomPageRoute(builder: (context) {
            return IndexScreen();
          }));
        });
        break;
      case BlocStatus.initial:
      default:
        widget = ElevatedButton.icon(
          onPressed: () => context.read<AuthenticationBloc>().add(AuthenticationLoginRequested()),
          icon: const Icon(Icons.login),
          label: Text(
            "base.login.button.loginBtn".tr,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
          ),
        );
    }

    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: SizedBox(
          width: 400,
          height: 50,
          child: widget,
        ),
      ),
    ]);
  }
}
