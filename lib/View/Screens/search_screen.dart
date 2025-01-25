import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/Controller/search_controller.dart' as sc;
import 'package:tiktok_clone/Model/user_model.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final sc.SearchController searchController = Get.put(sc.SearchController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Obx(() {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.red,
                  ),
                ),
                onFieldSubmitted: (value) => searchController.searchUser(value),
              ),
            ),
            Expanded(
                child: searchController.searchUsers.isEmpty
                    ? const Center(
                        child: Text("Search Screen"),
                      )
                    : ListView.builder(
                        itemCount: searchController.searchUsers.length,
                        itemBuilder: (context, index) {
                          User user = searchController.searchUsers[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(user.profilePhoto),
                            ),
                            title: Text(
                              user.name,
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        }))
          ],
        );
      })),
    );
  }
}
