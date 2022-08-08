import 'package:flutter/material.dart';
import 'package:newsgig/utilities/constants.dart';
import 'package:newsgig/providers/theme_provider.dart';
import 'package:newsgig/widgets/home_page_body.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // Change tabs name or add tabs according to you
  static const List<Tab> tabs = <Tab>[
    Tab(child: Text("Latest")),
    Tab(child: Text("Enterprise")),
    Tab(child: Text("Entertainment")),
    Tab(child: Text("Finance")),
    Tab(child: Text("Education")),
    Tab(child: Text("Fintech")),
  ];

  // Give id number according to your category id number
  // Check categories from this url yourWebsiteUrl/wp-json/wp/v2/categories
  final List<Widget> newsCard = const [
    NewsCard(id: 0),
    NewsCard(id: 449557044),
    NewsCard(id: 18056818),
    NewsCard(id: 15835174),
    NewsCard(id: 1342),
    NewsCard(id: 577030453),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Provider.of<ThemeProvider>(context).darkTheme;
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            color: isDarkTheme ? kSecondaryColor : null,
            child: const TabBar(
              tabs: tabs,
              isScrollable: true,
              indicatorPadding: EdgeInsets.only(top: 45),
            ),
          ),
        ),
        body: TabBarView(children: newsCard),
      ),
    );
  }
}
