import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utilities/config.dart';
import '../model/post_data.dart';
import '../utilities/wp_api_data_access.dart';
import '../widgets/news_card_skeleton.dart';
import '../widgets/shimmer_effect.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _textEditingController = TextEditingController();
  ValueNotifier<List<PostData>> searchPosts = ValueNotifier([]);
  String? searchTitle;
  bool isLoading = false;

  Future<bool> getSearchData({searchTittle}) async {
    final Uri searchesArticle =
        Uri.parse("${Config.apiURL}${Config.searchPosts}$searchTittle");
    final response = await http.get(searchesArticle);
    if (response.statusCode == 200) {
      final result = postDataFromJson(response.body);
      searchPosts.value = result;
      return true;
    }

    return false;
  }

  @override
  void dispose() {
    _textEditingController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Search"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _textEditingController,
                onSubmitted: (String value) async {
                  if (value.isNotEmpty) {
                    setState(() {
                      isLoading = true;
                    });
                    await getSearchData(searchTittle: value);
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: const Padding(
                    padding: EdgeInsetsDirectional.only(start: 16, end: 10),
                    child: Icon(
                      Icons.search,
                    ),
                  ),
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20.0)),
                  hintText: 'Searche',
                ),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: searchPosts,
                  builder: (context, posts, _) {
                    return isLoading
                        ? const ShimmerEffect(slider: false)
                        : ListView.builder(
                            itemCount: searchPosts.value.length,
                            itemBuilder: ((context, index) {
                              final postData = searchPosts.value[index];
                              Map apiData = apiDataAccess(postData);

                              return NewsCardSkeleton(
                                postId: apiData["id"],
                                link: apiData["link"],
                                title: apiData["title"],
                                imageUrl: apiData["imageUrl"],
                                content: apiData["content"],
                                date: apiData["date"],
                                avatarUrl: apiData["avatarUrl"],
                                authorName: apiData["authorName"],
                                categoryIdNumbers: apiData["categoryIdNumbers"],
                                shortDescription: apiData["shortDesc"],
                              );
                            }),
                          );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
