import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan_mitra/src/utils/adapt_size.dart';
import 'package:kkn_siwalan_mitra/src/utils/colors.dart';
import 'package:kkn_siwalan_mitra/src/utils/form_validators.dart';
import 'package:kkn_siwalan_mitra/src/viewmodel/login_register_viewmodel.dart';
import 'package:kkn_siwalan_mitra/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan_mitra/src/viewmodel/post_product_viewmodel.dart';
import 'package:kkn_siwalan_mitra/src/widget/button_widget.dart';
import 'package:kkn_siwalan_mitra/src/widget/custom_dialogs.dart';
import 'package:kkn_siwalan_mitra/src/widget/form_field_widget.dart';
import 'package:kkn_siwalan_mitra/src/widget/horizontal_picker_widget.dart';
import 'package:kkn_siwalan_mitra/src/widget/loading_widget.dart';
import 'package:kkn_siwalan_mitra/src/widget/rich_text_widget.dart';
import 'package:kkn_siwalan_mitra/src/widget/string_radio_button.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _rt = TextEditingController();
  final TextEditingController _rw = TextEditingController();
  final TextEditingController _alamat = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _numberWA = TextEditingController();
  final ValueNotifier<String> _gender = ValueNotifier<String>('female');
  final GlobalKey<FormState> _formKey = GlobalKey();

  ValueNotifier<String> stringKelurahanLocation = ValueNotifier<String>('Test');

  @override
  void dispose() {
    super.dispose();
    _username.dispose();
    _email.dispose();
    _rt.dispose();
    _rw.dispose();
    _alamat.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _numberWA.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<PostProductViewModel>(context, listen: false);
    return Scaffold(
      body: loadingOverlayWidget(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            top: AdaptSize.paddingTop + AdaptSize.pixel24,
            right: AdaptSize.pixel8,
            left: AdaptSize.pixel8,
            bottom: AdaptSize.screenWidth / 1000 * 100,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Register',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: AdaptSize.pixel24,
                        color: MyColor.neutral500,
                      ),
                ),

                Text(
                  'Daftar untuk menjadi mitra e-siwalan',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: AdaptSize.pixel12,
                        color: MyColor.neutral500,
                      ),
                ),

                SizedBox(
                  height: AdaptSize.pixel28,
                ),

                /// username
                formFieldWidget(
                  context: context,
                  textEditingController: _username,
                  label: 'Nama Toko',
                  hint: 'Toko Ku',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  formFieldValidator: (value) =>
                      FormValidators.usernameValidate(value: _username.text),
                ),

                SizedBox(
                  height: AdaptSize.pixel14,
                ),

                /// email
                formFieldWidget(
                  context: context,
                  textEditingController: _email,
                  textInputType: TextInputType.emailAddress,
                  label: 'Email',
                  hint: 'example@gmail.com',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  formFieldValidator: (value) => FormValidators.commonValidate(
                      value: _email.text, values: 'Email'),
                ),

                SizedBox(
                  height: AdaptSize.pixel14,
                ),

                /// no wa
                formFieldWidget(
                  context: context,
                  textEditingController: _numberWA,
                  label: 'Nomor WhatsApp',
                  textInputType: TextInputType.number,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(top: AdaptSize.pixel10 + 1),
                    child: Text(
                      '+62',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: MyColor.neutral500,
                          fontSize: AdaptSize.pixel14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  hint: '8123456789',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  formFieldValidator: (value) =>
                      FormValidators.whatsAppValidate(
                    values: 'Nomor WhatsApp',
                    value: value,
                  ),
                ),

                SizedBox(
                  height: AdaptSize.pixel14,
                ),

                Text(
                  'Jenis Kelamin',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: AdaptSize.pixel14),
                ),

                SizedBox(
                  height: AdaptSize.pixel8,
                ),

                /// gender
                Row(
                  children: [
                    /// perempuan
                    stringRadioButton(
                      context: context,
                      customRadioController: _gender,
                      controlledIdValue: 'female',
                    ),
                    SizedBox(
                      width: AdaptSize.pixel8,
                    ),
                    Text(
                      'Perempuan',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: AdaptSize.pixel14),
                    ),
                    SizedBox(
                      width: AdaptSize.pixel12,
                    ),

                    /// laki laki
                    stringRadioButton(
                      context: context,
                      customRadioController: _gender,
                      controlledIdValue: 'male',
                    ),
                    SizedBox(
                      width: AdaptSize.pixel8,
                    ),
                    Text(
                      'Laki - Laki',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: AdaptSize.pixel14),
                    ),
                  ],
                ),

                SizedBox(
                  height: AdaptSize.pixel14,
                ),

                /// alamat
                formFieldWidget(
                  context: context,
                  obscureText: false,
                  textEditingController: _alamat,
                  textInputType: TextInputType.streetAddress,
                  label: 'Alamat Mitra',
                  hint: 'Jl. Jalan',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  formFieldValidator: (value) => FormValidators.commonValidate(
                      value: _alamat.text, values: 'Alamat Mitra'),
                ),

                SizedBox(
                  height: AdaptSize.pixel14,
                ),

                /// rt rw
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    formFieldWidget(
                      width: AdaptSize.screenWidth / 2.15,
                      context: context,
                      textEditingController: _rt,
                      textInputType: TextInputType.number,
                      label: 'RT',
                      hint: 'RT 01',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      formFieldValidator: (value) =>
                          FormValidators.rtrwValidate(
                              rukun: _rt.text, value: 'RT', values: 'RT'),
                    ),
                    formFieldWidget(
                      width: AdaptSize.screenWidth / 2.15,
                      context: context,
                      textEditingController: _rw,
                      textInputType: TextInputType.number,
                      label: 'RW',
                      hint: 'RW 01',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      formFieldValidator: (value) =>
                          FormValidators.rtrwValidate(
                              rukun: _rw.text, value: 'RW', values: 'RW'),
                    ),
                  ],
                ),

                SizedBox(
                  height: AdaptSize.pixel14,
                ),

                SizedBox(
                  height: AdaptSize.screenWidth / 1000 * 400,
                  width: double.infinity,
                  child: horizontalPicker(
                    context: context,
                    isSelected: stringKelurahanLocation,
                    listPicker: productProvider.locationKelurahan,
                  ),
                ),

                SizedBox(
                  height: AdaptSize.pixel14,
                ),

                /// password
                Consumer<LoginRegisterViewModel>(
                    builder: (context, value, child) {
                  return formFieldWidget(
                    context: context,
                    obscureText: value.visiblePasswordRegister,
                    textInputType: TextInputType.visiblePassword,
                    textEditingController: _password,
                    label: 'Password',
                    hint: '*********',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    formFieldValidator: (value) =>
                        FormValidators.passwordValidate(
                      password: _password.text,
                      confirmPassword: _password.text,
                      value: "Password",
                    ),
                    suffix: IconButton(
                      onPressed: () {
                        value.visibleRegister();
                      },
                      padding: EdgeInsets.zero,
                      splashRadius: .1,
                      icon: Icon(
                        value.visiblePasswordRegister
                            ? Icons.remove_red_eye_outlined
                            : Icons.visibility_off_outlined,
                        color: MyColor.warning600,
                      ),
                    ),
                  );
                }),

                SizedBox(
                  height: AdaptSize.pixel14,
                ),

                /// confrim password
                Consumer<LoginRegisterViewModel>(
                    builder: (context, value, child) {
                  return formFieldWidget(
                    context: context,
                    obscureText: value.visibleConfirmPassword,
                    textInputType: TextInputType.visiblePassword,
                    textEditingController: _confirmPassword,
                    label: 'Confirm Password',
                    hint: '********',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    formFieldValidator: (value) =>
                        FormValidators.passwordValidate(
                      confirmPassword: _confirmPassword.text,
                      password: _password.text,
                      value: "Confirm Password",
                    ),
                    suffix: IconButton(
                      onPressed: () {
                        value.visibleConfrimRegister();
                      },
                      padding: EdgeInsets.zero,
                      splashRadius: .1,
                      icon: Icon(
                        value.visibleConfirmPassword
                            ? Icons.remove_red_eye_outlined
                            : Icons.visibility_off_outlined,
                        color: MyColor.warning600,
                      ),
                    ),
                  );
                }),

                SizedBox(
                  height: AdaptSize.pixel28,
                ),

                /// button daftar
                Consumer<LoginRegisterViewModel>(
                    builder: (context, value, child) {
                  return buttonWidget(
                    sizeWidth: double.infinity,
                    sizeHeight: AdaptSize.screenWidth / 1000 * 150,
                    backgroundColor: MyColor.warning600,
                    foregroundColor: MyColor.neutral900,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (stringKelurahanLocation.value == 'Test') {
                          CustomDialogs().customDialog(
                            context: context,
                            image: 'cancel',
                            title: 'Lokasi Kelurahan Tidak Boleh Kosong',
                            textButton1: 'Kembali',
                            textButton2: '',
                            singleButton: true,
                            singleOnpressed: () {
                              Navigator.pop(context);
                            },
                            bgSingleButton: MyColor.danger400,
                          );
                          debugPrint(stringKelurahanLocation.value);
                        } else {
                          value.createUsers(
                            context: context,
                            email: _email.text,
                            password: _password.text,
                            username: _username.text,
                            jenisKelamin: _gender.value,
                            alamat: _alamat.text,
                            rt: _rt.text,
                            rw: _rw.text,
                            nomorWhatsApp: _numberWA.text,
                            kelurahan: stringKelurahanLocation.value,
                          );
                        }
                      }
                    },
                    child: value.buttonRegisterLoading
                        ? spinKitLoading(
                            color: MyColor.neutral900,
                          )
                        : Text(
                            'Daftar',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  fontSize: AdaptSize.pixel16,
                                ),
                          ),
                  );
                }),

                SizedBox(
                  height: AdaptSize.pixel75,
                ),

                /// login button
                Center(
                  child: richTextWidget(
                      text1: 'Sudah punya akun?',
                      textStyle1: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(
                              fontSize: AdaptSize.pixel12,
                              color: MyColor.neutral600),
                      text2: ' Login',
                      textStyle2:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontSize: AdaptSize.pixel12,
                                color: MyColor.warning600,
                              ),
                      recognizer2: TapGestureRecognizer()
                        ..onTap = () async {
                          NavigasiViewModel().navigateToLogin(context);
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
