import 'package:newst/core/remote_source/ApiConfing.dart';
import 'package:newst/core/remote_source/api_service.dart';
import 'package:newst/features/home/model/home_model.dart';


class NewRepository {

  Future<List<ArticleModel>> getTopHeadlines({String? selectedCategory="general"}) async {
    
    Map<String, dynamic> res = await ApiService().get(ApiConfig.topHeadline, params: {
      'country': 'us',
      if (selectedCategory != null) 'category': selectedCategory,
    });
    return (res['articles'] as List).map((e) => ArticleModel.fromJson(e))
        .toList();

  }

  Future<List<ArticleModel>> getEveryThing({String? query="tesla"}) async {
    
    Map<String, dynamic> res = await ApiService().get(ApiConfig.everything, params: {
      if (query != null) 'q': query,
    });
    return (res['articles'] as List).map((e) => ArticleModel.fromJson(e))
        .toList();

  }
}