import 'package:mobile_app/models/entertainment_receipt_model.dart';
import 'package:mobile_app/models/self_receipt_model.dart';

class ReceiptModel {
  String id;
  String userId;
  String? selfReceiptId;
  String? entertainmentReceiptId;
  EntertainmentReceiptModel? entertainmentReceipt;
  SelfReceiptModel? selfReceipt;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;

  ReceiptModel({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.selfReceipt,
    this.entertainmentReceipt,
    this.selfReceiptId,
    this.entertainmentReceiptId,
    this.deletedAt,
  });

  factory ReceiptModel.fromJson(Map<String, dynamic> json) {
    return ReceiptModel(
      id: json['id'],
      userId: json['userId'],
      selfReceiptId: json['selfReceiptId'],
      entertainmentReceiptId: json['entertainmentReceiptId'],
      entertainmentReceipt: json['entertainmentReceipt'] != null
          ? EntertainmentReceiptModel.fromJson(json['entertainmentReceipt'])
          : null,
      selfReceipt: json['selfReceipt'] != null
          ? SelfReceiptModel.fromJson(json['selfReceipt'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
