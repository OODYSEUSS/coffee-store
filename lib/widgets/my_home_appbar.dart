import 'package:flutter/material.dart';
import 'package:coffee_store/widgets/my_profile_image_button.dart';
import 'package:coffee_store/widgets/my_text_search_field.dart';

class MyHomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF131313),
              Color(0xFF313131),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 60, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Wake up!',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  MyProfileImageButton(),
                ],
              ),
            ),
            const SizedBox(height: 17),
            MyTextSearchField(
              hintText: 'Search coffee',
              controller: searchController,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
