class Address {
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

  Address({
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

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'state': state,
      'country': country,
      'pincode': pincode,
      'companyName': companyName,
      'userId': userId,
      'logo': logo,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
