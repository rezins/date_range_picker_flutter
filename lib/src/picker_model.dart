import 'package:flutter/material.dart';

import 'month_item_widget.dart';

class PickerModel extends ChangeNotifier {
  late int currentIndex;
  PickerModel({required this.selectRange, required this.validRange}) {
    /// 这里为了 copy 赋值，不会修改外面的值
    selectRange =
        CustomDateTimeRange(start: selectRange.start, end: selectRange.end);
    if (selectRange.start != null) {
      selectRange.start = DateUtils.dateOnly(selectRange.start!);
    }

    if (selectRange.end != null) {
      selectRange.end = DateUtils.dateOnly(selectRange.end!);
    }

    /// 如果有选择范围，优先选择开始值；否则优先选择当前日期对应的pageIndex
    if (selectRange.start != null && selectRange.end != null) {
      pageIndex = _findIndexForDay(selectRange.start!);
    } else {
      pageIndex = _findIndexForDay(DateTime.now());
    }
    currentIndex = pageIndex;
    pageController = PageController(initialPage: pageIndex);
  }

  int _findIndexForDay(DateTime date) {
    int retIndex = 0;
    for (int index = 0;; index++) {
      final DateTime month = DateUtils.addMonthsToMonthDate(
          DateTime(validRange.start!.year, validRange.start!.month), index);
      if (month.month == date.month && month.year == date.year) {
        retIndex = index;
        break;
      }
      if (month.isAfter(validRange.end!)) {
        break;
      }
    }
    return retIndex;
  }

  CustomDateTimeRange selectRange;
  CustomDateTimeRange validRange =
      CustomDateTimeRange(start: DateTime(2020, 1), end: DateTime(2100, 12));

  int pageIndex = 1;
  PageController pageController = PageController(initialPage: 0);

  int get monthIndex {
    var res = (pageIndex + validRange.start!.month) % 12;
    return res == 0 ? 12 : res;
  }

  int get yearIndex{
    int counter = 0;
    var y = (currentIndex / 12).floor();
    if(pageIndex <= currentIndex){
      if((pageIndex / 12).floor() < y){
        counter -= (pageIndex / 12).floor();
      }
    }else{
      if((pageIndex / 12).floor() > y){
        counter += (pageIndex / 12).floor();
      }
    }
    return validRange.start!.year + counter;
}

  void dispose() {
    super.dispose();
  }

  void _vibrate() {
    // switch (Theme.of(context).platform) {
    //   case TargetPlatform.android:
    //   case TargetPlatform.fuchsia:
    //     HapticFeedback.vibrate();
    //     break;
    //   default:
    //     break;
    // }
  }

  void nextPage() {
    pageController.nextPage(
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void prevPage() {
    pageController.previousPage(
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void animateToPage(int index) {
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void updatePageIndex(int index) {
    pageIndex = index;
    notifyListeners();
  }

  void updateRange(CustomDateTimeRange range) {
    /// 这里优先跳转到当前时间的页面
    var pageIndexTmp = _findIndexForDay(DateTime.now());
    animateToPage(pageIndexTmp);
    selectRange = range;
    notifyListeners();
  }

  bool get canConfirm {
    return selectRange.start != null && selectRange.end != null;
  }

  void confirm(BuildContext context) {
    if (canConfirm) {
      Navigator.of(context).maybePop(selectRange);
    }
  }

  void cancel(BuildContext context) {
    Navigator.of(context).maybePop();
  }

  void updateSelection(DateTime date) {
    _vibrate();
    if (selectRange.start != null && selectRange.end == null) {
      // && !date.isBefore(_startDate!)
      if (!date.isBefore(selectRange.start!)) {
        selectRange.end = date;
      } else {
        selectRange.end = selectRange.start;
        selectRange.start = date;
      }
    } else {
      selectRange.start = date;
      if (selectRange.end != null) {
        selectRange.end = null;
      }
    }
    notifyListeners();
  }
}
