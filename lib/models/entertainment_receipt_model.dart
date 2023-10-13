class EntertainmentReceiptModel {
  String id;
  String image;
  String cateringPlace;
  String cateringAddress;
  String occasion;
  int noOfPeople;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;

  EntertainmentReceiptModel({
    required this.id,
    required this.image,
    required this.cateringPlace,
    required this.cateringAddress,
    required this.occasion,
    required this.noOfPeople,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory EntertainmentReceiptModel.fromJson(Map<String, dynamic> json) {
    return EntertainmentReceiptModel(
      id: json['id'],
      image: json['image'],
      cateringPlace: json['cateringPlace'],
      cateringAddress: json['cateringAddres'],
      occasion: json['occasion'],
      noOfPeople: json['noOfPeople'],
      userId: json['userId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "cateringPlace": cateringPlace,
      "cateringAddres": cateringAddress,
      "occasion": occasion,
      "noOfPeople": noOfPeople,
    };
  }
}
