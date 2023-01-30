import 'package:flutter/cupertino.dart';
import 'package:kkn_siwalan_mitra/src/screen/auth/login_screen.dart';
import 'package:kkn_siwalan_mitra/src/screen/auth/register_screen.dart';
import 'package:kkn_siwalan_mitra/src/screen/menu/account/change_password_screen.dart';
import 'package:kkn_siwalan_mitra/src/screen/menu/menu_screen.dart';

class NavigasiViewModel {
  /// navigate to onboarding
  void navigateToOnboarding(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondAnimation) =>
              const RegisterScreen(),
          transitionsBuilder: (context, animation, secondAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
        (route) => false);
  }

  /// navigate to login
  void navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  /// navigate to login
  void navigateToRegister(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const RegisterScreen(),
      ),
    );
  }

  /// common naviagsi back
  void navigasiBack(BuildContext context) {
    Navigator.pop(context);
  }

  /// navigasi logout
  void navigasiLogout(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondAnimation) =>
              const LoginScreen(),
          transitionsBuilder: (context, animation, secondAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
        (route) => false);
  }

  /// common navigasi account menu
  void navigasiAccountMenu({
    required BuildContext context,
    required Widget route,
  }) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => route,
      ),
    );
  }

  /// forgot password
  void forgotPassword(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const ChangePasswordScreen(
          titleAppbar: 'Forgot Password',
        ),
      ),
    );
  }

  /// login
  void navigateToMenu(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoModalPopupRoute(builder: (context) => const MenuScreen()),
      (route) => false,
    );
  }
}
