import 'package:dio/dio.dart';

class RegisterDto{
  final Map<String, dynamic> request;

  RegisterDto(this.request);

  Map<String, dynamic> toJson() => {
    'request': request,
  };
}