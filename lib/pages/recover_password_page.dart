import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutsi/change_notifiers/registration_controller.dart';
import 'package:tutsi/core/constants.dart';
import 'package:tutsi/core/validator.dart';
import 'package:tutsi/widgets/note_back_button.dart';
import 'package:tutsi/widgets/note_button.dart';
import 'package:tutsi/widgets/note_form_field.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({super.key});

  @override
  State<RecoverPasswordPage> createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  late final TextEditingController emailController;
  GlobalKey<FormFieldState> emailKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recover Password'),
        leading: NoteBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Don\'t worry! Happens to the best of us!', textAlign: TextAlign.center,),
              SizedBox(
                height: 24,
              ),
              NoteFormField(
                key: emailKey,
                controller: emailController,
                fillColor: white,
                filled: true,
                labelText: 'Email',
                validator: Validator.emailValidator,
              ),
              SizedBox(
                height: 24,
              ),
              Selector<RegistrationController, bool>(
                selector: (_, controller) => controller.isLoading,
                builder: (_, isLoading, __) => NoteButton(
                  onPressed: isLoading? null : () {
                    if (emailKey.currentState?.validate() ?? false) {
                      context.read<RegistrationController>().resetPassword(
                          context: context, email: emailController.text);
                    }
                  },
                  child: isLoading
                      ? SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: white,
                          ),
                        )
                      : Text('Send me a recovery link!'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
