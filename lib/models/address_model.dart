class AddressModel {
  String? id;
  String? addressLine1;
  String? addressLine2;
  String? state;
  String? country;
  String? pincode;
  String? companyName;
  String? userId;
  String? logo;
  DateTime? createdAt;
  DateTime? updatedAt;

  AddressModel({
    this.id,
    this.addressLine1,
    this.addressLine2,
    this.state,
    this.country,
    this.pincode,
    this.companyName,
    this.userId,
    this.logo,
    this.createdAt,
    this.updatedAt,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      addressLine1: json['addressLine1'],
      addressLine2: json['addressLine2'],
      state: json['state'],
      country: json['country'],
      pincode: json['pincode'],
      companyName: json['companyName'],
      userId: json['userId'],
      logo: json['logo'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}
