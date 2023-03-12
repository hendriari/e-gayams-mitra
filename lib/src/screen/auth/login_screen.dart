import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan_mitra/src/utils/adapt_size.dart';
import 'package:kkn_siwalan_mitra/src/utils/colors.dart';
import 'package:kkn_siwalan_mitra/src/utils/form_validators.dart';
import 'package:kkn_siwalan_mitra/src/viewmodel/login_register_viewmodel.dart';
import 'package:kkn_siwalan_mitra/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan_mitra/src/widget/button_widget.dart';
import 'package:kkn_siwalan_mitra/src/widget/form_field_widget.dart';
import 'package:kkn_siwalan_mitra/src/widget/loading_widget.dart';
import 'package:kkn_siwalan_mitra/src/widget/rich_text_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: loadingOverlayWidget(
        child: Padding(
          padding: EdgeInsets.only(
            top: AdaptSize.paddingTop + AdaptSize.pixel24,
            right: AdaptSize.pixel8,
            left: AdaptSize.pixel8,
            bottom: AdaptSize.screenWidth / 1000 * 100,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: AdaptSize.pixel24,
                        color: MyColor.neutral500,
                      ),
                ),
                Text(
                  'Login untuk memulai aplikasi',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: AdaptSize.pixel12,
                        color: MyColor.neutral500,
                      ),
                ),
                SizedBox(
                  height: AdaptSize.pixel24,
                ),

                /// email
                formFieldWidget(
                    context: context,
                    textEditingController: _email,
                    hint: 'example@gmail.com',
                    label: 'Email',
                    textInputType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    formFieldValidator: (value) =>
                        value == null || !EmailValidator.validate(value)
                            ? 'Masukan email yang valid'
                            : null),

                SizedBox(
                  height: AdaptSize.pixel14,
                ),

                /// password
                Consumer<LoginRegisterViewModel>(
                    builder: (context, value, child) {
                  return formFieldWidget(
                    context: context,
                    textEditingController: _password,
                    hint: 'Password',
                    label: 'Password',
                    obscureText: value.visiblePasswordLogin,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    formFieldValidator: (value) =>
                        FormValidators.passwordValidate(
                            password: _password.text,
                            confirmPassword: _password.text,
                            value: 'Password'),
                    suffix: IconButton(
                      onPressed: () {
                        value.visibleLogin();
                      },
                      splashRadius: .1,
                      icon: value.visiblePasswordLogin
                          ? const Icon(Icons.remove_red_eye_outlined)
                          : const Icon(Icons.visibility_off_outlined),
                      padding: EdgeInsets.zero,
                      color: MyColor.warning600,
                    ),
                  );
                }),

                SizedBox(
                  height: AdaptSize.pixel16,
                ),

                /// reset password
                Align(
                  alignment: Alignment.centerRight,
                  child: richTextWidget(
                      text1: 'Lupa Kata Sandi? ',
                      text2: 'Reset Passwords',
                      textStyle1: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(
                              fontSize: AdaptSize.pixel10,
                              color: MyColor.neutral600),
                      textStyle2: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(
                              fontSize: AdaptSize.pixel10,
                              color: MyColor.warning600),
                      recognizer2: TapGestureRecognizer()
                        ..onTap = () async {
                          NavigasiViewModel().forgotPassword(context);
                        }),
                ),

                SizedBox(
                  height: AdaptSize.pixel16,
                ),

                /// button login
                Consumer<LoginRegisterViewModel>(
                    builder: (context, value, child) {
                  return buttonWidget(
                    sizeWidth: double.infinity,
                    sizeHeight: AdaptSize.screenWidth / 1000 * 150,
                    backgroundColor: MyColor.warning600,
                    foregroundColor: MyColor.neutral900,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        debugPrint(_email.text);
                        value.userLogin(
                          context: context,
                          email: _email.text,
                          password: _password.text,
                        );
                      }
                    },
                    child: value.loginLoading
                        ? spinKitLoading(
                            color: MyColor.neutral900,
                          )
                        : Text(
                            'Login',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  fontSize: AdaptSize.pixel16,
                                ),
                          ),
                  );
                }),

                const Spacer(),

                /// button to register
                Center(
                  child: richTextWidget(
                      text1: 'Belum punya akun? ',
                      text2: 'Daftar',
                      textStyle1:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontSize: AdaptSize.pixel12,
                                color: MyColor.neutral600,
                              ),
                      textStyle2:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontSize: AdaptSize.pixel12,
                                color: MyColor.warning600,
                              ),
                      recognizer2: TapGestureRecognizer()
                        ..onTap = () async {
                          NavigasiViewModel().navigateToRegister(context);
                        }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
