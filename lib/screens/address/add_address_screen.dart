import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/models/address_model.dart';
import 'package:mobile_app/models/http_response_model.dart';
import 'package:mobile_app/network/rest_apis/address.dart';
import 'package:mobile_app/network/rest_apis/upload_receipt.dart';
import 'package:mobile_app/utils/common.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:mobile_app/widgets/loader_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  bool updateImage = false;
  String? logoUrl;
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    AddressModel? address = await fetchAddress();
    if (address == null) return;

    _addressLine1Controller.text = address.addressLine1!;
    _addressLine2Controller.text = address.addressLine2 ?? "";
    _companyNameController.text = address.companyName!;
    _countryController.text = address.country!;
    _pincodeController.text = address.pincode!;
    _stateController.text = address.state!;
    logoUrl = address.logo;
    setState(() {});
  }

  void _handleSubmit() async {
    if (!formKey.currentState!.validate()) return;

    Map request = {
      'addressLine1': _addressLine1Controller.text.validate(),
      'addressLine2': _addressLine2Controller.text.validate(),
      'state': _stateController.text.validate(),
      'country': _countryController.text.validate(),
      'pincode': _pincodeController.text.validate(),
      'companyName': _companyNameController.text.validate(),
      'updateAddress': updateImage.toString(),
    };

    appStore.setLoading(true);

    if (selectedImage == null) {
      AddressModel? data = await addAddress(request);
      appStore.setLoading(false);
      if (data != null) {
        finish(context);
      }
    } else {
      HttpResponseModel? response =
          await sendMultipartRequest(selectedImage!, '/address', request);
      if (response != null) {
        if (response.status == 1) {
          toast(response.msg);
          finish(context);
        } else {
          toast(response.msg);
        }
      }
      appStore.setLoading(false);
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.cardColor,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SettingItemWidget(
              title: language.camera,
              leading: const Icon(
                Icons.camera,
                color: primaryColor,
              ),
              onTap: () async {
                await pickImageFromCamera().then(
                  (value) {
                    if (value != null) {
                      selectedImage = File(value.path);
                      setState(() {
                        updateImage = true;
                      });
                    }
                    finish(context);
                  },
                ).catchError((error) {
                  //
                });
              },
            ),
            SettingItemWidget(
              title: language.gallery,
              leading: const Icon(
                Icons.image,
                color: primaryColor,
              ),
              onTap: () async {
                await pickImageFromGallery().then(
                  (value) {
                    if (value != null) {
                      selectedImage = File(value.path);
                      setState(() {
                        updateImage = true;
                      });
                    }
                    finish(context);
                  },
                ).catchError((error) {
                  //
                });
              },
            ),
          ],
        ).paddingAll(16);
      },
    );
  }

  Widget _imageWidget() {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: selectedImage != null
              ? Image.file(
                  selectedImage!,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  '$BASE_URL/$logoUrl',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
        ),
        Positioned(
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: primaryColor),
            child: GestureDetector(
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              onTap: () {
                setState(() {
                  selectedImage = null;
                  if (logoUrl != null && logoUrl!.isNotEmpty) {
                    logoUrl = null;
                  }
                  updateImage = true; // Remove the selected image
                });
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _buildFormWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          textFieldType: TextFieldType.NAME,
          controller: _companyNameController,
          decoration: inputDecoration(
            context,
            labelText: language.lblcompanyName,
          ),
        ),
        8.height,
        AppTextField(
          textFieldType: TextFieldType.NAME,
          controller: _addressLine1Controller,
          decoration: inputDecoration(
            context,
            labelText: language.lbladdressLine1,
          ),
        ),
        8.height,
        AppTextField(
          textFieldType: TextFieldType.NAME,
          controller: _addressLine2Controller,
          decoration: inputDecoration(
            context,
            labelText: language.lbladdressLine2,
          ),
          validator: (value) {
            if (value != null && value.isNotEmpty) {
              return null;
            }
            return null;
          },
        ),
        8.height,
        AppTextField(
          textFieldType: TextFieldType.NAME,
          controller: _stateController,
          decoration: inputDecoration(
            context,
            labelText: language.lblstate,
          ),
        ),
        8.height,
        Row(
          children: [
            Expanded(
              child: AppTextField(
                textFieldType: TextFieldType.NAME,
                controller: _countryController,
                decoration: inputDecoration(
                  context,
                  labelText: language.lblcountry,
                ),
              ),
            ),
            8.width,
            Expanded(
              child: AppTextField(
                textFieldType: TextFieldType.NAME,
                controller: _pincodeController,
                decoration: inputDecoration(
                  context,
                  labelText: language.lblpincode,
                ),
              ),
            ),
          ],
        ),
        8.height,
        Row(
          children: [
            Expanded(
              child: AppButton(
                onTap: () {
                  _showBottomSheet(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.add,
                      color: primaryColor,
                    ),
                    4.width,
                    Text(
                      selectedImage == null
                          ? language.uploadLogo
                          : language.changeLogo,
                      style: boldTextStyle(color: primaryColor),
                    ),
                  ],
                ),
              ),
            ),
            if (selectedImage != null) ...[
              8.width,
              _imageWidget(),
            ] else if (logoUrl != null && logoUrl!.isNotEmpty) ...[
              8.width,
              _imageWidget(),
            ]
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        title: Text(
          language.addressAndLogo,
          style: boldTextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 32),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildFormWidget(context),
                    16.height,
                    AppButton(
                      width: context.width(),
                      onTap: _handleSubmit,
                      text: language.submit,
                      color: primaryColor,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Observer(
            builder: (_) => const LoaderWidget().visible(appStore.isLoading),
          ),
        ],
      ),
    );
  }
}
