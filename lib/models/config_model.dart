class ConfigModel<T> {
  bool? signatureExist;
  bool? addressExist;

  ConfigModel({
    this.signatureExist,
    this.addressExist,
  });

  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(
      signatureExist: json['signatureExist'],
      addressExist: json['addressExist'],
    );
  }
}
