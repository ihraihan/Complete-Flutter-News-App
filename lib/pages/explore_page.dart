import 'package:flutter/material.dart';
import 'package:newsgig/utilities/get_category.dart';
import 'package:newsgig/widgets/category_card.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<CategoryCard> categoryCards = [];

  void createListOfCategoryCard() {
    for (var i = 0; i < categoryMap!.length; i++) {
      final categoryName = categoryNames[i];
      final categoryId = categoryIdList[i];

      categoryCards.add(CategoryCard(
        categoryName: categoryName,
        number: i + 1,
        categoryId: categoryId,
      ));
    }
  }

  @override
  void initState() {
    createListOfCategoryCard();
    super.initState();
  }

  @override
  void dispose() {
    setState(() {
      categoryCards.clear();
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          child: Column(children: categoryCards),
        )),
      ),
    );
  }
}
