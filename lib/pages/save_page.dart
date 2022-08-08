import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../hivedb/boxes.dart';
import '../hivedb/local_db.dart';
import '../widgets/news_card_skeleton.dart';

class SavePage extends StatefulWidget {
  const SavePage({Key? key}) : super(key: key);

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<Box<SaveArticle>>(
        valueListenable: Boxes.savePosts().listenable(),
        builder: (context, box, _) {
          if (box.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: (MediaQuery.of(context).size.height) / 2.5,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/images/article_empty.png"),
                    )),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.savedSectionTitle,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    AppLocalizations.of(context)!.savedSectionMsg,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (BuildContext context, int index) {
                final saveArticle = box.getAt(index)!;
                final value = saveArticle.articleData;

                return NewsCardSkeleton(
                  index: index,
                  postId: value["postId"],
                  imageUrl: value["imageUrl"],
                  title: value["title"],
                  shortDescription: value["shortDescription"],
                  content: value["content"],
                  date: value["date"],
                  avatarUrl: value["avatarUrl"],
                  authorName: value["authorName"],
                  categoryIdNumbers: value["categoryIdNumbers"],
                );
              },
            );
          }
        },
      ),
    );
  }
}
