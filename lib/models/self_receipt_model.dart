class SelfReceiptModel {
  String id;
  String receiptNumber;
  double amount;
  String recipient;
  String reason;
  String? image;
  String purpose;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;

  SelfReceiptModel({
    required this.id,
    required this.receiptNumber,
    required this.amount,
    required this.recipient,
    required this.reason,
    required this.purpose,
    required this.createdAt,
    required this.updatedAt,
    this.image,
    this.deletedAt,
  });

  factory SelfReceiptModel.fromJson(Map<String, dynamic> json) {
    return SelfReceiptModel(
      id: json['id'],
      receiptNumber: json['receiptNumber'],
      amount: json['amount']?.toDouble() ?? 0.0,
      recipient: json['recipient'],
      reason: json['reason'],
      purpose: json['purpose'],
      image: json['image'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "receiptNumber": receiptNumber,
      "cateringAddres": amount,
      "recipient": recipient,
      "reason": reason,
    };
  }
}
