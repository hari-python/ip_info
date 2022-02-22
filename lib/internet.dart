import 'package:dio/dio.dart' as dio;
import 'constants.dart' as val;

// Request Url can be found in constansts.dart

Future getInfo() async {
  try {
    dio.Response response = await dio.Dio().get(val.url);
    return response.data;
  } catch (e) {
    return <String, dynamic>{};
  }
}
