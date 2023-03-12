import 'package:flutter/material.dart';
import 'package:kkn_siwalan_mitra/src/screen/error/network_aware.dart';
import 'package:kkn_siwalan_mitra/src/screen/error/no_connection_screen.dart';
import 'package:kkn_siwalan_mitra/src/utils/adapt_size.dart';
import 'package:kkn_siwalan_mitra/src/utils/colors.dart';
import 'package:kkn_siwalan_mitra/src/utils/form_validators.dart';
import 'package:kkn_siwalan_mitra/src/viewmodel/account_viewmodel.dart';
import 'package:kkn_siwalan_mitra/src/viewmodel/navigasi_viewmodel.dart';
import 'package:kkn_siwalan_mitra/src/viewmodel/post_product_viewmodel.dart';
import 'package:kkn_siwalan_mitra/src/viewmodel/user_viewmodel.dart';
import 'package:kkn_siwalan_mitra/src/widget/button_widget.dart';
import 'package:kkn_siwalan_mitra/src/widget/custom_dialogs.dart';
import 'package:kkn_siwalan_mitra/src/widget/default_appbar.dart';
import 'package:kkn_siwalan_mitra/src/widget/form_field_widget.dart';
import 'package:kkn_siwalan_mitra/src/widget/horizontal_picker_widget.dart';
import 'package:kkn_siwalan_mitra/src/widget/string_radio_button.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _rtController = TextEditingController();
  final TextEditingController _rwController = TextEditingController();
  final TextEditingController _noWAontroller = TextEditingController();
  final ValueNotifier<String> _gender = ValueNotifier<String>('female');
  final GlobalKey<FormState> _formKey = GlobalKey();
  ValueNotifier<String> stringKelurahanLocation = ValueNotifier<String>('Test');

  @override
  void initState() {
    super.initState();
    context.read<UserViewModel>().refreshUsers();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _alamatController.dispose();
    _rtController.dispose();
    _rwController.dispose();
    _noWAontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<UserViewModel>(context, listen: false);
    final productProvider =
        Provider.of<PostProductViewModel>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: defaultAppBar(
        context: context,
        title: 'Edit Profile',
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            NavigasiViewModel().navigasiToMenuWithIndex(
              context: context,
              index: 1,
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: AdaptSize.pixel20,
            color: Colors.black,
          ),
        ),
      ),
      body: NetworkAware(
        offlineChild: const NoConnectionScreen(),
        onlineChild: SingleChildScrollView(
          physics: const ScrollPhysics(),
          padding: EdgeInsets.only(
            left: AdaptSize.pixel8,
            right: AdaptSize.pixel8,
            top: AdaptSize.pixel16,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// username
                formFieldWidget(
                  context: context,
                  textEditingController: _usernameController,
                  label: 'Username',
                  hint: profileProvider.usermodel!.username,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  formFieldValidator: (value) =>
                      FormValidators.usernameValidate(
                          value: _usernameController.text),
                ),

                SizedBox(
                  height: AdaptSize.pixel14,
                ),

                /// no wa
                formFieldWidget(
                  context: context,
                  obscureText: false,
                  textEditingController: _noWAontroller,
                  textInputType: TextInputType.number,
                  label: 'Nomor Whatsapp',
                  hint: profileProvider.usermodel!.nomorWhatsApp,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  formFieldValidator: (value) =>
                      FormValidators.whatsAppValidate(
                          value: _noWAontroller.text, values: 'Nomor Whatsapp'),
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
                  textEditingController: _alamatController,
                  textInputType: TextInputType.streetAddress,
                  label: 'Alamat',
                  hint: profileProvider.usermodel!.alamat,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  formFieldValidator: (value) => FormValidators.commonValidate(
                      value: _alamatController.text, values: 'Alamat'),
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
                      textEditingController: _rtController,
                      textInputType: TextInputType.number,
                      label: 'RT',
                      hint: profileProvider.usermodel!.rt,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      formFieldValidator: (value) =>
                          FormValidators.rtrwValidate(
                              rukun: _rtController.text,
                              value: 'RT',
                              values: 'RT'),
                    ),
                    formFieldWidget(
                      width: AdaptSize.screenWidth / 2.15,
                      context: context,
                      textEditingController: _rwController,
                      textInputType: TextInputType.number,
                      label: 'RW',
                      hint: profileProvider.usermodel!.rw,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      formFieldValidator: (value) =>
                          FormValidators.rtrwValidate(
                              rukun: _rwController.text,
                              value: 'RW',
                              values: 'RW'),
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
                  height: AdaptSize.pixel28,
                ),

                /// button daftar
                Consumer<AccountViewModel>(builder: (context, value, child) {
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
                          value.updateUserData(
                            context: context,
                            username: _usernameController.text,
                            gender: _gender.value,
                            alamat: _alamatController.text,
                            rt: _rtController.text,
                            rw: _rwController.text,
                            kelurahan: stringKelurahanLocation.value,
                            nomorWhatsApp: _noWAontroller.text,
                          );
                        }
                      }
                    },
                    child: value.saveLoading
                        ? CircularProgressIndicator(
                            color: MyColor.neutral900,
                          )
                        : Text(
                            'Simpan',
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                  fontSize: AdaptSize.pixel16,
                                ),
                          ),
                  );
                }),

                SizedBox(
                  height: AdaptSize.pixel16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
