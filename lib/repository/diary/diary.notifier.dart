import 'package:flutter/material.dart';
import '../../core/token_storage/storage.dart';
import '../../models/diary/diary.model.dart';
import '../../models/diary/search_diary.model.dart';
import 'diary.networking.dart';

class DiaryNotifier extends ChangeNotifier {
  final DiaryNetworking _diaryNetworking = DiaryNetworking();

  late DiaryModel diaryModel;
  Future getRentalDiary() async {
    try {
      LocalStorage localStorage = LocalStorage();
      final String? token = await localStorage.getToken();
      diaryModel = await _diaryNetworking.getRentalDiary(token: token!);

      return diaryModel;
    } catch (e) {
      return Future.error(e);
    }
  }

  late SearchDiaryModel searchDiaryModel;
  Future searchDiary(
      {required String startDate, required String endDate}) async {
    try {
      LocalStorage localStorage = LocalStorage();
      final String? token = await localStorage.getToken();
      searchDiaryModel = await _diaryNetworking.searchDiary(
          token: token!, startDate: startDate, endDate: endDate);

      return searchDiaryModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}
