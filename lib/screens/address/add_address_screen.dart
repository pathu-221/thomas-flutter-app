import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_app/main.dart';
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

  void _handleSubmit() async {
    if (!formKey.currentState!.validate()) return;
  }

  Widget _buildFormWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          controller: _countryController,
          decoration: inputDecoration(
            context,
            labelText: language.lblcountry,
          ),
        ),
        8.height,
        Row(
          children: [
            Expanded(
              child: AppTextField(
                textFieldType: TextFieldType.NAME,
                controller: _stateController,
                decoration: inputDecoration(
                  context,
                  labelText: language.lblstate,
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
        AppTextField(
          textFieldType: TextFieldType.NAME,
          controller: _companyNameController,
          decoration: inputDecoration(
            context,
            labelText: language.lblcompanyName,
          ),
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
          language.addAddress,
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
