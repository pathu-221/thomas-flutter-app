import 'dart:convert';

class EntertainmentReceiptModel {
  String id;
  String image;
  String cateringAddress;
  String occasion;
  List<String> entertainedPersons;
  double amount;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;

  EntertainmentReceiptModel({
    required this.id,
    required this.image,
    required this.amount,
    required this.cateringAddress,
    required this.occasion,
    required this.entertainedPersons,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory EntertainmentReceiptModel.fromJson(Map<String, dynamic> json) {
    return EntertainmentReceiptModel(
      id: json['id'],
      image: json['image'],
      cateringAddress: json['cateringAddress'],
      occasion: json['occassion'],
      entertainedPersons:
          List<String>.from(jsonDecode(json['entertainedPersons'])),
      amount: json['amount']?.toDouble() ?? 0.0,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "cateringAddres": cateringAddress,
      "occasion": occasion,
    };
  }
}
