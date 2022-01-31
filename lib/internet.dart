import 'package:dio/dio.dart' as dio;
import 'dart:convert' as convert;
import 'constants.dart' as val;

// Request Url can be found in constansts.dart

Future getInfo() async {
  dio.Response response = await dio.Dio().get(val.url);
  return response.data;
}
