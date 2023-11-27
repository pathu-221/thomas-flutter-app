class ConfigModel<T> {
  bool? signatureExist;

  ConfigModel({this.signatureExist});

  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(
      signatureExist: json['signatureExist'],
    );
  }
}
