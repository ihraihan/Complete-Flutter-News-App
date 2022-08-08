import '../services/netwroking.dart';
import 'config.dart';

Map<String, String>? categoryMap = {};

List<String> categoryNames = [];

List<int> categoryIdList = [];

void getCategory() async {
  NetworkHelper networkHelper = NetworkHelper(
      "${Config.apiURL}${Config.categoryURl}?_embed&per_page=100");

  List dataOfCategory = await networkHelper.fetchCategories();
  for (var i = 0; i < dataOfCategory.length; i++) {
    var categoryName = dataOfCategory[i]['name'];
    var categoryidNumber = dataOfCategory[i]['id'];
    categoryNames.add(categoryName);
    categoryIdList.add(categoryidNumber);

    categoryMap!["$categoryidNumber"] = categoryName;
  }
}
