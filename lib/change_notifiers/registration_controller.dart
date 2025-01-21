import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tutsi/core/constants.dart';
import 'package:tutsi/core/dialogs.dart';
import 'package:tutsi/services/auth_service.dart';

class RegistrationController extends ChangeNotifier {
  bool _isRegisterMode = true;

  bool get isRegisterMode => _isRegisterMode;

  set isRegisterMode(bool value) {
    _isRegisterMode = value;
    notifyListeners();
  }

  bool _isPasswordHidden = true;

  bool get isPasswordHidden => _isPasswordHidden;

  set isPasswordHidden(bool value) {
    _isPasswordHidden = value;
    notifyListeners();
  }

  String _username = '';

  String get username => _username.trim();

  set username(String value) {
    _username = value;
    notifyListeners();
  }

  String _email = '';

  String get email => _email.trim();

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String _password = '';

  String get password => _password;

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> authenticateWithEmailAndPassword(
      {required BuildContext context}) async {
    _isLoading = true;
    try {
      if (_isRegisterMode) {
        await AuthService.register(
            username: username, email: email, password: password);

        if (!context.mounted) return;
        showMessageDialog(
            context: context,
            message:
                'A verification email was sent to the provided email address. Please confirm your email to proceed to the app');

        while (!AuthService.isEmailVerified) {
          await Future.delayed(
              Duration(seconds: 5), () => AuthService.user?.reload());
        }
      } else {
        await AuthService.login(email: email, password: password);
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      showMessageDialog(
          context: context,
          message: authExceptionMapper[e.code] ?? 'An unknown error occurred!');
    } catch (e) {
      if (!context.mounted) return;
      showMessageDialog(
          context: context, message: 'An unknown error occurred!');
    } finally {
      _isLoading = false;
    }
  }

  Future<void> authenticateWithGoogle({required BuildContext context}) async {
    try{
      await AuthService.signInWithGoogle();
    }  on NoGoogleAccountChosenException {
      return;
    } catch (e) {
      print(e.toString());
      if (!context.mounted) return;
      showMessageDialog(
          context: context, message: 'An unknown error occurred!');
    }
  }

  Future<void> resetPassword(
      {required BuildContext context, required, required String email}) async {
    _isLoading = true;
    try {
      await AuthService.resetPassword(email: email);
      if (!context.mounted) return;
      showMessageDialog(
          context: context,
          message: 'A reset password link has been sent to $email. Open the link to reset your password.');
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      showMessageDialog(
          context: context,
          message: authExceptionMapper[e.code] ?? 'An unknown error occurred!');
    } catch (e) {
      if (!context.mounted) return;
      showMessageDialog(
          context: context, message: 'An unknown error occurred!');
    } finally {
      _isLoading = false;
    }
  }
}

  class NoGoogleAccountChosenException implements Exception {
const NoGoogleAccountChosenException();
}
