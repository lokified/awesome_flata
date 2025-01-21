import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tutsi/change_notifiers/registration_controller.dart';
import 'package:tutsi/core/constants.dart';
import 'package:tutsi/core/validator.dart';
import 'package:tutsi/pages/recover_password_page.dart';
import 'package:tutsi/widgets/note_button.dart';
import 'package:tutsi/widgets/note_form_field.dart';
import 'package:tutsi/widgets/note_icon_button_outlined.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late final RegistrationController registrationController;

  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    registrationController = context.read();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    formKey = GlobalKey();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Selector<RegistrationController, bool>(
              selector: (_, controller) => controller.isRegisterMode,
              builder: (_, isRegisterMode, child) => Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      isRegisterMode ? 'Register' : 'Sign In',
                      style: TextStyle(
                          color: primary,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Fredoka'),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'In order to sync your notes to the cloud, you have to register/signin to the app.',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 48,
                    ),
                    if (isRegisterMode) ...[
                      NoteFormField(
                        controller: nameController,
                        labelText: 'Username',
                        filled: true,
                        fillColor: white,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.next,
                        validator: Validator.nameValidator,
                        onChanged: (value) {
                          registrationController.username = value;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                    NoteFormField(
                      controller: emailController,
                      labelText: 'Email address',
                      filled: true,
                      fillColor: white,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: Validator.emailValidator,
                      onChanged: (value) {
                        registrationController.email = value;
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Selector<RegistrationController, bool>(
                      selector: (_, controller) => controller.isPasswordHidden,
                      builder: (_, isPasswordHidden, child) => NoteFormField(
                        controller: passwordController,
                        labelText: 'Password',
                        filled: true,
                        fillColor: white,
                        obscureText: isPasswordHidden,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            registrationController.isPasswordHidden =
                                !isPasswordHidden;
                          },
                          child: Icon(isPasswordHidden
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash),
                        ),
                        validator: Validator.passwordValidator,
                        onChanged: (value) {
                          registrationController.password = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    if (!isRegisterMode) ...[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => RecoverPasswordPage()));
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: primary, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      )
                    ],
                    SizedBox(
                      height: 48,
                      child: Selector<RegistrationController, bool>(
                        selector: (_, controller) => controller.isLoading,
                        builder: (_, isLoading, __) => NoteButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    registrationController
                                        .authenticateWithEmailAndPassword(
                                            context: context);
                                  }
                                },
                          child: isLoading
                              ? SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: white,
                                  ))
                              : Text(isRegisterMode
                                  ? 'Create my account'
                                  : 'Log me in'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(isRegisterMode
                              ? 'Or register with'
                              : 'Or sign in with'),
                        ),
                        Expanded(child: Divider())
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: NoteIconButtonOutlined(
                              icon: FontAwesomeIcons.google,
                              onPressed: () {
                                registrationController.authenticateWithGoogle(
                                    context: context);
                              }),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: NoteIconButtonOutlined(
                              icon: FontAwesomeIcons.facebook,
                              onPressed: () {}),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                            text: isRegisterMode
                                ? 'Already have an account?'
                                : 'Don\'t have an account?',
                            style: TextStyle(color: gray700),
                            children: [
                              TextSpan(
                                  text: isRegisterMode ? 'Sign in' : 'Register',
                                  style: TextStyle(
                                      color: primary,
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      registrationController.isRegisterMode =
                                          !isRegisterMode;
                                    })
                            ]))
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
