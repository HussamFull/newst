import 'package:flutter/material.dart';
import 'package:newst/core/enums/request_state_enum.dart';
import 'package:newst/core/mixins/safe_notify.dart';
import 'package:newst/features/home/model/home_model.dart';
import 'package:newst/features/home/repo/new_repo.dart';


class HomeController extends ChangeNotifier with SafeNotify {

  HomeController({  required this.newRepo}) {
    getTopHeadLine();
    getEveryThing();
  }

  bool isDisposed = false;

  RequestStateEnum topHeadlinesStatus = RequestStateEnum.loading;
  RequestStateEnum everyThingStatus = RequestStateEnum.loading;

  NewRepository newRepo ;


 List<ArticleModel>newTopHeadlines = [];
 List<ArticleModel>newEveryThing = [];

  String? errorMessage;
  String? selectedCategory;

  void getTopHeadLine({ String? category}) async {
    selectedCategory = category;
    notifyListeners();

    try {
      topHeadlinesStatus = RequestStateEnum.loading;
      notify();

      newTopHeadlines =await newRepo.getTopHeadlines(selectedCategory: selectedCategory);
      topHeadlinesStatus = RequestStateEnum.loaded;
      errorMessage = null;

    } catch (e) {
      errorMessage = e.toString();
      topHeadlinesStatus = RequestStateEnum.error;
    }

    notify();
  }

  void getEveryThing({ String? query}) async {
    notifyListeners();

    try {
      await Future.delayed( Duration(seconds: 5));
      everyThingStatus = RequestStateEnum.loading;
      notifyListeners();
      newEveryThing =await newRepo.getEveryThing(query: query);
      everyThingStatus = RequestStateEnum.loaded;
      errorMessage = null;

    } catch (e) {
      errorMessage = e.toString();
      everyThingStatus = RequestStateEnum.error;
    }

    notify();
  }

 
}


