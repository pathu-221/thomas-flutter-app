class EmailRecipientModel {
  String? id;
  String? recipientEmail;

  DateTime? createdAt;
  DateTime? updatedAt;

  EmailRecipientModel({
    this.id,
    this.recipientEmail,
    this.createdAt,
    this.updatedAt,
  });

  factory EmailRecipientModel.fromJson(Map json) {
    return EmailRecipientModel(
      id: json['id'],
      recipientEmail: json['recipientEmail'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
