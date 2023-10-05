class HttpResponseModel<T> {
  int? status;
  String? msg;
  T? data;

  HttpResponseModel({this.status, this.msg, this.data});

  factory HttpResponseModel.fromJson(Map<String, dynamic> json) {
    return HttpResponseModel(
      status: json['status'] as int?,
      msg: json['msg'] as String?,
      data: json['data'] as T?,
    );
  }
}
