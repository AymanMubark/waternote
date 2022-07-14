import 'package:http/http.dart';

class ApiService {
  static String baseUrl = "https://reqres.in";
  static String apiUrl = "$baseUrl/api";

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  String handelResponse(Response response) {
    // print(
    //     "${response.statusCode.toString()} ${response.request!.url.toString()}");
    // print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception("server error");
    }
  }
}
