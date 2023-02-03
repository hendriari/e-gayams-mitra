import 'dart:io';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:kkn_siwalan_mitra/src/screen/error/network_aware.dart';
import 'package:kkn_siwalan_mitra/src/screen/error/no_connection_screen.dart';
import 'package:kkn_siwalan_mitra/src/utils/adapt_size.dart';
import 'package:kkn_siwalan_mitra/src/utils/colors.dart';
import 'package:kkn_siwalan_mitra/src/utils/form_validators.dart';
import 'package:kkn_siwalan_mitra/src/viewmodel/post_product_viewmodel.dart';
import 'package:kkn_siwalan_mitra/src/viewmodel/user_viewmodel.dart';
import 'package:kkn_siwalan_mitra/src/widget/button_widget.dart';
import 'package:kkn_siwalan_mitra/src/widget/custom_dialogs.dart';
import 'package:kkn_siwalan_mitra/src/widget/default_appbar.dart';
import 'package:kkn_siwalan_mitra/src/widget/form_field_widget.dart';
import 'package:provider/provider.dart';

class PostProductScreen extends StatefulWidget {
  const PostProductScreen({Key? key}) : super(key: key);

  @override
  State<PostProductScreen> createState() => _PostProductScreenState();
}

class _PostProductScreenState extends State<PostProductScreen> {
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _manfaatController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _namaProdukController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    context.read<UserViewModel>().refreshUsers();
  }

  @override
  void dispose() {
    super.dispose();
    _deskripsiController.dispose();
    _manfaatController.dispose();
    _hargaController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postProvider =
        Provider.of<PostProductViewModel>(context, listen: false);
    final userProvider = Provider.of<UserViewModel>(context, listen: false);
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: 'Add Product',
        leading: IconButton(
          onPressed: () async {
            context.read<PostProductViewModel>().clearCategories();
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: AdaptSize.pixel20,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: NetworkAware(
        offlineChild: const NoConnectionScreen(),
        onlineChild: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: AdaptSize.pixel8,
            right: AdaptSize.pixel8,
            bottom: AdaptSize.pixel16,
            top: AdaptSize.pixel16,
          ),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// text product name
                headlineText(text: 'Nama Produk'),

                SizedBox(
                  height: AdaptSize.pixel14,
                ),

                /// product name
                formFieldWidget(
                  context: context,
                  hint: 'Nama Produk',
                  label: '',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  formFieldValidator: (deskripsi) =>
                      FormValidators.commonValidate(
                    value: deskripsi,
                    values: 'Nama Produk',
                  ),
                  textEditingController: _namaProdukController,
                ),

                SizedBox(
                  height: AdaptSize.pixel14,
                ),

                /// text foto utama
                headlineText(text: 'Foto Utama'),

                /// lead image picker
                Consumer<PostProductViewModel>(
                    builder: (context, value, child) {
                  return InkWell(
                    onTap: () {
                      value.pickLeadImage();
                    },
                    borderRadius: BorderRadius.circular(16),
                    splashColor: MyColor.neutral900,
                    child: Container(
                      height: AdaptSize.screenHeight / 1000 * 250,
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        top: AdaptSize.pixel14,
                        bottom: AdaptSize.pixel14,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: MyColor.neutral500,
                        ),
                      ),
                      child: value.images != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.file(
                                value.images!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Icon(
                              Icons.camera_alt_outlined,
                              size: AdaptSize.pixel36,
                              color: MyColor.neutral500,
                            ),
                    ),
                  );
                }),

                /// text foto lainnya
                headlineText(text: 'Foto Lainnya'),

                /// multiple image picker
                Consumer<PostProductViewModel>(
                    builder: (context, value, child) {
                  return InkWell(
                    onTap: () {
                      value.pickMultipleImage();
                      // value.pickListImage();
                    },
                    borderRadius: BorderRadius.circular(16),
                    splashColor: MyColor.neutral900,
                    child: Container(
                      height: AdaptSize.screenHeight / 1000 * 200,
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        top: AdaptSize.pixel14,
                        bottom: AdaptSize.pixel14,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: MyColor.neutral500,
                        ),
                      ),
                      child: value.multipleImage.isNotEmpty
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: value.multipleImage.length,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      EdgeInsets.only(right: AdaptSize.pixel5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.file(
                                      File(value.multipleImage[index].path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              })
                          : Icon(
                              Icons.camera_alt_outlined,
                              size: AdaptSize.pixel36,
                              color: MyColor.neutral500,
                            ),
                    ),
                  );
                }),

                /// reset foto
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Ambil Ulang',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: AdaptSize.pixel12),
                    ),
                    IconButton(
                      onPressed: () {
                        postProvider.resetMultipleImage();
                      },
                      icon: Icon(
                        Icons.restart_alt,
                        size: AdaptSize.pixel20,
                      ),
                    ),
                  ],
                ),

                /// text deskripsi
                headlineText(text: 'Deskripsi'),

                SizedBox(
                  height: AdaptSize.pixel14,
                ),

                /// deskripsi
                formFieldWidget(
                  context: context,
                  hint: 'Deskripsi',
                  label: '',
                  maxLines: 5,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  formFieldValidator: (deskripsi) =>
                      FormValidators.commonValidate(
                    value: deskripsi,
                    values: 'Deskripsi',
                  ),
                  textEditingController: _deskripsiController,
                ),

                SizedBox(
                  height: AdaptSize.pixel14,
                ),

                /// text manfaat
                headlineText(text: 'Manfaat'),

                SizedBox(
                  height: AdaptSize.pixel14,
                ),

                /// manfaat
                formFieldWidget(
                  context: context,
                  hint: 'Manfaat',
                  label: '',
                  maxLines: 5,
                  textEditingController: _manfaatController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  formFieldValidator: (manfaat) =>
                      FormValidators.commonValidate(
                    value: manfaat,
                    values: 'Manfaat',
                  ),
                ),

                SizedBox(
                  height: AdaptSize.pixel14,
                ),

                /// text harga
                headlineText(text: 'Harga'),

                SizedBox(
                  height: AdaptSize.pixel14,
                ),

                /// harga
                formFieldWidget(
                  context: context,
                  hint: 'Harga',
                  label: '',
                  textEditingController: _hargaController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  formFieldValidator: (harga) => FormValidators.commonValidate(
                    value: harga,
                    values: 'Harga',
                  ),
                  textInputFormater: [
                    CurrencyTextInputFormatter(
                        locale: 'id', decimalDigits: 0, symbol: 'Rp '),
                  ],
                  textInputType: TextInputType.number,
                ),

                SizedBox(
                  height: AdaptSize.pixel14,
                ),

                /// text kategori
                headlineText(text: 'Kategori'),

                SizedBox(
                  height: AdaptSize.pixel10,
                ),

                /// categori
                Consumer<PostProductViewModel>(
                    builder: (context, value, child) {
                  return SizedBox(
                    height: AdaptSize.screenWidth / 1000 * 140,
                    width: double.infinity,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: AdaptSize.pixel14),
                        itemCount: value.kategoriList.length,
                        itemBuilder: (context, index) {
                          final String categories = value.kategoriList[index];
                          return value.selected ==
                                  value.selectionCategory.contains(categories)
                              ? buttonWidget(
                                  onPressed: () {
                                    value.addCategories(categories);
                                    debugPrint(
                                        value.selectionCategory.toString());
                                  },
                                  backgroundColor: MyColor.neutral900,
                                  foregroundColor: MyColor.neutral900,
                                  side: BorderSide(color: MyColor.warning500),
                                  elevation: .1,
                                  borderRadius: 40,
                                  margin: EdgeInsets.only(
                                    left: AdaptSize.pixel3,
                                    right: AdaptSize.pixel3,
                                  ),
                                  child: Text(
                                    value.kategoriList[index],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontSize: AdaptSize.pixel14),
                                  ),
                                )
                              : buttonWidget(
                                  onPressed: () {
                                    value.removeCateogries(categories);
                                    debugPrint(
                                        value.selectionCategory.toString());
                                  },
                                  backgroundColor: MyColor.warning700,
                                  foregroundColor: MyColor.neutral900,
                                  side: BorderSide(color: MyColor.warning600),
                                  elevation: .1,
                                  borderRadius: 40,
                                  margin: EdgeInsets.only(
                                    left: AdaptSize.pixel3,
                                    right: AdaptSize.pixel3,
                                  ),
                                  child: Text(
                                    value.kategoriList[index],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontSize: AdaptSize.pixel14),
                                  ),
                                );
                        }),
                  );
                }),

                SizedBox(
                  height: AdaptSize.pixel16,
                ),

                /// button submit
                Consumer<PostProductViewModel>(
                    builder: (context, value, child) {
                  return buttonWidget(
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        if (postProvider.images == null &&
                            postProvider.multipleImage.isEmpty) {
                          CustomDialogs().customDialog(
                            context: context,
                            singleOnpressed: () {
                              Navigator.pop(context);
                            },
                            bgSingleButton: MyColor.danger400,
                            image: 'error',
                            title: 'Foto tidak boleh kosong !',
                            textButton1: 'Kembali',
                            textButton2: '',
                            singleButton: true,
                          );
                        } else if (postProvider.selectionCategory.isEmpty) {
                          CustomDialogs().customDialog(
                            context: context,
                            singleOnpressed: () {
                              Navigator.pop(context);
                            },
                            bgSingleButton: MyColor.danger400,
                            image: 'error',
                            title: 'Setidaknya terdapat 1 kategori produk !',
                            textButton1: 'Kembali',
                            textButton2: '',
                            singleButton: true,
                          );
                        } else {
                          value.uploadNewProduct(
                            context: context,
                            uid: userProvider.usermodel!.uid,
                            productName: _namaProdukController.text,
                            productDescrtiption: _deskripsiController.text,
                            productLocation: userProvider.usermodel!.alamat,
                            productBenefit: _manfaatController.text,
                            productPrice: _hargaController.text,
                            productCategory: postProvider.selectionCategory,
                            productRW: userProvider.usermodel!.rw,
                            productRT: userProvider.usermodel!.rt,
                            sellerName: userProvider.usermodel!.username,
                            usernameController: _namaProdukController,
                            descriptionController: _deskripsiController,
                            benefitController: _manfaatController,
                            priceController: _hargaController,
                            sellerContact:
                                userProvider.usermodel!.nomorWhatsApp,
                          );
                          debugPrint(
                            '${_manfaatController.text} ${_deskripsiController.text} ${_hargaController.text} ${postProvider.images!.path.toString()} ${postProvider.multipleImage} ${postProvider.selectionCategory.toString()} ${userProvider.usermodel!.nomorWhatsApp}',
                          );
                        }
                      }
                    },
                    backgroundColor: MyColor.warning600,
                    foregroundColor: MyColor.neutral900,
                    sizeWidth: double.infinity,
                    sizeHeight: AdaptSize.screenWidth / 1000 * 150,
                    child: value.isUpload
                        ? CircularProgressIndicator(
                            color: MyColor.neutral900,
                          )
                        : Text(
                            'Posting',
                            style: Theme.of(context)
                                .textTheme
                                .button!
                                .copyWith(fontSize: AdaptSize.pixel16),
                          ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget headlineText({
    required String text,
  }) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline6!.copyWith(
            fontSize: AdaptSize.pixel15,
          ),
    );
  }
}
