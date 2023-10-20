import 'package:contacts_app/Helpers/sqlite.dart';
import 'package:contacts_app/Pages/login/model/login_response_model.dart';
import 'package:contacts_app/Pages/login/service/ILoginService.dart';
import 'package:contacts_app/Pages/login/viewmodel/login_event.dart';
import 'package:contacts_app/Pages/login/viewmodel/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Helpers/shared_pref.dart';

class LoginCubit extends Bloc<LoginEvent, LoginState> {
  final ILoginService loginService;

  final TextEditingController emailController;
  final TextEditingController passwordController;

  final GlobalKey<FormState> formKey;

  bool isLoginFail = false;
  bool isLoading = false;

  LoginCubit(this.loginService, this.emailController, this.passwordController,
      this.formKey)
      : super(LoginInitial()) {
    on<Login>(fetchLogin);
    on<ChangeLoading>(changeLoadingView);
  }

  Future<void> fetchLogin(LoginEvent event, Emitter<LoginState> emit) async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      isLoading = true;
      emit(LoginLoadingState(true));
      final loginResponse = await loginService.fetchLoginResponse(
          emailController.text, passwordController.text);
      isLoading = false;
      emit(LoginLoadingState(false));

      if (loginResponse is LoginResponseModel) {
        if (loginResponse.basari == 1) {
          final sqHelper = SqLiteHelper.instance;
          bool isSucces = await sqHelper.insertUser(
              emailController.text, passwordController.text);

          if (isSucces) {
            SharedPreferencesManager prefsManager =
                await SharedPreferencesManager.getInstance();
            await prefsManager.setEmail(emailController.text);
          }
        }
        emit(LoginComplete(loginResponse));
      }
    } else {
      isLoginFail = true;
      emit(LoginValidateState(isLoginFail));
    }
  }

  void changeLoadingView(ChangeLoading event, Emitter<LoginState> emit) {
    isLoading = !isLoading;
    emit(LoginLoadingState(isLoading));
  }
}
