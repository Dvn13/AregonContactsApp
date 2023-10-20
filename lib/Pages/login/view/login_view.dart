import 'package:contacts_app/Helpers/constants/application.dart';
import 'package:contacts_app/Helpers/constants/text.dart';
import 'package:contacts_app/Helpers/snackbar.dart';
import 'package:contacts_app/Pages/contacts/view/contacts_view.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/city_bloc/city_bloc.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/city_bloc/city_events.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/contacs_bloc/contacts_bloc.dart';
import 'package:contacts_app/Pages/contacts/viewmodel/contacs_bloc/contacts_events.dart';
import 'package:contacts_app/Pages/login/service/login_service.dart';
import 'package:contacts_app/Pages/login/viewmodel/login_bloc.dart';
import 'package:contacts_app/Pages/login/viewmodel/login_event.dart';
import 'package:contacts_app/Pages/login/viewmodel/login_state.dart';
import 'package:contacts_app/Widgets/custom_button.dart';
import 'package:contacts_app/Widgets/custom_textform.dart';
import 'package:contacts_app/Helpers/constants/color.dart';
import 'package:contacts_app/Helpers/constants/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Helpers/constants/project.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  //Form Key
  final GlobalKey<FormState> formKey = GlobalKey();

  // Text Editing Controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => LoginCubit(
            LoginService(
                networkManager: ProjectConstants.instance.networkManager),
            emailController,
            passwordController,
            formKey),
        child: BlocConsumer<LoginCubit, LoginState>(
          builder: (context, state) {
            return buildScaffold(context, state);
          },
          listener: (context, state) {
            if (state is LoginComplete) {
              SnackbarHelper.showSnackbar(
                  context, state.model.mesaj!, state.model.basari!);
              if (state.model.basari == 1) {
                state.navigate(context);
              }
            }
          },
        ));
  }

  Scaffold buildScaffold(BuildContext context, LoginState state) {
    emailController.text = "dvnmhmmt@gmail.com";
    passwordController.text = "29_10_1346";
    return Scaffold(
      backgroundColor: ConstColor.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: ConstPadding.paddingLarge,
              left: ConstPadding.paddingMedium,
              right: ConstPadding.paddingMedium),
          child: SizedBox(
            child: Form(
              key: formKey,
              autovalidateMode: autovalidateMode(state),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      height: 200,
                      child: Image.asset(ApplicationConstats.LOGIN_ICON)),
                  buildTextFieldEmail(),
                  buildTextFieldPassword(),
                  buildButton(context),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldPassword() {
    return CustomTextField(
      text: ConstText.sifre,
      control: passwordController,
      icon: Icons.lock_outline,
      isPassword: true,
      keyboardType: TextInputType.text,
    );
  }

  Widget buildTextFieldEmail() {
    return Padding(
      padding: const EdgeInsets.only(top: ConstPadding.paddingLarge),
      child: CustomTextField(
        text: ConstText.email,
        control: emailController,
        icon: Icons.email,
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: ConstPadding.paddingLarge),
      child: CustomButton(
        text: ConstText.loging,
        fontSize: 24,
        height: 60,
        onPressed: context.watch<LoginCubit>().isLoading
            ? () {}
            : () {
                FocusScope.of(context).requestFocus(FocusNode());
                context.read<LoginCubit>().add(Login());
              },
        isLoading: context.watch<LoginCubit>().isLoading ? true : false,
      ),
    );
  }

  AutovalidateMode autovalidateMode(LoginState state) => state
          is LoginValidateState
      ? (state.isValidate ? AutovalidateMode.always : AutovalidateMode.disabled)
      : AutovalidateMode.disabled;
}

extension LoginCompleteExtension on LoginComplete {
  void navigate(BuildContext context) {
    context.read<ContactsListBloc>().add(GetContacts());
    context.read<CitysListBloc>().add(GetCity());
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const ContactsView(),
        ),
        (Route<dynamic> route) => false);
  }
}
