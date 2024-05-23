import 'package:flutter/material.dart';

class MyCategory extends StatefulWidget {
  const MyCategory({Key? key}) : super(key: key);

  @override
  _MyCategoryState createState() => _MyCategoryState();
}

class _MyCategoryState extends State<MyCategory> {
  String? selectedCategory = 'Coffee';

  @override
  Widget build(BuildContext context) {
    //container h50
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            MyCategoryCard(
              title: 'Coffee',
              isSelected: selectedCategory == 'Coffee',
              onTap: () {
                setState(() {
                  selectedCategory = 'Coffee';
                });
              },
            ),
            MyCategoryCard(
              title: 'Cocoa',
              isSelected: selectedCategory == 'Cocoa',
              onTap: () {
                setState(() {
                  selectedCategory = 'Cocoa';
                });
              },
            ),
            MyCategoryCard(
              title: 'Tea',
              isSelected: selectedCategory == 'Tea',
              onTap: () {
                setState(() {
                  selectedCategory = 'Tea';
                });
              },
            ),
            MyCategoryCard(
              title: 'Desserts',
              isSelected: selectedCategory == 'Desserts',
              onTap: () {
                setState(() {
                  selectedCategory = 'Desserts';
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyCategoryCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const MyCategoryCard({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 80,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isSelected
              ? Color.fromRGBO(198, 124, 78, 1.0)
              : Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
