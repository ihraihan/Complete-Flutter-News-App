import 'package:flutter/material.dart';

import '../pages/categorywise_article_page.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {Key? key, this.categoryName, this.number, this.categoryId})
      : super(key: key);

  final String? categoryName;
  final int? number, categoryId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CategoryPosts(
              categoryName: categoryName,
              number: number,
              categoryId: categoryId,
            );
          }));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                  "assets/images/categorybackground/image$number.jpg"),
            ),
          ),
          width: double.infinity,
          height: (MediaQuery.of(context).size.height) / 6,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: const Color.fromARGB(66, 0, 0, 0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                  child: Text(
                categoryName!.toUpperCase(),
                style: const TextStyle(
                    fontSize: 20.0,
                    overflow: TextOverflow.ellipsis,
                    color: Color.fromARGB(240, 255, 255, 255),
                    fontWeight: FontWeight.bold),
              )),
            ),
          ),
        ),
      ),
    );
  }
}
