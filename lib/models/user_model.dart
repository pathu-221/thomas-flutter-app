class UserDataModel {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? password;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  UserDataModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json['id'] as String?,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      password: json['password'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      deletedAt: json['deletedAt'] != null
          ? DateTime.parse(json['deletedAt'] as String)
          : null,
    );
  }
}
