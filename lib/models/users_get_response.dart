import 'package:waternote/models/user.dart';

class UsersGetResponse {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<User>? users;

  UsersGetResponse({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.users,
  });

  UsersGetResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['data'] != null) {
      users = <User>[];
      json['data'].forEach((v) {
        users!.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> user = <String, dynamic>{};
    user['page'] = page;
    user['per_page'] = perPage;
    user['total'] = total;
    user['total_pages'] = totalPages;
    if (users != null) {
      user['data'] = users!.map((v) => v.toJson()).toList();
    }
    return user;
  }
}
