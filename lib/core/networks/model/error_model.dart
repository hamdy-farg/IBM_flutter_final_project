import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ErrorModel {
  String message;
  int code;
  String? status;
  ErrorModel({
    required this.message,
    required this.code,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'code': code,
      'status': status,
    };
  }

  factory ErrorModel.fromMap(Map<String, dynamic> map) {
    return ErrorModel(
      message: map['message'] as String,
      code: map['code'] as int,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorModel.fromJson(String source) =>
      ErrorModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
