import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_poss_gp01/blocs/app_init_bloc.dart';
import 'package:mobile_poss_gp01/blocs/authentication_bloc.dart';
import 'package:mobile_poss_gp01/blocs/realm_mgmt_bloc.dart';
import 'package:mobile_poss_gp01/enum/bloc_status.dart';
import 'package:mobile_poss_gp01/events/authentication_event.dart';
import 'package:mobile_poss_gp01/events/realm_mgmt_event.dart';
import 'package:mobile_poss_gp01/extension/string_extension.dart';
import 'package:mobile_poss_gp01/repositories/authentication_repository.dart';
import 'package:mobile_poss_gp01/resources/color_style.dart';
import 'package:mobile_poss_gp01/resources/size_style.dart';
import 'package:mobile_poss_gp01/routes/custom_page_route.dart';
import 'package:mobile_poss_gp01/states/app_init_state.dart';
import 'package:mobile_poss_gp01/states/authentication_state.dart';
import 'package:mobile_poss_gp01/states/realm_mgmt_state.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';
import 'package:mobile_poss_gp01/widgets/components/my_linear_progressIndicator.dart';
import 'package:mobile_poss_gp01/widgets/screens/index/index_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                    /* 登入成功接續登入realm */
                    if (state.status == BlocStatus.loading && state.refreshTokenExisted && state.accessTokenExisted) {
                      BlocProvider.of<RealmMgmtBloc>(context).add(RealmMgmtLoginRequested());
                    }
                    /* 錯誤 */
                    if (state.status == BlocStatus.failure) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: ColorStyle.warningRed.withOpacity(0.6),
                        duration: const Duration(milliseconds: 3000),
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.3,
                          right: MediaQuery.of(context).size.width * 0.3,
                          bottom: MediaQuery.of(context).size.height - 100,
                        ),
                        content: Center(child: Text(state.error)),
                      ));
                    }
                  },
                ),
                BlocListener<RealmMgmtBloc, RealmMgmtState>(
                  listener: (context, state) {
                    if (state.runtimeType == RealmMgmtAuthenticatedSuccess) {
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
                    BlocBuilder<RealmMgmtBloc, RealmMgmtState>(builder: (BuildContext context, RealmMgmtState state) {
                      return state.runtimeType == RealmMgmtLoadInProgress
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
        widget = Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SizedBox(
              width: 400,
              height: 50,
              child: ElevatedButton.icon(
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
              ),
            ),
          ),
        ]);
        break;
      default:
        widget = Column(
          children: [
            if (state.ldapVerified)
              Container(
                padding: const EdgeInsets.only(bottom: SizeStyle.paddingUnit),
                width: 400,
                child: TextField(
                  // controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(height: 1.0),
                  onChanged: (value) {
                    context.read<AuthenticationBloc>().add(AuthenticationLDAPPasswordChanged(password: value));
                  },
                  onSubmitted: (value) => context.read<AuthenticationBloc>().add(AuthenticationLDAPLoginRequested()),
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
            SizedBox(
              width: 400,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => context
                    .read<AuthenticationBloc>()
                    .add(state.ldapVerified ? AuthenticationLDAPLoginRequested() : AuthenticationInitialed()),
                icon: const Icon(Icons.login),
                label: Text(
                  "base.login.button.loginBtn".tr,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        );
    }

    return widget;
  }
}
