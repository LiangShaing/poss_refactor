import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_poss_gp01/blocs/app_init_bloc.dart';
import 'package:mobile_poss_gp01/blocs/authentication_bloc.dart';
import 'package:mobile_poss_gp01/blocs/realm_authorized_bloc.dart';
import 'package:mobile_poss_gp01/enum/bloc_status.dart';
import 'package:mobile_poss_gp01/events/authentication_event.dart';
import 'package:mobile_poss_gp01/events/realm_authorized_event.dart';
import 'package:mobile_poss_gp01/extension/string_extension.dart';
import 'package:mobile_poss_gp01/repositories/authentication_repository.dart';
import 'package:mobile_poss_gp01/resources/color_style.dart';
import 'package:mobile_poss_gp01/routes/custom_page_route.dart';
import 'package:mobile_poss_gp01/states/app_init_state.dart';
import 'package:mobile_poss_gp01/states/authentication_state.dart';
import 'package:mobile_poss_gp01/states/realm_authorized_state.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';
import 'package:mobile_poss_gp01/widgets/components/my_llnear_progressIndicator.dart';
import 'package:mobile_poss_gp01/widgets/screens/index/index_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // final AnimationController _linearIndicatorController = AnimationController(
  //   animationBehavior: AnimationBehavior.preserve,
  //   vsync: this,
  //   duration: const Duration(seconds: 20),
  // );

  // LoginScreen(){
  //   /* 進度條設定 */
  //   _linearIndicatorController
  // }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
        create: (BuildContext context) => AuthenticationBloc(authenticationRepository: AuthenticationRepository())
          ..add(AuthenticationInitialed(isAutoLogin: true)),
        child: WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: MultiBlocListener(
              listeners: [
                BlocListener<AppInitBloc, AppInitState>(listener: (context, state) {
                  if (state.runtimeType == AppInitDeepLinkCodeLoadSuccess) {
                    AppInitDeepLinkCodeLoadSuccess e = state as AppInitDeepLinkCodeLoadSuccess;
                    Logger.debug(message: "AppInitBloc AppInitDeepLinkCodeLoadSuccess [${e.code}]");
                    BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLoginRequested(code: e.code));
                  }
                }),
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state.status == BlocStatus.success) {
                      BlocProvider.of<RealmAuthorizedBloc>(context).add(RealmLoginStarted());
                    }
                  },
                ),
                BlocListener<RealmAuthorizedBloc, RealmAuthorizedState>(
                  listener: (context, state) {
                    if (state.runtimeType == RealmStatePermissionAuthenticated) {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        Navigator.push(context, CustomPageRoute(builder: (context) {
                          return IndexScreen();
                        }));
                      });
                    }
                  },
                ),
              ],
              child: Scaffold(
                body: Column(
                  children: [
                    BlocBuilder<RealmAuthorizedBloc, RealmAuthorizedState>(
                        builder: (BuildContext context, RealmAuthorizedState state) {
                      return state.runtimeType == RealmAuthorizedStateLoading
                          ? const MyLinearProgressIndicator()
                          : Container();
                    }),
                    Expanded(
                        child: Image(
                      image: const AssetImage('assets/images/CSS_logo.png'),
                      height: height * 0.3,
                    )),
                    BlocBuilder<AuthenticationBloc, AuthenticationState>(builder: _builder),
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
              ),
            )));
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
      case BlocStatus.initial:
      default:
        widget = Column(
          children: [
            if (state.refreshTokenExisted)
              SizedBox(
                width: 400,
                child: TextField(
                  // controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(height: 1.0),
                  onChanged: (value) {
                    // _password = value;
                  },
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: ColorStyle.primary, width: 1.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: ColorStyle.primary, width: 1.0),
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: ColorStyle.primary, width: 1.0),
                      ),
                      labelText: "base.login.label.ldapPwd".tr,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: const TextStyle(color: ColorStyle.primary),
                      helperStyle: const TextStyle(color: Colors.red)),
                ),
              ),
            ElevatedButton.icon(
              onPressed: () => context.read<AuthenticationBloc>().add(AuthenticationLoginRequested(code: '')),
              icon: const Icon(Icons.login),
              label: Text(
                "base.login.button.loginBtn".tr,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
              ),
            ),
          ],
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
