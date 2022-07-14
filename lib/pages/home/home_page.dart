import 'package:waternote/pages/home/components/home_app_bar.dart';

import '../../widgets/my_circular_progress_indicator.dart';
import '../../models/users_get_response.dart';
import 'package:flutter/material.dart';
import '../../apis/user_apis.dart';
import '../../models/user.dart';

import 'components/user_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UsersGetResponse? model;
  List<User>? users;

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  getUsers() async {
    try {
      model = await UserAPIS().getUsers();
      users = model!.users;
    } catch (e) {
      // print(e);
    }
    setState(() {});
  }

  bool isLoadingMore = false;

  getMoreUsers() async {
    if (model!.page! < model!.totalPages!) {
      setState(() {
        isLoadingMore = true;
      });
      try {
        model = await UserAPIS().getUsers(page: (model!.page! + 1));
        users!.addAll(model!.users!);
      } catch (e) {
        // print(e);
      }
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3D3963),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: HomeAppBar(),
      ),
      body: model == null
          ? const MyCircularProgressIndicator()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              itemCount: users!.length + 1,
              itemBuilder: (context, index) {
                if (index < users!.length) {
                  var user = users![index];
                  return UserCard(user: user);
                } else {
                  return Column(
                    children: [
                      !isLoadingMore
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: const Color(0xff605F99),
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                  )),
                              onPressed: () {
                                getMoreUsers();
                              },
                              child: const Text(
                                "عرض المزيد",
                              ),
                            )
                          : const MyCircularProgressIndicator(),
                    ],
                  );
                }
              },
            ),
    );
  }
}
