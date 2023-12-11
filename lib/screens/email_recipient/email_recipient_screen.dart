import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/models/email_recipient_model.dart';
import 'package:mobile_app/models/http_response_model.dart';
import 'package:mobile_app/network/rest_apis/email_recipient.dart';
import 'package:mobile_app/utils/common.dart';
import 'package:mobile_app/utils/configs.dart';
import 'package:mobile_app/utils/constants.dart';
import 'package:mobile_app/widgets/loader_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class EmailRecipientScreen extends StatefulWidget {
  const EmailRecipientScreen({super.key});

  @override
  State<EmailRecipientScreen> createState() => _EmailRecipientScreenState();
}

class _EmailRecipientScreenState extends State<EmailRecipientScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _recipientEmailController =
      TextEditingController();

  void _handleSubmit() async {
    if (!formKey.currentState!.validate()) return;

    Map request = {"recipientEmail": _recipientEmailController.text};

    appStore.setLoading(true);
    HttpResponseModel? response = await addEmailRecipient(request);
    appStore.setLoading(false);

    if (response != null) {
      if (response.status == 1) {
        toast(response.msg);
        setState(() {});
        finish(context);
      } else {
        toast(response.msg);
      }
    }
  }

  void _handleDeleteEmailRecipient(EmailRecipientModel recipient) async {
    HttpResponseModel? response = await deleteEmailRecipient(recipient.id!);

    if (response != null) {
      if (response.status == 1) {
        toast(response.msg);
        setState(() {});
      } else {
        toast(response.msg);
      }
    }
  }

  void handleAddRecipient(BuildContext context) async {
    _recipientEmailController.text = '';
    showInDialog(
      context,
      contentPadding: const EdgeInsets.all(0),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            width: context.width(),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(defaultRadius),
                topRight: Radius.circular(defaultRadius),
              ),
            ),
            child: Text(
              language.addRecipient,
              style: boldTextStyle(size: 18, color: white),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: AppTextField(
                    textFieldType: TextFieldType.EMAIL,
                    controller: _recipientEmailController,
                    decoration: inputDecoration(
                      context,
                      labelText: language.emailLabel,
                    ),
                  ),
                ),
                8.height,
                AppButton(
                  width: context.width(),
                  onTap: _handleSubmit,
                  text: language.submit,
                  textColor: Colors.white,
                  color: primaryColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _noDataWidge() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.close_rounded,
            size: 80,
          ),
          16.height,
          Text(
            language.lblNoRecipients.validate(),
            style: secondaryTextStyle(size: 18),
          )
        ],
      ),
    );
  }

  Future<List<EmailRecipientModel>?> loadEmailRecipients() async {
    return fetchAllEmailRecipients();
  }

  Widget _buildEmailRecipients(
      BuildContext context, List<EmailRecipientModel> recipients) {
    return ListView.separated(
      itemCount: recipients.length,
      itemBuilder: (context, index) {
        EmailRecipientModel recipient = recipients[index];
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  recipient.recipientEmail!,
                  style: boldTextStyle(),
                ),
              ),
              IconButton(
                onPressed: () {
                  _handleDeleteEmailRecipient(recipient);
                },
                icon: const Icon(
                  Icons.delete,
                  color: dangerColor,
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: context.cardColor,
          indent: 0,
          height: 1,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              handleAddRecipient(context);
            },
          ),
        ],
        title: Text(
          language.emailRecipients,
          style: boldTextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        appStore.userEmail,
                        style: secondaryTextStyle(size: 18),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: context.cardColor,
                indent: 0,
                height: 1,
              ),
              Expanded(
                child: FutureBuilder<List<EmailRecipientModel>?>(
                  future: loadEmailRecipients(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    } else if (snapshot.hasData &&
                        snapshot.data != null &&
                        snapshot.data!.isNotEmpty) {
                      return _buildEmailRecipients(context, snapshot.data!);
                    } else if (snapshot.data == null ||
                        snapshot.data!.isEmpty) {
                      return _noDataWidge();
                    } else if (snapshot.hasError) {
                      return _noDataWidge();
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
          Observer(
            builder: (_) => const LoaderWidget().visible(appStore.isLoading),
          ),
        ],
      ),
    );
  }
}
