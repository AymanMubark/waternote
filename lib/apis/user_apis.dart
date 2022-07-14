import 'dart:convert';

import 'package:waternote/models/users_get_response.dart';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class UserAPIS extends ApiService {
  Future<UsersGetResponse> getUsers({int page = 1}) async {
    var response = await http.get(
        Uri.parse("${ApiService.apiUrl}/users?page=$page"),
        headers: headers);
    var result = handelResponse(response);
    return UsersGetResponse.fromJson(jsonDecode(result));
  }
}
